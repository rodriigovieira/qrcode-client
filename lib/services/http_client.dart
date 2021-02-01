import 'package:dio/dio.dart';
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
  }

  @override
  Future get(String path) async {
    Response response = await dio.get(path);

    return response.data;
  }
}
