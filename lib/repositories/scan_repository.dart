import 'package:get_it/get_it.dart';
import 'package:qrcode_client/interfaces/http_client_interface.dart';
import 'package:qrcode_client/interfaces/scan_repository_interface.dart';
import 'package:qrcode_client/models/verification_model.dart';

class ScanRepository implements IScanRepository {
  final IClientHttp httpClient = GetIt.I.get<IClientHttp>();

  @override
  Future<VerificationModel> validateQRCode(String seed) async {
     var response = await httpClient.get("/seed/$seed");

    VerificationModel data = VerificationModel.fromJson(response);

    return data;
  }
}
