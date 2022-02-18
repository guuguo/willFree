import 'package:free/bean/entity/pe_entity.dart';

peEntityFromJson(PeEntity data, Map<String, dynamic> json) {
	if (json['data'] != null) {
		data.data = (json['data'] as List).map((v) => PeData().fromJson(v)).toList();
	}
	if (json['descriptions'] != null) {
		data.descriptions = (json['descriptions'] as List).map((v) => v.toString()).toList().cast<String>();
	}
	if (json['quantile'] != null) {
		data.quantile = PeQuantile().fromJson(json['quantile']);
	}
	if (json['vip'] != null) {
		data.vip = json['vip'];
	}
	return data;
}

Map<String, dynamic> peEntityToJson(PeEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['data'] =  entity.data?.map((v) => v.toJson())?.toList();
	data['descriptions'] = entity.descriptions;
	data['quantile'] = entity.quantile?.toJson();
	data['vip'] = entity.vip;
	return data;
}

peDataFromJson(PeData data, Map<String, dynamic> json) {
	if (json['id'] != null) {
		data.id = json['id'] is String
				? int.tryParse(json['id'])
				: json['id'].toInt();
	}
	if (json['market'] != null) {
		data.market = json['market'] is String
				? int.tryParse(json['market'])
				: json['market'].toInt();
	}
	if (json['close'] != null) {
		data.close = json['close'] is String
				? double.tryParse(json['close'])
				: json['close'].toDouble();
	}
	if (json['date'] != null) {
		data.date = json['date'] is String
				? int.tryParse(json['date'])
				: json['date'].toInt();
	}
	if (json['quantileInAllHistory'] != null) {
		data.quantileInAllHistory = json['quantileInAllHistory'] is String
				? int.tryParse(json['quantileInAllHistory'])
				: json['quantileInAllHistory'].toInt();
	}
	if (json['quantileInRecent10Years'] != null) {
		data.quantileInRecent10Years = json['quantileInRecent10Years'] is String
				? int.tryParse(json['quantileInRecent10Years'])
				: json['quantileInRecent10Years'].toInt();
	}
	if (json['pe'] != null) {
		data.pe = json['pe'] is String
				? double.tryParse(json['pe'])
				: json['pe'].toDouble();
	}
	return data;
}

Map<String, dynamic> peDataToJson(PeData entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['market'] = entity.market;
	data['close'] = entity.close;
	data['date'] = entity.date;
	data['quantileInAllHistory'] = entity.quantileInAllHistory;
	data['quantileInRecent10Years'] = entity.quantileInRecent10Years;
	data['pe'] = entity.pe;
	return data;
}

peQuantileFromJson(PeQuantile data, Map<String, dynamic> json) {
	if (json['quantiles'] != null) {
		data.quantiles = PeQuantileQuantiles().fromJson(json['quantiles']);
	}
	if (json['recent10YearsQuantiles'] != null) {
		data.recent10YearsQuantiles = PeQuantileRecent10YearsQuantiles().fromJson(json['recent10YearsQuantiles']);
	}
	if (json['currentQuantileInAllHistory'] != null) {
		data.currentQuantileInAllHistory = json['currentQuantileInAllHistory'] is String
				? double.tryParse(json['currentQuantileInAllHistory'])
				: json['currentQuantileInAllHistory'].toDouble();
	}
	if (json['currentQuantileInRecent10Years'] != null) {
		data.currentQuantileInRecent10Years = json['currentQuantileInRecent10Years'] is String
				? double.tryParse(json['currentQuantileInRecent10Years'])
				: json['currentQuantileInRecent10Years'].toDouble();
	}
	if (json['maxInAllHistory'] != null) {
		data.maxInAllHistory = PeQuantileMaxInAllHistory().fromJson(json['maxInAllHistory']);
	}
	if (json['minInAllHistory'] != null) {
		data.minInAllHistory = PeQuantileMinInAllHistory().fromJson(json['minInAllHistory']);
	}
	if (json['maxInRecent10Years'] != null) {
		data.maxInRecent10Years = PeQuantileMaxInRecent10Years().fromJson(json['maxInRecent10Years']);
	}
	if (json['minInRecent10Years'] != null) {
		data.minInRecent10Years = PeQuantileMinInRecent10Years().fromJson(json['minInRecent10Years']);
	}
	return data;
}

