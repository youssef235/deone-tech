import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:wasq_tech/web_services/http_client.dart';

import 'models/error_response.dart';

class HttpExceptions implements Exception {

  sendSlackMessage(String messageText) {
    // var url =
    //     'https://hooks.slack.com/services/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';
    //
    // var request = {
    //   'text': messageText,
    // };
    //
    // HttpClient.dio.post(url, data: request).then((response) {
    //   debugPrint("The Response Data Is : ${response.data}");
    // });
  }
  HttpExceptions.fromDioException(DioException dioException) {
    switch (dioException.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.connectionError:
      case DioExceptionType.badCertificate:
      sendSlackMessage("Tech ===========================================\n# endpoint : ${dioException.response!.realUri.toString()} \n# status code : ${dioException.response!.statusCode}\n# error message : ${dioException.message} \n# Response : ${dioException.response!.data.toString()}\n==================\n");

      throw DeadlineExceededException(dioException.requestOptions);
      case DioExceptionType.badResponse:
        switch (dioException.response?.statusCode) {
          case 400:
          case 422:
          sendSlackMessage("Tech ===========================================\n# endpoint : ${dioException.response!.realUri.toString()} \n# status code : ${dioException.response!.statusCode}\n# error message : ${dioException.message} \n# Response : ${dioException.response!.data.toString()}\n==================\n");

          throw BadRequestException(
                dioException.requestOptions, dioException.response);
          case 401:
          case 403:
          sendSlackMessage("Tech ===========================================\n# endpoint : ${dioException.response!.realUri.toString()} \n# status code : ${dioException.response!.statusCode}\n# error message : ${dioException.message} \n# Response : ${dioException.response!.data.toString()}\n==================\n");

          throw UnauthorizedException(
                dioException.requestOptions, dioException.response);
          case 404:
            sendSlackMessage("Tech ===========================================\n# endpoint : ${dioException.response!.realUri.toString()} \n# status code : ${dioException.response!.statusCode}\n# error message : ${dioException.message} \n# Response : ${dioException.response!.data.toString()}\n==================\n");

            throw NotFoundException(
                dioException.requestOptions, dioException.response);
          case 409:
            sendSlackMessage("Tech ===========================================\n# endpoint : ${dioException.response!.realUri.toString()} \n# status code : ${dioException.response!.statusCode}\n# error message : ${dioException.message} \n# Response : ${dioException.response!.data.toString()}\n==================\n");

            throw ConflictException(
                dioException.requestOptions, dioException.response);
          case 500:
            sendSlackMessage("Tech ===========================================\n# endpoint : ${dioException.response!.realUri.toString()} \n# status code : ${dioException.response!.statusCode}\n# error message : ${dioException.message} \n# Response : ${dioException.response!.data.toString()}\n==================\n");

            throw InternalServerErrorException(
                dioException.requestOptions, dioException.response);


          default :
            sendSlackMessage("Tech ===========================================\n# endpoint : ${dioException.response!.realUri.toString()} \n# status code : ${dioException.response!.statusCode}\n# error message : ${dioException.message} \n# Response : ${dioException.response!.data.toString()}\n==================\n");


        }
        break;
      case DioExceptionType.cancel:
        break;
      case DioExceptionType.unknown:
        sendSlackMessage("Tech ===========================================\n# endpoint : ${dioException.response!.realUri.toString()} \n# status code : ${dioException.response!.statusCode}\n# error message : ${dioException.message} \n# Response : ${dioException.response!.data.toString()}\n==================\n");

        throw NoInternetConnectionException(dioException.requestOptions);
    }
  }
}

class BadRequestException extends DioException {
  BadRequestException(RequestOptions r, Response? response)
      : super(requestOptions: r, response: response);

  @override
  String toString() {
    try {
      String? msg = ErrorResponse.fromJson(response?.data).message;
      print(msg);
      return msg ?? 'Invalid request';
    } catch (_) {}

    return 'Invalid request';
  }
}

class InternalServerErrorException extends DioException {
  InternalServerErrorException(RequestOptions r, Response? response)
      : super(requestOptions: r, response: response);

  @override
  String toString() {
    try {
      String? msg = ErrorResponse.fromJson(response?.data).message;

      return msg ?? 'Unknown error occurred, please try again later.';
    } catch (e) {
      return 'Unknown error occurred, please try again later.';
    }
  }
}

class ConflictException extends DioException {
  ConflictException(RequestOptions r, Response? response)
      : super(requestOptions: r, response: response);

  @override
  String toString() {
    String? msg = ErrorResponse.fromJson(response?.data).message;

    return msg ?? 'Conflict occurred';
  }
}

class UnauthorizedException extends DioException {
  UnauthorizedException(RequestOptions r, Response? response)
      : super(requestOptions: r, response: response);

  @override
  String toString() {
    String? msg = ErrorResponse.fromJson(response?.data).message;

    return msg ?? 'Access denied';
  }
}

class NotFoundException extends DioException {
  NotFoundException(RequestOptions r, Response? response)
      : super(requestOptions: r, response: response);

  @override
  String toString() {
    String? msg = ErrorResponse.fromJson(response?.data).message;

    return msg ?? 'The requested information could not be found';
  }
}

class NoInternetConnectionException extends DioException {
  NoInternetConnectionException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'No internet connection detected, please try again.';
  }
}

class DeadlineExceededException extends DioException {
  DeadlineExceededException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'The connection has timed out, please try again.';
  }
}
