import 'package:get_it/get_it.dart';
import 'package:qrcode_client/interfaces/http_client_interface.dart';
import 'package:qrcode_client/interfaces/qr_code_repository_interface.dart';
import 'package:qrcode_client/models/seed_model.dart';

class QRCodeRepository implements IQRCodeRepository {
  final IClientHttp httpClient = GetIt.I.get<IClientHttp>();

  @override
  Future<SeedModel> getSeed() async {
    var response = await httpClient.get("/seed");

    SeedModel data = SeedModel.fromJson(response);

    return data;
  }
}