Map<String, dynamic> peQuantileToJson(PeQuantile entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['quantiles'] = entity.quantiles?.toJson();
	data['recent10YearsQuantiles'] = entity.recent10YearsQuantiles?.toJson();
	data['currentQuantileInAllHistory'] = entity.currentQuantileInAllHistory;
	data['currentQuantileInRecent10Years'] = entity.currentQuantileInRecent10Years;
	data['maxInAllHistory'] = entity.maxInAllHistory?.toJson();
	data['minInAllHistory'] = entity.minInAllHistory?.toJson();
	data['maxInRecent10Years'] = entity.maxInRecent10Years?.toJson();
	data['minInRecent10Years'] = entity.minInRecent10Years?.toJson();
	return data;
}

peQuantileQuantilesFromJson(PeQuantileQuantiles data, Map<String, dynamic> json) {
	if (json['1'] != null) {
		data.x1 = json['1'] is String
				? double.tryParse(json['1'])
				: json['1'].toDouble();
	}
	if (json['2'] != null) {
		data.x2 = json['2'] is String
				? double.tryParse(json['2'])
				: json['2'].toDouble();
	}
	if (json['3'] != null) {
		data.x3 = json['3'] is String
				? double.tryParse(json['3'])
				: json['3'].toDouble();
	}
	return data;
}

Map<String, dynamic> peQuantileQuantilesToJson(PeQuantileQuantiles entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['1'] = entity.x1;
	data['2'] = entity.x2;
	data['3'] = entity.x3;
	return data;
}

peQuantileRecent10YearsQuantilesFromJson(PeQuantileRecent10YearsQuantiles data, Map<String, dynamic> json) {
	if (json['1'] != null) {
		data.x1 = json['1'] is String
				? double.tryParse(json['1'])
				: json['1'].toDouble();
	}
	if (json['2'] != null) {
		data.x2 = json['2'] is String
				? double.tryParse(json['2'])
				: json['2'].toDouble();
	}
	if (json['3'] != null) {
		data.x3 = json['3'] is String
				? double.tryParse(json['3'])
				: json['3'].toDouble();
	}
	return data;
}

Map<String, dynamic> peQuantileRecent10YearsQuantilesToJson(PeQuantileRecent10YearsQuantiles entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['1'] = entity.x1;
	data['2'] = entity.x2;
	data['3'] = entity.x3;
	return data;
}

peQuantileMaxInAllHistoryFromJson(PeQuantileMaxInAllHistory data, Map<String, dynamic> json) {
	if (json['id'] != null) {
		data.id = json['id'] is String
				? int.tryParse(json['id'])
				: json['id'].toInt();
	}
	if (json['market'] != null) {
		data.market = json['market'] is String
				? int.tryParse(json['market'])
				: json['market'].toInt();
	}
	if (json['close'] != null) {
		data.close = json['close'] is String
				? double.tryParse(json['close'])
				: json['close'].toDouble();
	}
	if (json['date'] != null) {
		data.date = json['date'] is String
				? int.tryParse(json['date'])
				: json['date'].toInt();
	}
	if (json['quantileInAllHistory'] != null) {
		data.quantileInAllHistory = json['quantileInAllHistory'] is String
				? int.tryParse(json['quantileInAllHistory'])
				: json['quantileInAllHistory'].toInt();
	}
	if (json['quantileInRecent10Years'] != null) {
		data.quantileInRecent10Years = json['quantileInRecent10Years'] is String
				? int.tryParse(json['quantileInRecent10Years'])
				: json['quantileInRecent10Years'].toInt();
	}
	if (json['pe'] != null) {
		data.pe = json['pe'] is String
				? double.tryParse(json['pe'])
				: json['pe'].toDouble();
	}
	return data;
}

Map<String, dynamic> peQuantileMaxInAllHistoryToJson(PeQuantileMaxInAllHistory entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['market'] = entity.market;
	data['close'] = entity.close;
	data['date'] = entity.date;
	data['quantileInAllHistory'] = entity.quantileInAllHistory;
	data['quantileInRecent10Years'] = entity.quantileInRecent10Years;
	data['pe'] = entity.pe;
	return data;
}

peQuantileMinInAllHistoryFromJson(PeQuantileMinInAllHistory data, Map<String, dynamic> json) {
	if (json['id'] != null) {
		data.id = json['id'] is String
				? int.tryParse(json['id'])
				: json['id'].toInt();
	}
	if (json['market'] != null) {
		data.market = json['market'] is String
				? int.tryParse(json['market'])
				: json['market'].toInt();
	}
	if (json['close'] != null) {
		data.close = json['close'] is String
				? double.tryParse(json['close'])
				: json['close'].toDouble();
	}
	if (json['date'] != null) {
		data.date = json['date'] is String
				? int.tryParse(json['date'])
				: json['date'].toInt();
	}
	if (json['quantileInAllHistory'] != null) {
		data.quantileInAllHistory = json['quantileInAllHistory'] is String
				? int.tryParse(json['quantileInAllHistory'])
				: json['quantileInAllHistory'].toInt();
	}
	if (json['quantileInRecent10Years'] != null) {
		data.quantileInRecent10Years = json['quantileInRecent10Years'] is String
				? int.tryParse(json['quantileInRecent10Years'])
				: json['quantileInRecent10Years'].toInt();
	}
	if (json['pe'] != null) {
		data.pe = json['pe'] is String
				? double.tryParse(json['pe'])
				: json['pe'].toDouble();
	}
	return data;
}

