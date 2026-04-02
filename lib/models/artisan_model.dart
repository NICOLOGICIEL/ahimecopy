// Modèle de données représentant un artisan.
// Définit la structure des informations manipulées dans le module Artisan.

class ArtisanModel {
  final String id;
  final String nom;
  final String metier;
  final String categorie;
  final String ville;
  final String commune;
  final String quartier;
  final double note;

  ArtisanModel({
    required this.id,
    required this.nom,
    required this.metier,
    required this.categorie,
    required this.ville,
    required this.commune,
    required this.quartier,
    required this.note,
  });

  factory ArtisanModel.fromJson(Map<String, dynamic> json) {
    return ArtisanModel(
      id: json['id'] ?? '',
      nom: json['nom'] ?? '',
      metier: json['metier'] ?? '',
      categorie: json['categorie'] ?? '',
      ville: json['ville'] ?? '',
      commune: json['commune'] ?? '',
      quartier: json['quartier'] ?? '',
      note: double.tryParse(json['note']?.toString() ?? '0') ?? 0.0,
    );
  }
}
