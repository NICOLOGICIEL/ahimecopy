// Service centralisant les appels API de l'application.
// Il encapsule les requêtes réseau vers les différentes sources de données.

import 'package:dio/dio.dart';
import 'package:ahime/config/my_config.dart';

class ApiService {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: APIServeur,
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
  ));

  Future<Response> get(String endpoint,
      {Map<String, dynamic>? queryParameters}) async {
    try {
      return await _dio.get(endpoint, queryParameters: queryParameters);
    } catch (e) {
      throw Exception('Erreur API GET: $e');
    }
  }

  Future<Response> post(String endpoint, {Map<String, dynamic>? data}) async {
    try {
      return await _dio.post(endpoint, data: data);
    } catch (e) {
      throw Exception('Erreur API POST: $e');
    }
  }

  // Méthodes spécifiques pour les artisans
  Future<List<Map<String, dynamic>>> getArtisans(
      {String? metier,
      String? categorie,
      String? ville,
      String? commune,
      String? quartier}) async {
    try {
      var data = {
        'action': 'get_artisans',
        if (metier != null) 'metier': metier,
        if (categorie != null) 'categorie': categorie,
        if (ville != null) 'ville': ville,
        if (commune != null) 'commune': commune,
        if (quartier != null) 'quartier': quartier,
      };
      var response = await post('/api/action', data: data);
      return List<Map<String, dynamic>>.from(response.data['data'] ?? []);
    } catch (e) {
      throw Exception('Erreur récupération artisans: $e');
    }
  }

  // Méthodes pour les hôtels
  Future<List<Map<String, dynamic>>> getHotels(
      {String? query, String? type}) async {
    try {
      var data = {
        'action': 'get_hotels',
        if (query != null) 'query': query,
        if (type != null) 'type': type,
      };
      var response = await post('/api/action', data: data);
      return List<Map<String, dynamic>>.from(response.data['data'] ?? []);
    } catch (e) {
      throw Exception('Erreur récupération hôtels: $e');
    }
  }

  // Méthodes pour les transports
  Future<List<Map<String, dynamic>>> searchTransportsByLine(
      {required String villeDepart, required String villeArrivee}) async {
    try {
      var data = {
        'action': 'search_transports_line',
        'ville_depart': villeDepart,
        'ville_arrivee': villeArrivee,
      };
      var response = await post('/api/action', data: data);
      return List<Map<String, dynamic>>.from(response.data['data'] ?? []);
    } catch (e) {
      throw Exception('Erreur recherche transports par ligne: $e');
    }
  }

  Future<List<Map<String, dynamic>>> searchTransportsByCompagnie(
      {required String compagnie}) async {
    try {
      var data = {
        'action': 'search_transports_compagnie',
        'compagnie': compagnie,
      };
      var response = await post('/api/action', data: data);
      return List<Map<String, dynamic>>.from(response.data['data'] ?? []);
    } catch (e) {
      throw Exception('Erreur recherche transports par compagnie: $e');
    }
  }

  Future<List<String>> getCompagnies() async {
    try {
      var data = {'action': 'get_compagnies'};
      var response = await post('/api/action', data: data);
      return List<String>.from(response.data['data'] ?? []);
    } catch (e) {
      throw Exception('Erreur récupération compagnies: $e');
    }
  }

  // Méthodes pour l'immobilier
  Future<List<Map<String, dynamic>>> getImmobiliers(
      {String? query, String? type, String? ville}) async {
    try {
      var data = {
        'action': 'get_immobiliers',
        if (query != null) 'query': query,
        if (type != null) 'type': type,
        if (ville != null) 'ville': ville,
      };
      var response = await post('/api/action', data: data);
      return List<Map<String, dynamic>>.from(response.data['data'] ?? []);
    } catch (e) {
      throw Exception('Erreur récupération immobiliers: $e');
    }
  }

  // Méthode commune pour les villes
  Future<List<String>> getVilles() async {
    try {
      var data = {'action': 'get_villes'};
      var response = await post('/api/action', data: data);
      return List<String>.from(response.data['data'] ?? []);
    } catch (e) {
      throw Exception('Erreur récupération villes: $e');
    }
  }
}
