class TransportModel {
  final String id;
  final String compagnie;
  final String villeDepart;
  final String villeArrivee;
  final String horaire;
  final double prix;
  final String type; // Ligne ou Compagnie

  TransportModel({
    required this.id,
    required this.compagnie,
    required this.villeDepart,
    required this.villeArrivee,
    required this.horaire,
    required this.prix,
    required this.type,
  });

  factory TransportModel.fromJson(Map<String, dynamic> json) {
    return TransportModel(
      id: json['id'] ?? '',
      compagnie: json['compagnie'] ?? '',
      villeDepart: json['ville_depart'] ?? '',
      villeArrivee: json['ville_arrivee'] ?? '',
      horaire: json['horaire'] ?? '',
      prix: double.tryParse(json['prix']?.toString() ?? '0') ?? 0.0,
      type: json['type'] ?? '',
    );
  }
}
