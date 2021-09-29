import 'package:free/generated/json/base/json_convert_content.dart';

///该类注意修改 生成类
class ResListEntity<T> {
  List<T>? results;
  int? count;
  bool fromCache = false;
  int? cacheType;

  ResListEntity.fromJson(Map<String, dynamic> map)
      : results = JsonConvert.fromJsonAsT<List<T>>(map["results"]),
        count = map["count"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['results'] = results != null ? this.results!.map((v) => (v as JsonConvert).toJson()).toList() : null;
    data['count'] = count;
    return data;
  }
}
