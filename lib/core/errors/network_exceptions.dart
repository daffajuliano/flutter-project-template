import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:project_template/core/errors/exceptions.dart';

part 'network_exceptions.freezed.dart';

/// This file is greatly inspired by
/// https://gist.github.com/arya-anggara/f57b7c3f388c08036cd7a58522023c2a
/// this exception only for network error.
@freezed
abstract class NetworkException extends AppException with _$NetworkException {
  const factory NetworkException.requestCancelled() = _RequestCancelled;

  const factory NetworkException.sendTimeout() = _SendTimeout;

  const factory NetworkException.requestTimeout() = _RequestTimeout;

  const factory NetworkException.noInternetConnection() = _NoInternetConnection;

  const factory NetworkException.formatException() = _FormatException;

  const factory NetworkException.defaultError(String error) = _DefaultError;

  const factory NetworkException.unexpectedError() = _UnexpectedError;
}
