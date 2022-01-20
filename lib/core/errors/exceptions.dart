import 'dart:io';

import 'package:dio/dio.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:project_template/core/errors/network_exceptions.dart';

/// This exception is for general exceptions
/// you can create new freezed class like Network Exception for other kind exception
class AppException {
  static AppException getException(dynamic error) {
    if (error is Exception) {
      try {
        late AppException appExceptions;
        if (error is DioError) {
          switch (error.type) {
            case DioErrorType.other:
              appExceptions = const NetworkException.noInternetConnection();
              break;
            case DioErrorType.connectTimeout:
              appExceptions = const NetworkException.requestTimeout();
              break;
            case DioErrorType.receiveTimeout:
              appExceptions = const NetworkException.sendTimeout();
              break;
            case DioErrorType.cancel:
              appExceptions = const NetworkException.requestCancelled();
              break;
            case DioErrorType.sendTimeout:
              appExceptions = const NetworkException.sendTimeout();
              break;
            case DioErrorType.response:
              appExceptions = NetworkException.defaultError(error.response!.data['message']);
              break;
          }
        } else if (error is SocketException) {
          appExceptions = const NetworkException.noInternetConnection();
        } else {
          appExceptions = const NetworkException.unexpectedError();
        }
        return appExceptions;
      } on FormatException {
        return const NetworkException.formatException();
      } catch (_) {
        return const NetworkException.unexpectedError();
      }
    } else {
      return const NetworkException.unexpectedError();
    }
  }

  static String getErrorMessage(AppException exceptions) {
    String errorMessage = "";
    if (exceptions is NetworkException) {
      exceptions.when(
        unexpectedError: () {
          errorMessage = "error.network.unexpectedError".tr();
        },
        requestCancelled: () {
          errorMessage = "error.network.requestCancelled".tr();
        },
        requestTimeout: () {
          errorMessage = "error.network.requestTimeout".tr();
        },
        sendTimeout: () {
          errorMessage = "error.network.sendTimeout".tr();
        },
        noInternetConnection: () {
          errorMessage = "error.network.noInternetConnection".tr();
        },
        defaultError: (String error) {
          errorMessage = error;
        },
        formatException: () {
          errorMessage = "error.network.formatException".tr();
        },
      );
    } else {
      errorMessage = "error.network.unknownException".tr();
    }
    return errorMessage;
  }
}
