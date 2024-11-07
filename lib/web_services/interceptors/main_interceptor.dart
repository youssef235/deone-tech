import 'package:dio/dio.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../utils/constants.dart';
import '../../utils/hive_manager.dart';
import '../http_exceptions.dart';

class MainInterceptor extends Interceptor {
  static String token = "";

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (getToken().isNotEmpty) {
      print("Bearer $token");
      options.headers["Authorization"] = "Bearer $token";
      // options.headers["Authorization"] =
      //     "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiI3IiwianRpIjoiZGRjMWZiN2QzNTZjODg2NjFiNWZjYTY5NTEwY2UzNmQ0YzUwNzNiZDczNTJiMWUyZTNhNzJmZjZlZmQ1MWVjZTYzNjI3YjAyYTE1ZDk4YmYiLCJpYXQiOjE3MDMyMzIwNjguNjU4NDUxLCJuYmYiOjE3MDMyMzIwNjguNjU4NDUyLCJleHAiOjE3MzQ4NTQ0NjguNjU1MTcyLCJzdWIiOiIxOSIsInNjb3BlcyI6W119.utSaOKGNWuoi7HP9NA0NLbUvVux_mPtOx2FRwfVIZbHhyvGL6Zl0TmND8IlXH4-izwpzmXx-Ec_bbHuKMGLjewfAJCFDFlvRjyKzYwnlJT_IXm5Ut7wIjMZSW29X9e2fPjZReZRPcS_Az9kHVmvYi64tndetF5r_rp4KSg-_tgl9ARQI7aiDqv6z-MdmS-c7RXCxyt23IwfxLiEGnN5ZqIflsiQzdSlybDQIPX8kyIq7oxZfzLsEK4n1hzFVKyfq0RvAYJ8rQgvJR8NvFB6_pgcE2G-8uSx4gknJlq6b3myCViPlHvcZVO_a-wnwByR-5ex_wizSUnHs8H6_sySi6qEwq2QXocRW6EOYpJeEfAw0az3xotPZqd0d3vEdL3xwGQrHyfsqtBeQ5loseOGRSST1QxFbfl_yEICt7tDF_XSyz0GKIzQI8dXlXPBzU1kBFqsXwochxI1OUZTJHoaxkIMqmgVvBsbmDYFTekiNRDmn8j6WlQXh9OBbl6nNHhB_rdaprdIgcnLrPAvTFMLxB38WghlM_00ddDMWd-lHpNIQ9eUDUHsJxWRsiYDCkypBu_JlsDSpdF0yPop-tfW81i4PLqJiLNY3PCSbuVDWQJlSuQOUZUogzxAdjYqiNpe3DRxfOUwhEF4houYiMkZMW0vFVXhc3cAThMFIy_fRxVs";
    }

    handler.next(options); //continue
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    throw HttpExceptions.fromDioException(err);
  }

  static getToken() {
    if (token.isNotEmpty) return token;

    final tokenData = HiveManager.getData(StorageKeys.tokenKey);

    if (tokenData != null) token = tokenData;

    return token;
  }

  static logout() {
    token = "";
  }
}
