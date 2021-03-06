// ignore_for_file: non_constant_identifier_names
// ignore_for_file: camel_case_types
// ignore_for_file: prefer_single_quotes

// This file is automatically generated. DO NOT EDIT, all your changes would be lost.
import 'package:free/bean/entity/user_entity.dart';
import 'package:free/generated/json/user_entity_helper.dart';
import 'package:free/bean/entity/test_entity.dart';
import 'package:free/generated/json/test_entity_helper.dart';
import 'package:free/bean/entity/auth_entity.dart';
import 'package:free/generated/json/auth_entity_helper.dart';
import 'package:free/bean/entity/auth_map_entity.dart';
import 'package:free/generated/json/auth_map_entity_helper.dart';
import 'package:free/bean/entity/role_entity.dart';
import 'package:free/generated/json/role_entity_helper.dart';
import 'package:free/bean/entity/article_entity.dart';
import 'package:free/generated/json/article_entity_helper.dart';

class JsonConvert<T> {
	T fromJson(Map<String, dynamic> json) {
		return _getFromJson<T>(runtimeType, this, json);
	}

  Map<String, dynamic> toJson() {
		return _getToJson<T>(runtimeType, this);
  }

  static _getFromJson<T>(Type type, data, json) {
		switch (type) {
			case UserEntity:
				return userEntityFromJson(data as UserEntity, json) as T;
			case TestEntity:
				return testEntityFromJson(data as TestEntity, json) as T;
			case AuthEntity:
				return authEntityFromJson(data as AuthEntity, json) as T;
			case AuthMapEntity:
				return authMapEntityFromJson(data as AuthMapEntity, json) as T;
			case RoleEntity:
				return roleEntityFromJson(data as RoleEntity, json) as T;
			case ArticleEntity:
				return articleEntityFromJson(data as ArticleEntity, json) as T;    }
		return data as T;
	}

  static _getToJson<T>(Type type, data) {
		switch (type) {
			case UserEntity:
				return userEntityToJson(data as UserEntity);
			case TestEntity:
				return testEntityToJson(data as TestEntity);
			case AuthEntity:
				return authEntityToJson(data as AuthEntity);
			case AuthMapEntity:
				return authMapEntityToJson(data as AuthMapEntity);
			case RoleEntity:
				return roleEntityToJson(data as RoleEntity);
			case ArticleEntity:
				return articleEntityToJson(data as ArticleEntity);
			}
			return data as T;
		}
  //Go back to a single instance by type
	static _fromJsonSingle<M>( json) {
		String type = M.toString();
		if(type == (UserEntity).toString()){
			return UserEntity().fromJson(json);
		}
		if(type == (TestEntity).toString()){
			return TestEntity().fromJson(json);
		}
		if(type == (AuthEntity).toString()){
			return AuthEntity().fromJson(json);
		}
		if(type == (AuthMapEntity).toString()){
			return AuthMapEntity().fromJson(json);
		}
		if(type == (RoleEntity).toString()){
			return RoleEntity().fromJson(json);
		}
		if(type == (ArticleEntity).toString()){
			return ArticleEntity().fromJson(json);
		}

		return null;
	}

  //list is returned by type
	static M _getListChildType<M>(List data) {
		if(<UserEntity>[] is M){
			return data.map<UserEntity>((e) => UserEntity().fromJson(e)).toList() as M;
		}
		if(<TestEntity>[] is M){
			return data.map<TestEntity>((e) => TestEntity().fromJson(e)).toList() as M;
		}
		if(<AuthEntity>[] is M){
			return data.map<AuthEntity>((e) => AuthEntity().fromJson(e)).toList() as M;
		}
		if(<AuthMapEntity>[] is M){
			return data.map<AuthMapEntity>((e) => AuthMapEntity().fromJson(e)).toList() as M;
		}
		if(<RoleEntity>[] is M){
			return data.map<RoleEntity>((e) => RoleEntity().fromJson(e)).toList() as M;
		}
		if(<ArticleEntity>[] is M){
			return data.map<ArticleEntity>((e) => ArticleEntity().fromJson(e)).toList() as M;
		}

		throw Exception("not found");
	}

  static M fromJsonAsT<M>(json) {
		if (json is List) {
			return _getListChildType<M>(json);
		} else {
			return _fromJsonSingle<M>(json) as M;
		}
	}
}