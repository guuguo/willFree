import 'package:free/generated/json/base/json_convert_content.dart';
import 'package:free/generated/json/base/json_field.dart';

class PeEntity with JsonConvert<PeEntity> {
	List<PeData>? data;
	List<String>? descriptions;
	PeQuantile? quantile;
	bool? vip;
}

class PeData with JsonConvert<PeData> {
	int? id;
	int? market;
	double? close;
	int? date;
	int? quantileInAllHistory;
	int? quantileInRecent10Years;
	double? pe;
}

class PeQuantile with JsonConvert<PeQuantile> {
	PeQuantileQuantiles? quantiles;
	PeQuantileRecent10YearsQuantiles? recent10YearsQuantiles;
	double? currentQuantileInAllHistory;
	double? currentQuantileInRecent10Years;
	PeQuantileMaxInAllHistory? maxInAllHistory;
	PeQuantileMinInAllHistory? minInAllHistory;
	PeQuantileMaxInRecent10Years? maxInRecent10Years;
	PeQuantileMinInRecent10Years? minInRecent10Years;
}

class PeQuantileQuantiles with JsonConvert<PeQuantileQuantiles> {
	@JSONField(name: "1")
	double? x1;
	@JSONField(name: "2")
	double? x2;
	@JSONField(name: "3")
	double? x3;
}

class PeQuantileRecent10YearsQuantiles with JsonConvert<PeQuantileRecent10YearsQuantiles> {
	@JSONField(name: "1")
	double? x1;
	@JSONField(name: "2")
	double? x2;
	@JSONField(name: "3")
	double? x3;
}

class PeQuantileMaxInAllHistory with JsonConvert<PeQuantileMaxInAllHistory> {
	int? id;
	int? market;
	double? close;
	int? date;
	int? quantileInAllHistory;
	int? quantileInRecent10Years;
	double? pe;
}

class PeQuantileMinInAllHistory with JsonConvert<PeQuantileMinInAllHistory> {
	int? id;
	int? market;
	double? close;
	int? date;
	int? quantileInAllHistory;
	int? quantileInRecent10Years;
	double? pe;
}

class PeQuantileMaxInRecent10Years with JsonConvert<PeQuantileMaxInRecent10Years> {
	int? id;
	int? market;
	double? close;
	int? date;
	int? quantileInAllHistory;
	int? quantileInRecent10Years;
	double? pe;
}

class PeQuantileMinInRecent10Years with JsonConvert<PeQuantileMinInRecent10Years> {
	int? id;
	int? market;
	double? close;
	int? date;
	int? quantileInAllHistory;
	int? quantileInRecent10Years;
	double? pe;
}
