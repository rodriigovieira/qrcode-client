import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:qrcode_client/interfaces/http_client_interface.dart';
import 'package:qrcode_client/models/seed_model.dart';
import 'package:qrcode_client/models/verification_model.dart';
import 'package:qrcode_client/screens/ScanPage/scan_controller.dart';
import 'package:qrcode_client/services/http_client.dart';

class MockClient extends Mock implements IClientHttp {}

main() {
  GetIt getIt = GetIt.I;

  final mock = MockClient();

  getIt.registerSingleton<IClientHttp>(mock);

  final ScanController controller = ScanController();

  final SeedModel seedModel = SeedModel(
    expiresAt: DateTime.now().add(Duration(minutes: 1)).toIso8601String(),
    seed:
        "xZrAAy4ctoauOL7dfsaaTO04mJlkPe3yfhcPcUNeVDc5Br6NapwFr7aRyGAWWBU6HQntFnaUN2dYHlHTtKxFKcgbH2A38TNBL7FRTI9oRKBMXD52x1zfZiKSrvyo3Qn7SZHh51Zmbq30jYVcWBKmxG7jW6qb5H9B3lbCIjCapR1FgRw3fmFaS8XszuZSWYExmCBhCyVF",
    id: 200,
  );

  final VerificationModel validVerificationModel = VerificationModel(
    isValid: true,
    expiresAt: DateTime.now().toIso8601String(),
    seed:
        "xZrAAy4ctoauOL7dfsaaTO04mJlkPe3yfhcPcUNeVDc5Br6NapwFr7aRyGAWWBU6HQntFnaUN2dYHlHTtKxFKcgbH2A38TNBL7FRTI9oRKBMXD52x1zfZiKSrvyo3Qn7SZHh51Zmbq30jYVcWBKmxG7jW6qb5H9B3lbCIjCapR1FgRw3fmFaS8XszuZSWYExmCBhCyVF",
  );

  final VerificationModel invalidVerificationModel = VerificationModel(
    isValid: false,
    expiresAt: DateTime.now().add(Duration(minutes: 2)).toIso8601String(),
    seed:
        "xZrAAy4ctoauOL7dfsaaTO04mJlkPe3yfhcPcUNeVDc5Br6NapwFr7aRyGAWWBU6HQntFnaUN2dYHlHTtKxFKcgbH2A38TNBL7FRTI9oRKBMXD52x1zfZiKSrvyo3Qn7SZHh51Zmbq30jYVcWBKmxG7jW6qb5H9B3lbCIjCapR1FgRw3fmFaS8XszuZSWYExmCBhCyVF",
  );

  group("check if valid and handle error", () {
    test("should check if seed is valid or not", () async {
      when(mock.get("/seed/${seedModel.seed}")).thenAnswer(
        (_) => Future.value(validVerificationModel.toJson()),
      );

      await controller.checkIfValid(seedModel.seed);

      expect(controller.isValid, true);
      expect(controller.hasLoadedCode, true);
    });

    test("should handle error if not valid", () async {
      when(mock.get("/seed/${seedModel.seed}")).thenAnswer(
        (_) => Future.value(invalidVerificationModel.toJson()),
      );

      await controller.checkIfValid(seedModel.seed);

      expect(controller.isValid, false);
      expect(controller.hasLoadedCode, true);
    });

    test("should handle error if API call fails", () async {
      when(mock.get("/seed/${seedModel.seed}")).thenThrow(
        Exception("Network error"),
      );

      await controller.checkIfValid(seedModel.seed);

      expect(controller.hasError, true);
      expect(controller.hasLoadedCode, true);
    });
  });
}
