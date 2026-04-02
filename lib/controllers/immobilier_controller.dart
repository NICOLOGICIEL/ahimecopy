// Contrôleur GetX du module Immobilier.
// Gère les critères de recherche et l'état des résultats immobiliers.

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:ahime/models/immobilier_model.dart';
import 'package:ahime/services/api_service.dart';

class ImmobilierController extends GetxController {
  final ApiService _apiService = Get.find<ApiService>();

  // État réactif
  var isLoading = false.obs;
  var immobiliers = <ImmobilierModel>[].obs;
  var searchQuery = ''.obs;
  var selectedType = 'Tous'.obs; // Vente, Location, Tous
  var selectedVille = ''.obs;

  // Données pour dropdowns
  var villes = <String>[].obs;
  var types = ['Tous', 'Vente', 'Location'].obs;

  @override
  void onInit() {
    super.onInit();
    loadInitialData();
  }

  void loadInitialData() async {
    isLoading.value = true;
    try {
      await fetchImmobiliers();
      await loadVilles();
    } catch (e) {
      debugPrint('Erreur lors du chargement des données immobilier: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchImmobiliers({
    String? query,
    String? type,
    String? ville,
  }) async {
    try {
      var response = await _apiService.getImmobiliers(
        query: query,
        type: type,
        ville: ville,
      );
      immobiliers.value =
          response.map((json) => ImmobilierModel.fromJson(json)).toList();
    } catch (e) {
      debugPrint('Erreur lors de la récupération des immobiliers: $e');
    }
  }

  Future<void> loadVilles() async {
    try {
      var response = await _apiService.getVilles();
      villes.value = List<String>.from(response);
    } catch (e) {
      debugPrint('Erreur lors du chargement des villes: $e');
    }
  }

  void updateSearchQuery(String query) {
    searchQuery.value = query;
    fetchImmobiliers(
      query: query,
      type: selectedType.value == 'Tous' ? null : selectedType.value,
      ville: selectedVille.value.isEmpty ? null : selectedVille.value,
    );
  }

  void updateSelectedType(String? type) {
    selectedType.value = type ?? 'Tous';
    fetchImmobiliers(
      query: searchQuery.value,
      type: selectedType.value == 'Tous' ? null : selectedType.value,
      ville: selectedVille.value.isEmpty ? null : selectedVille.value,
    );
  }

  void updateSelectedVille(String? ville) {
    selectedVille.value = ville ?? '';
    fetchImmobiliers(
      query: searchQuery.value,
      type: selectedType.value == 'Tous' ? null : selectedType.value,
      ville: selectedVille.value.isEmpty ? null : selectedVille.value,
    );
  }

  void searchImmobiliers() {
    fetchImmobiliers(
      query: searchQuery.value,
      type: selectedType.value == 'Tous' ? null : selectedType.value,
      ville: selectedVille.value.isEmpty ? null : selectedVille.value,
    );
  }
}
