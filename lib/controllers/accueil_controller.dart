// Contrôleur GetX de la page d'accueil.
// Gère l'état et la logique métier liés à l'écran principal.

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
