import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:qrcode_client/interfaces/http_client_interface.dart';
import 'package:qrcode_client/models/seed_model.dart';
import 'package:qrcode_client/screens/QRCodePage/qr_code_controller.dart';

class MockClient extends Mock implements IClientHttp {}

main() {
  GetIt getIt = GetIt.I;

  final mock = MockClient();

  getIt.registerSingleton<IClientHttp>(mock);

  final QRCodeController controller = QRCodeController();

  final SeedModel seedModel = SeedModel(
    expiresAt: DateTime.now().add(Duration(minutes: 1)).toIso8601String(),
    seed:
        "xZrAAy4ctoauOL7dfsaaTO04mJlkPe3yfhcPcUNeVDc5Br6NapwFr7aRyGAWWBU6HQntFnaUN2dYHlHTtKxFKcgbH2A38TNBL7FRTI9oRKBMXD52x1zfZiKSrvyo3Qn7SZHh51Zmbq30jYVcWBKmxG7jW6qb5H9B3lbCIjCapR1FgRw3fmFaS8XszuZSWYExmCBhCyVF",
    id: 200,
  );

  group("fetch qr code and handle error", () {
    test("should fetch QR Code seed", () async {
      when(mock.get("/seed")).thenAnswer(
        (_) => Future.value(seedModel.toJson()),
      );

      await controller.handleLoading();

      expect(controller.seed, seedModel.seed);
      expect(controller.loading, false);

      // Calculate remaining seconds
      // and check if it matches
      int remainingSeconds = DateTime.parse(seedModel.expiresAt)
          .difference(DateTime.now())
          .inSeconds;

      expect(controller.secondsLeft, remainingSeconds);
    });

    test("should trigger error handler if fetching fails", () async {
      when(mock.get("/seed")).thenThrow(
        Exception("Network error"),
      );

      await controller.handleLoading();

      expect(controller.hasError, true);
      expect(controller.loading, false);
    });
  });
}
