import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:free/global/global_model.dart';
import 'package:free/utils/developer.dart';
import 'package:free/utils/oss_utils.dart';
import 'package:path_provider/path_provider.dart';
import '../config/config.dart';
import 'package:path/path.dart' as path;

///缓存的超时时间
const String _OPTIONS_CACHE_AGE = "OPTIONS_CACHE_AGE";

///缓存的类型
const String _OPTIONS_CACHE_TYPE = "OPTIONS_CACHE_TYPE";

///额外的key 最终key请求的URL + 额外的key 的md5值
const String _OPTIONS_CACHE_SUB_KEY = "OPTIONS_CACHE_SUB_KEY";

///最大超时时间
const Duration CACHE_MAX_AGE = Duration(days: 15);

///json格式化展示
const jsonFormat = false;

///开始请求的时候需不需要打印
const apiRequestLogPrint = false;
enum NetMethod {
  get,
  post,
  put,
  delete,
}

void netErrorPrint(Object e, String url, params) {
  debug(e, tag: "网络请求出错了");
  debug(url, tag: "url");
  debug(params, tag: "参数");
}

Response _checkResponse(Response<Map> response) {
  return response;
}

class DioHelper {
  static const METHOD_GET = "GET";
  static const METHOD_POST = "POST";
  static const METHOD_PUT = "PUT";
  static const METHOD_POST_FORM = "POST_FORM";

  static const _TAG = '网络';

  static final ContentType contentTypeXxxForm = ContentType.parse("application/x-www-form-urlencoded");

  static DioHelper? _instance;

  static DioHelper get() {
    if (DioHelper._instance == null) {
      DioHelper._instance = DioHelper._();
    }
    return DioHelper._instance!;
  }

  late Dio _dio;
  Dio? _ossdio;

  Dio getOssDio() {
    _ossdio = new Dio();
    // 配置dio实例
    _ossdio!.options
      ..connectTimeout = 20000
      ..receiveTimeout = 8000;
    _ossdio!.interceptors.add(InterceptorsWrapper(
        onRequest: (options, handler) {
          var Authorization = OssUtils.buildSignature(options.method, "/guuguohome/", options);
          options.headers["Authorization"] = Authorization;
          handler.next(options);
        },
        onResponse: _onResponse));
    return _ossdio!;
  }

