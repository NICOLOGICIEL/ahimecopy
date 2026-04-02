class HotelModel {
  final String id;
  final String nom;
  final String type; // Hôtel ou Résidence
  final String ville;
  final String commune;
  final String quartier;
  final double note;
  final String description;

  HotelModel({
    required this.id,
    required this.nom,
    required this.type,
    required this.ville,
    required this.commune,
    required this.quartier,
    required this.note,
    required this.description,
  });

  factory HotelModel.fromJson(Map<String, dynamic> json) {
    return HotelModel(
      id: json['id'] ?? '',
      nom: json['nom'] ?? '',
      type: json['type'] ?? '',
      ville: json['ville'] ?? '',
      commune: json['commune'] ?? '',
      quartier: json['quartier'] ?? '',
      note: double.tryParse(json['note']?.toString() ?? '0') ?? 0.0,
      description: json['description'] ?? '',
    );
  }
}
