import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:the_movies/src/shared/exceptions/http_exception.dart';
import 'package:the_movies/src/shared/services/http/http_service.dart';

class HttpServiceDio implements HttpService {
  late Dio _dio;
  HttpServiceDio() {
    _init();
  }

  Future<void> _init() async {
    _dio = Dio(BaseOptions(
        baseUrl: 'https://api.themoviedb.org/3/',
        connectTimeout: 30 * 1000,
        receiveTimeout: 30 * 1000));
    _dio.interceptors.add(LogInterceptor(
      request: true,
      requestHeader: true,
      requestBody: true,
      responseHeader: true,
      responseBody: true,
      error: true,
    ));
  }

  @override
  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      bool isConnected = await _isConnected();
      if (!isConnected) {
        _throwHttpException(
            999, 'Sua conexão com a internet está instável. Reconecte e tente novamente.');
      }
      return _dio.get<T>(
        path,
        queryParameters: queryParameters,
        options: Options(headers: {
          "content-type": "application/json;charset=utf-8",
          "authorization":
              "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJhMGY4NjE3MmYyNzIzOTY4M2Q3ZWJjYjdkZmIwODZlNCIsInN1YiI6IjYyZTQwOTUyNDZlNzVmMDA1Y2RiZDUxMiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.V0ATvKbM6cOH6OfG3zHu9_r4WiHzyl8BkLoWlozKDJM",
        }),
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
    } on DioError catch (e, s) {
      var throwException =
          HttpException(e.response?.statusCode?.toInt() ?? 400, 'Exception: $e, StackTrace $s');
      throw throwException;
    }
  }

  @override
  Future<Response<T>> post<T>(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      bool isConnected = await _isConnected();
      if (!isConnected) {
        _throwHttpException(
            999, 'Sua conexão com a internet está instável. Reconecte e tente novamente.');
      }
      return _dio.post<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: _checkOptions('POST', options),
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
    } on DioError catch (e, s) {
      var throwException =
          HttpException(e.response?.statusCode?.toInt() ?? 400, 'Exception: $e, StackTrace $s');
      throw throwException;
    }
  }

  @override
  Future<Response<T>> delete<T>(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      bool isConnected = await _isConnected();
      if (!isConnected) {
        _throwHttpException(
            999, 'Sua conexão com a internet está instável. Reconecte e tente novamente.');
      }
      return _dio.delete<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: _checkOptions('DELETE', options),
        cancelToken: cancelToken,
      );
    } on DioError catch (e, s) {
      var throwException =
          HttpException(e.response?.statusCode?.toInt() ?? 400, 'Exception: $e, StackTrace $s');
      throw throwException;
    }
  }

  static Options _checkOptions(String method, Options? options) {
    options ??= Options();
    options.method = method;
    return options;
  }

  Future<bool> _isConnected() async {
    try {
      ConnectivityResult connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.none) {
        return false;
      } else {
        return true;
      }
    } on Exception {
      return false;
    }
  }

  void _throwHttpException(int statusCode, String message) {
    throw HttpException(statusCode, message);
  }
}