  DioHelper._() {
    _dio = new Dio();
    // 配置dio实例
    _dio.options
      ..baseUrl = baseUrl
      ..connectTimeout = 20000
      ..receiveTimeout = 8000;

    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        // ignore: prefer_single_quotes
        final master = options.data != null ? options.data['isMasterKey'] : false;
        final time = DateTime.now().millisecond;

        ///移除isMasterKey
        if (options.data != null && options.data is Map) options.data.remove('isMasterKey');

        ///isMasterKey的时候使用masterKey
        String sign;
        if (master != null && master == true) {
          sign = '${generateMd5('$time${apiInfo['masterKey']}')},$time,master';
        } else {
          sign = '${generateMd5('$time${apiInfo['key']}')},$time';
        }
        options.headers['X-LC-Sign'] = sign;
        options.headers['X-LC-Id'] = apiInfo['appId'];
        options.headers['X-LC-Session'] = GlobalModel.get()!.user?.sessionToken ?? '';
        if (apiGetLogEnable) {
          debug('╭┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈╮');
          debug('┆ ${options.method} ┈>:  ${options.baseUrl}${options.path}');
          options.data == null ? 1 : debug('┆data ┈>:  ${options.data}');
          options.headers == null ? 1 : debug('┆headers ┈>:  ${options.headers}');
          options.queryParameters == null ? 1 : debug('┆queryParameters ┈>:  ${options.queryParameters}');
          debug('╰┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈╯');
        }
        handler.next(options);
      },
    ));
    _dio.interceptors.add(InterceptorsWrapper(onRequest: _onRequest, onResponse: _onResponse));
  }

  InterceptorSendCallback _onRequest = (opt, handler) {
    if (apiRequestLogPrint) {
      debug('request url: ${opt.uri}', tag: _TAG);
      debug('request param: ${opt.data}', tag: _TAG);
      debug('request header: ${JsonEncoder.withIndent(' ').convert(opt.headers)}', tag: _TAG);
      debug('request parameters: ${opt.queryParameters}', tag: _TAG);
    }
    handler.next(opt);
  };

  InterceptorSuccessCallback _onResponse = (response, handler) {
    final options = response.requestOptions;
    debug('╔════════════════════════════════════════════════════════════════════════════════════════════════════════╗', tag: _TAG);
    debug('║${options.method} ══>:  ${options.baseUrl}${options.path}', tag: _TAG);
    options.headers == null ? 1 : debug('║headers ══>:  ${options.headers}', tag: _TAG);
    options.queryParameters == null ? 1 : debug('║queryParameters ══>:  ${options.queryParameters}', tag: _TAG);
    options.data == null ? 1 : debug('║parameters ══>:  ${options.data}');
    debug('║══>:  ${jsonFormat ? JsonEncoder.withIndent(' ').convert(response.data) : response.data}', tag: _TAG);
    debug('╚════════════════════════════════════════════════════════════════════════════════════════════════════════╝', tag: _TAG);
    handler.next(response);
  };

  Future<String?> fetchString(String url) async {
    final res = await _dio.get<String>(url);
    return res.data;
  }

  Future<Response> download(String url, {String? savePath}) async {
    if (savePath == null) {
      savePath = await getSaveCachePath();
    }
    final res = await Dio().download(url, savePath);
    return res;
  }

  var bucket = "guuguohome";

  Future<String> uploadToOss(File image) async {
    var host = "${bucket}.oss-cn-hangzhou.aliyuncs.com";
    var url = "https://${host}";
    var fileName = path.split(image.path).last;

    var policyData = {
      "expiration": "2314-12-01T12:00:00.000Z", //必填项
      "conditions": [
        {"bucket": bucket},
      ]
    };
    var policy = base64.encode(json.encode(policyData).toBytes());
    var signature = base64.encode(Hmac(sha1, AccessKeySecret.toBytes()).convert(policy.toBytes()).bytes);
    final data = FormData.fromMap({
      "file": await MultipartFile.fromFile(
        image.path, //图片路径
        filename: fileName, //图片名称
      ),
      "key": fileName,
      "policy": policy,
      "Signature": signature,
      "OSSAccessKeyId": AccessKeyId,
    });

    ///参考 https://help.aliyun.com/document_detail/31978.html?spm=a2c4g.11186623.6.1673.50d8c2502BbrCV
    Options? options = Options(headers: {
      "x-oss-storage-class": "IA", //低频存储
      "Host": host,
      "Content-Encoding": "utf-8",
    });
    final res = await getOssDio().post(url, options: options, data: data);
    return url + "/" + fileName;
  }

  static Future<String> getSaveCachePath({String? fileName}) async =>
      path.join((await getTemporaryDirectory()).path, "guuguohome", "temp_" + (fileName ?? DateTime.now().microsecondsSinceEpoch.toString()) + ".jpg");

  /// get请求 返回future 不带缓存
  /// 不支持先获取缓存后获取 数据
  /// [T] 需要转换的模型 注意需要在[EntityFactory.generateOBJ(json)]方法中添加转换代码（有插件直接生成）
  /// [url] 请求的地址
  /// [params] 请求携带的参数
  /// [cancelToken] 当前请求关闭的标志位
  ///
  Future<Map> fetch(
    String url, {
    Map<String, dynamic>? params,
    FormData? formData,
    CancelToken? cancelToken,
    Function(int count, int total)? sendCallBack,
    Function(int count, int total)? receiveCallBack,
    NetMethod method = NetMethod.get,
    Options? options,
  }) {
    return _dioFetch(method, url, params, formData, cancelToken, sendCallBack, receiveCallBack, options).then(
      (res) => res.data ?? Map(),
    );
  }

  String convertParams2string(Map<String, dynamic> params) {
    if (params == null) {
      return "";
    }

    var stringBuffer = StringBuffer();
    params.forEach((key, value) => stringBuffer.write('${key}_$value'));
    return stringBuffer.toString();
  }

  Future<Response<Map>> _dioFetch(
    NetMethod method,
    String url,
    Map<String, dynamic>? params,
    FormData? formData,
    CancelToken? cancelToken,
    ProgressCallback? sendCallBack,
    ProgressCallback? receiveCallBack,
    Options? requestOptions,
  ) async {
    Response<Map> response;
    Future? _netRequest;
    switch (method) {
      case NetMethod.get:
        _netRequest = _dio.get<Map>(
          url,
          queryParameters: params,
          cancelToken: cancelToken,
          onReceiveProgress: receiveCallBack,
        );
        break;
      case NetMethod.post:
        _netRequest = _dio.post<Map>(
          url,
          data: params,
          cancelToken: cancelToken,
          onSendProgress: sendCallBack,
          onReceiveProgress: receiveCallBack,
          options: requestOptions,
        );

        break;
      case NetMethod.put:
        _netRequest = _dio.put<Map>(
          url,
          data: params,
          cancelToken: cancelToken,
          onSendProgress: sendCallBack,
          onReceiveProgress: receiveCallBack,
          options: requestOptions,
        );
        break;
      case NetMethod.delete:
        _netRequest = _dio.delete<Map>(
          url,
          queryParameters: params,
          cancelToken: cancelToken,
          options: requestOptions,
        );
        break;
      default:
        break;
    }
    response = (await (_netRequest?.catchError((e) {
      debug(e, tag: "网络请求出错了", stackTrace: e.stackTrace);
      debug(url, tag: "url");
      debug(params, tag: "参数");
      throw e;
    }) as FutureOr<Response<Map<dynamic, dynamic>>>))!;

    return response;
  }
}

///Generate MD5 hash
String generateMd5(String data) {
  final content = Utf8Encoder().convert(data);
  final digest = md5.convert(content);
  return hex.encode(digest.bytes);
} //
