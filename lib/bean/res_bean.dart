
import 'package:free/generated/json/base/json_convert_content.dart';

class ResListBean<T> {
  List<T> results;
  int? count;

  ResListBean.fromJsonMap(Map<String, dynamic> map)
      : results = List<T>.from(map["results"].map((it) => JsonConvert.fromJsonAsT<T>(it))),
        count = map["count"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['results'] = results != null ? this.results.map((v) => JsonConvert<T>().toJson()).toList() : null;
    data['count'] = count;
    return data;
  }
}
