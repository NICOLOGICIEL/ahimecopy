// Contrôleur GetX du module Artisan.
// Gère les filtres, les recherches et les résultats liés aux artisans.

import 'package:get/get.dart';
import 'package:ahime/models/artisan_model.dart';
import 'package:ahime/services/api_service.dart';

class ArtisanController extends GetxController {
  final ApiService _apiService = ApiService();

  var isLoading = false.obs;
  var artisans = <ArtisanModel>[].obs;
  var metiers = <String>[].obs;
  var categories = <String>[].obs;
  var villes = <String>[].obs;

  var selectedMetier = ''.obs;
  var selectedCategorie = ''.obs;
  var selectedVille = ''.obs;
  var commune = ''.obs;
  var quartier = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadInitialData();
  }

  void loadInitialData() async {
    isLoading.value = true;
    try {
      // Charger les données initiales (métier, catégorie)
      final response = await _apiService.get('/api/action', queryParameters: {
        'action': 'get_metiers_categories',
      });
      if (response.statusCode == 200) {
        metiers.value = List<String>.from(response.data['metiers'] ?? []);
        categories.value = List<String>.from(response.data['categories'] ?? []);
      }
    } catch (e) {
      Get.snackbar('Erreur', 'Impossible de charger les données');
    } finally {
      isLoading.value = false;
    }
  }

  void searchArtisans() async {
    isLoading.value = true;
    try {
      final response = await _apiService.post('/api/action', data: {
        'action': 'search_artisans',
        'metier': selectedMetier.value,
        'categorie': selectedCategorie.value,
        'ville': selectedVille.value,
        'commune': commune.value,
        'quartier': quartier.value,
      });
      if (response.statusCode == 200) {
        artisans.value = (response.data['artisans'] as List)
            .map((json) => ArtisanModel.fromJson(json))
            .toList();
      }
    } catch (e) {
      Get.snackbar('Erreur', 'Recherche échouée');
    } finally {
      isLoading.value = false;
    }
  }

  void updateSelectedMetier(String? value) {
    selectedMetier.value = value ?? '';
  }

  void updateSelectedCategorie(String? value) {
    selectedCategorie.value = value ?? '';
  }

  void updateSelectedVille(String? value) {
    selectedVille.value = value ?? '';
  }

  void updateCommune(String value) {
    commune.value = value;
  }

  void updateQuartier(String value) {
    quartier.value = value;
  }
}
