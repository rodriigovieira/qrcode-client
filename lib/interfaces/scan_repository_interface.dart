import 'package:qrcode_client/models/verification_model.dart';

abstract class IScanRepository {
  Future<VerificationModel> validateQRCode(String seed);
}