Map<String, dynamic> peQuantileMinInAllHistoryToJson(PeQuantileMinInAllHistory entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['market'] = entity.market;
	data['close'] = entity.close;
	data['date'] = entity.date;
	data['quantileInAllHistory'] = entity.quantileInAllHistory;
	data['quantileInRecent10Years'] = entity.quantileInRecent10Years;
	data['pe'] = entity.pe;
	return data;
}

peQuantileMaxInRecent10YearsFromJson(PeQuantileMaxInRecent10Years data, Map<String, dynamic> json) {
	if (json['id'] != null) {
		data.id = json['id'] is String
				? int.tryParse(json['id'])
				: json['id'].toInt();
	}
	if (json['market'] != null) {
		data.market = json['market'] is String
				? int.tryParse(json['market'])
				: json['market'].toInt();
	}
	if (json['close'] != null) {
		data.close = json['close'] is String
				? double.tryParse(json['close'])
				: json['close'].toDouble();
	}
	if (json['date'] != null) {
		data.date = json['date'] is String
				? int.tryParse(json['date'])
				: json['date'].toInt();
	}
	if (json['quantileInAllHistory'] != null) {
		data.quantileInAllHistory = json['quantileInAllHistory'] is String
				? int.tryParse(json['quantileInAllHistory'])
				: json['quantileInAllHistory'].toInt();
	}
	if (json['quantileInRecent10Years'] != null) {
		data.quantileInRecent10Years = json['quantileInRecent10Years'] is String
				? int.tryParse(json['quantileInRecent10Years'])
				: json['quantileInRecent10Years'].toInt();
	}
	if (json['pe'] != null) {
		data.pe = json['pe'] is String
				? double.tryParse(json['pe'])
				: json['pe'].toDouble();
	}
	return data;
}

Map<String, dynamic> peQuantileMaxInRecent10YearsToJson(PeQuantileMaxInRecent10Years entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['market'] = entity.market;
	data['close'] = entity.close;
	data['date'] = entity.date;
	data['quantileInAllHistory'] = entity.quantileInAllHistory;
	data['quantileInRecent10Years'] = entity.quantileInRecent10Years;
	data['pe'] = entity.pe;
	return data;
}

peQuantileMinInRecent10YearsFromJson(PeQuantileMinInRecent10Years data, Map<String, dynamic> json) {
	if (json['id'] != null) {
		data.id = json['id'] is String
				? int.tryParse(json['id'])
				: json['id'].toInt();
	}
	if (json['market'] != null) {
		data.market = json['market'] is String
				? int.tryParse(json['market'])
				: json['market'].toInt();
	}
	if (json['close'] != null) {
		data.close = json['close'] is String
				? double.tryParse(json['close'])
				: json['close'].toDouble();
	}
	if (json['date'] != null) {
		data.date = json['date'] is String
				? int.tryParse(json['date'])
				: json['date'].toInt();
	}
	if (json['quantileInAllHistory'] != null) {
		data.quantileInAllHistory = json['quantileInAllHistory'] is String
				? int.tryParse(json['quantileInAllHistory'])
				: json['quantileInAllHistory'].toInt();
	}
	if (json['quantileInRecent10Years'] != null) {
		data.quantileInRecent10Years = json['quantileInRecent10Years'] is String
				? int.tryParse(json['quantileInRecent10Years'])
				: json['quantileInRecent10Years'].toInt();
	}
	if (json['pe'] != null) {
		data.pe = json['pe'] is String
				? double.tryParse(json['pe'])
				: json['pe'].toDouble();
	}
	return data;
}

Map<String, dynamic> peQuantileMinInRecent10YearsToJson(PeQuantileMinInRecent10Years entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['market'] = entity.market;
	data['close'] = entity.close;
	data['date'] = entity.date;
	data['quantileInAllHistory'] = entity.quantileInAllHistory;
	data['quantileInRecent10Years'] = entity.quantileInRecent10Years;
	data['pe'] = entity.pe;
	return data;
}