import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:qrcode_client/constants.dart';
import 'package:qrcode_client/interfaces/http_client_interface.dart';

class ClientHttpService implements IClientHttp {
  Dio dio;

  ClientHttpService({String baseUrl = kAPIBaseUrl}) {
    dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        receiveTimeout: 10000,
      ),
    );

    dio.interceptors.add(DioCacheManager(CacheConfig()).interceptor);
  }

  @override
  Future get(String path) async {
    var response = await dio.get(
      path,
      options: buildCacheOptions(Duration(minutes: 1)),
    );

    return response.data;
  }
}
