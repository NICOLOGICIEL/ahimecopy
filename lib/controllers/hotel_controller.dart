import 'package:get/get.dart';
import 'package:ahime/models/hotel_model.dart';
import 'package:ahime/services/api_service.dart';

class HotelController extends GetxController {
  final ApiService _apiService = Get.find<ApiService>();

  // État réactif
  var isLoading = false.obs;
  var hotels = <HotelModel>[].obs;
  var searchQuery = ''.obs;
  var selectedType = 'Tous'.obs; // Hôtel, Résidence, Tous

  // Données pour dropdowns (si nécessaire)
  var villes = <String>[].obs;
  var communes = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadInitialData();
  }

  void loadInitialData() async {
    isLoading.value = true;
    try {
      // Charger les hôtels initiaux
      await fetchHotels();
      // Charger les villes/communes pour les filtres
      await loadVilles();
    } catch (e) {
      print('Erreur lors du chargement des données hôtel: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchHotels({String? query, String? type}) async {
    try {
      // Simulation d'appel API - adapter selon votre API réelle
      var response = await _apiService.getHotels(query: query, type: type);
      hotels.value = response.map((json) => HotelModel.fromJson(json)).toList();
    } catch (e) {
      print('Erreur lors de la récupération des hôtels: $e');
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

  void updateSearchQuery(String query) {
    searchQuery.value = query;
    fetchHotels(
        query: query,
        type: selectedType.value == 'Tous' ? null : selectedType.value);
  }

  void updateSelectedType(String? type) {
    selectedType.value = type ?? 'Tous';
    fetchHotels(
        query: searchQuery.value,
        type: selectedType.value == 'Tous' ? null : selectedType.value);
  }

  void searchHotels() {
    fetchHotels(
        query: searchQuery.value,
        type: selectedType.value == 'Tous' ? null : selectedType.value);
  }
}
