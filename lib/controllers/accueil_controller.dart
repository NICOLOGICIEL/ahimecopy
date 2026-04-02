import 'package:get/get.dart';

class AccueilController extends GetxController {
  // Logique pour la page d'accueil, si nécessaire (ex. : gestion des catégories)
  void navigateToTransport() {
    Get.toNamed('/transport');
  }

  void navigateToHotel() {
    Get.toNamed('/hotel');
  }

  void navigateToArtisan() {
    Get.toNamed('/artisan');
  }

  void navigateToImmobilier() {
    Get.toNamed('/immobilier');
  }
}
