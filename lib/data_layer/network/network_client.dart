import 'dart:io';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

/// A model representing a network response.
class NetworkResponse extends Equatable {
  /// The HTTP status code.
  final int? statusCode;

  /// The request result data.
  final dynamic data;

  /// The HTTP status message.
  final String? statusMessage;

  /// Creates a new [NetworkResponse].
  const NetworkResponse({
    this.statusCode,
    this.data,
    this.statusMessage,
  });

  @override
  List<Object?> get props => [
        statusCode,
        data,
        statusMessage,
      ];
}

/// Class representing a connectivity exception.
class ConnectivityException implements Exception {}

/// Class representing a network exception.
class NetworkException implements Exception {
  /// The HTTP status code.
  final int? statusCode;

  /// The exception message.
  final String? message;

  /// Creates a new [NetworkException].
  const NetworkException({
    this.statusCode,
    this.message,
  });
}

/// Handles all communication with the backend.
class NetworkClient {
  /// The HTTP client.
  final Dio client;

  /// The base URL.
  final String baseURL;

  /// Creates a new [NetworkClient].
  NetworkClient({
    required this.baseURL,
  }) : client = Dio(
          BaseOptions(
            baseUrl: baseURL,
          ),
        );

  /// Sends a get request.
  Future<NetworkResponse> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await client.get(
        path,
        queryParameters: queryParameters,
        options: Options(
          contentType: ContentType.json.mimeType,
          responseType: ResponseType.json,
        ),
      );

      return NetworkResponse(
        statusCode: response.statusCode,
        data: response.data,
      );
    } on DioException catch (e) {
      if (e.type == DioExceptionType.cancel) {
        return const NetworkResponse(
          statusCode: 204,
          statusMessage: 'canceled request',
        );
      }

      final isConnectivityError = {
            DioExceptionType.connectionTimeout,
            DioExceptionType.sendTimeout,
            DioExceptionType.receiveTimeout,
          }.contains(e.type) ||
          (e.type == DioExceptionType.unknown && e.error is SocketException);

      throw isConnectivityError
          ? ConnectivityException()
          : NetworkException(
              statusCode: e.response?.statusCode,
              message: e.message,
            );
    }
  }
}
