import 'dart:convert';

import 'package:http/http.dart';
import 'package:shopware_sdk/shopware_sdk.dart';

abstract class BaseResource<T> {
  BaseClient client;

  String _queryPath;

  String get queryPath => _queryPath;

  set queryPath(String queryPath) {
    _queryPath = queryPath;
  }

  BaseResource(this.client);

  /**
   * Finds all entities.
   */
  Future<ApiResponse<T>> findAll({Map<String, String> headers}) =>
      client.get(queryPath, headers: headers).then((response) {
        var apiResponse = ApiResponse<T>.fromJson(json.decode(response.body));
        apiResponse.baseResponse = response;
        return apiResponse;
      });

  /**
   * Finds entity by its id.
   *
   */
  Future<ApiResponse<T>> findOne(int id, {Map<String, String> headers}) =>
      client.get('$queryPath/$id', headers: headers).then((response) {
        var apiResponse = ApiResponse<T>.fromJson(json.decode(response.body));
        apiResponse.baseResponse = response;
        return apiResponse;
      });
}


