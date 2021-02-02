import 'package:qrcode_client/models/seed_model.dart';

abstract class IQRCodeRepository {
  Future<SeedModel> getSeed();
}
