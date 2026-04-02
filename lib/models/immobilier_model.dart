// Modèle de données représentant un bien immobilier.
// Utilisé pour transporter et structurer les données du module Immobilier.

class ImmobilierModel {
  final String id;
  final String titre;
  final String type; // Vente, Location, etc.
  final String ville;
  final String commune;
  final String quartier;
  final double prix;
  final String description;
  final int chambres;
  final int superficie;

  ImmobilierModel({
    required this.id,
    required this.titre,
    required this.type,
    required this.ville,
    required this.commune,
    required this.quartier,
    required this.prix,
    required this.description,
    required this.chambres,
    required this.superficie,
  });

  factory ImmobilierModel.fromJson(Map<String, dynamic> json) {
    return ImmobilierModel(
      id: json['id'] ?? '',
      titre: json['titre'] ?? '',
      type: json['type'] ?? '',
      ville: json['ville'] ?? '',
      commune: json['commune'] ?? '',
      quartier: json['quartier'] ?? '',
      prix: double.tryParse(json['prix']?.toString() ?? '0') ?? 0.0,
      description: json['description'] ?? '',
      chambres: int.tryParse(json['chambres']?.toString() ?? '0') ?? 0,
      superficie: int.tryParse(json['superficie']?.toString() ?? '0') ?? 0,
    );
  }
}
