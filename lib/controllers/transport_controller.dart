import 'package:get/get.dart';
import 'package:ahime/models/transport_model.dart';
import 'package:ahime/services/api_service.dart';

class TransportController extends GetxController {
  final ApiService _apiService = Get.find<ApiService>();

  // État réactif
  var isLoading = false.obs;
  var transports = <TransportModel>[].obs;
  var selectedVilleDepart = ''.obs;
  var selectedVilleArrivee = ''.obs;
  var selectedCompagnie = ''.obs;
  var searchMode = 'ligne'.obs; // 'ligne' ou 'compagnie'

  // Données pour dropdowns
  var villes = <String>[].obs;
  var compagnies = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadInitialData();
  }

  void loadInitialData() async {
    isLoading.value = true;
    try {
      await loadVilles();
      await loadCompagnies();
    } catch (e) {
      print('Erreur lors du chargement des données transport: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadVilles() async {
    try {
      var response = await _apiService.getVilles();
      villes.value = List<String>.from(response);
    } catch (e) {
      print('Erreur lors du chargement des villes: $e');
    }
  }

  Future<void> loadCompagnies() async {
    try {
      var response = await _apiService.getCompagnies();
      compagnies.value = List<String>.from(response);
    } catch (e) {
      print('Erreur lors du chargement des compagnies: $e');
    }
  }

  Future<void> searchTransports() async {
    isLoading.value = true;
    try {
      List<Map<String, dynamic>> response;
      if (searchMode.value == 'ligne') {
        response = await _apiService.searchTransportsByLine(
          villeDepart: selectedVilleDepart.value,
          villeArrivee: selectedVilleArrivee.value,
        );
      } else {
        response = await _apiService.searchTransportsByCompagnie(
          compagnie: selectedCompagnie.value,
        );
      }
      transports.value =
          response.map((json) => TransportModel.fromJson(json)).toList();
    } catch (e) {
      print('Erreur lors de la recherche de transports: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void updateVilleDepart(String? value) {
    selectedVilleDepart.value = value ?? '';
  }

  void updateVilleArrivee(String? value) {
    selectedVilleArrivee.value = value ?? '';
  }

  void updateCompagnie(String? value) {
    selectedCompagnie.value = value ?? '';
  }

  void setSearchMode(String mode) {
    searchMode.value = mode;
    // Reset selections when switching mode
    if (mode == 'ligne') {
      selectedCompagnie.value = '';
    } else {
      selectedVilleDepart.value = '';
      selectedVilleArrivee.value = '';
    }
  }
}
