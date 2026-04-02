// Déclare les dépendances globales de l'application via GetX bindings.
// Ce fichier enregistre les contrôleurs nécessaires au démarrage.

import 'package:get/get.dart';
import 'package:ahime/controllers/accueil_controller.dart';
import 'package:ahime/controllers/artisan_controller.dart';
import 'package:ahime/controllers/hotel_controller.dart';
import 'package:ahime/controllers/transport_controller.dart';
import 'package:ahime/controllers/immobilier_controller.dart';
import 'package:ahime/services/api_service.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    // Service
    Get.lazyPut(() => ApiService());

    // Contrôleurs
    Get.lazyPut(() => AccueilController());
    Get.lazyPut(() => ArtisanController());
    Get.lazyPut(() => HotelController());
    Get.lazyPut(() => TransportController());
    Get.lazyPut(() => ImmobilierController());
  }
}
