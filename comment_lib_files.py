from pathlib import Path


DESCRIPTIONS = {
    'lib/main.dart': [
        "// Point d'entrée principal de l'application Ahime.",
        '// Configure GetX, le thème global et les routes principales.',
    ],
    'lib/bindings/app_bindings.dart': [
        "// Déclare les dépendances globales de l'application via GetX bindings.",
        '// Ce fichier enregistre les contrôleurs nécessaires au démarrage.',
    ],
    'lib/config/my_config.dart': [
        "// Centralise les constantes globales de l'application.",
        '// On y retrouve notamment les couleurs, URLs et valeurs partagées.',
    ],
    'lib/controllers/accueil_controller.dart': [
        "// Contrôleur GetX de la page d'accueil.",
        "// Gère l'état et la logique métier liés à l'écran principal.",
    ],
    'lib/controllers/artisan_controller.dart': [
        '// Contrôleur GetX du module Artisan.',
        '// Gère les filtres, les recherches et les résultats liés aux artisans.',
    ],
    'lib/controllers/hotel_controller.dart': [
        '// Contrôleur GetX du module Hôtel.',
        '// Contient la logique de recherche, de filtrage et de chargement des hôtels.',
    ],
    'lib/controllers/immobilier_controller.dart': [
        '// Contrôleur GetX du module Immobilier.',
        "// Gère les critères de recherche et l'état des résultats immobiliers.",
    ],
    'lib/controllers/transport_controller.dart': [
        '// Contrôleur GetX du module Transport.',
        '// Gère les recherches par ligne, compagnie, villes et horaires.',
    ],
    'lib/models/artisan_model.dart': [
        '// Modèle de données représentant un artisan.',
        '// Définit la structure des informations manipulées dans le module Artisan.',
    ],
    'lib/models/hotel_model.dart': [
        '// Modèle de données représentant un hôtel ou une résidence.',
        '// Sert à sérialiser et manipuler les données du module Hôtel.',
    ],
    'lib/models/immobilier_model.dart': [
        '// Modèle de données représentant un bien immobilier.',
        '// Utilisé pour transporter et structurer les données du module Immobilier.',
    ],
    'lib/models/transport_model.dart': [
        '// Modèle de données représentant une offre ou ligne de transport.',
        '// Sert de structure de base pour les résultats du module Transport.',
    ],
    'lib/pages/page_accueil.dart': [
        "// Page d'accueil principale de l'application.",
        "// Elle présente les différents modules accessibles à l'utilisateur.",
    ],
    'lib/services/api_service.dart': [
        "// Service centralisant les appels API de l'application.",
        '// Il encapsule les requêtes réseau vers les différentes sources de données.',
    ],
    'lib/pages/artisan/page_artisan.dart': [
        '// Page principale du module Artisan.',
        "// Elle regroupe l'entête, le formulaire de recherche, les messages d'alerte et la publicité.",
    ],
    'lib/pages/artisan/page_artisancommentaire.dart': [
        '// Page dédiée aux commentaires liés à un artisan.',
        '// Affiche et structure les retours ou avis des utilisateurs.',
    ],
    'lib/pages/artisan/page_artisanimgdetail.dart': [
        "// Page de détail d'image pour un artisan.",
        "// Permet d'afficher une image ou galerie en vue détaillée.",
    ],
    'lib/pages/artisan/page_artisanresult.dart': [
        '// Page affichant les résultats de recherche des artisans.',
        "// Présente la liste filtrée selon les critères choisis par l'utilisateur.",
    ],
    'lib/pages/artisan/page_artisantrecherche.dart': [
        '// Page de recherche avancée du module Artisan.',
        "// Sert d'écran dédié à la saisie et au filtrage des artisans sur web.",
    ],
    'lib/pages/hotel/my_form.dart': [
        '// Widget de formulaire réutilisable pour le module Hôtel.',
        "// Isole la logique d'interface liée à la saisie ou au filtrage.",
    ],
    'lib/pages/hotel/page_h.dart': [
        '// Page ou composant auxiliaire du module Hôtel.',
        "// Regroupe une partie spécifique de l'interface liée aux hôtels.",
    ],
    'lib/pages/hotel/page_hotel.dart': [
        '// Page principale du module Hôtel.',
        "// Contient les filtres, la recherche, les raccourcis et l'espace publicitaire.",
    ],
    'lib/pages/hotel/page_hoteldetail.dart': [
        "// Page de détail d'un hôtel ou d'une résidence.",
        "// Affiche les informations complètes d'un élément sélectionné.",
    ],
    'lib/pages/hotel/page_hotelimgdetail.dart': [
        "// Page de détail d'image du module Hôtel.",
        "// Permet de visualiser une image avec plus de contexte ou de taille.",
    ],
    'lib/pages/hotel/page_hotelimgfull.dart': [
        "// Page d'affichage plein écran des images d'hôtel.",
        "// Améliore l'expérience de visualisation des médias.",
    ],
    'lib/pages/hotel/page_hotelrecherche.dart': [
        '// Page de recherche dédiée au module Hôtel.',
        '// Regroupe les champs nécessaires à une recherche plus avancée.',
    ],
    'lib/pages/hotel/page_hotelresult.dart': [
        '// Page listant les résultats du module Hôtel.',
        '// Présente les établissements trouvés après application des filtres.',
    ],
    'lib/pages/immobilier/page_immobilier.dart': [
        '// Page principale du module Immobilier.',
        "// Elle gère la recherche, les filtres et l'affichage initial des résultats.",
    ],
    'lib/pages/transport/page_tranportresult.dart': [
        '// Page de résultats du module Transport.',
        '// Affiche les trajets ou compagnies correspondant à la recherche.',
    ],
    'lib/pages/transport/page_transport.dart': [
        '// Page principale du module Transport.',
        "// Elle permet de rechercher des lignes ou compagnies et d'afficher une publicité.",
    ],
    'lib/pages/transport/page_transporthoraire.dart': [
        '// Page affichant les horaires liés à une offre de transport.',
        "// Elle détaille les heures ou disponibilités d'un trajet sélectionné.",
    ],
    'lib/config/getx/updateimg.dart': [
        "// Utilitaire GetX dédié à la mise à jour d'état pour les images.",
        "// Sert à notifier l'interface lors d'un changement lié aux médias.",
    ],
    'lib/config/getx/updaterusulttext.dart': [
        "// Utilitaire GetX dédié à la mise à jour d'un texte de résultat.",
        "// Facilite la synchronisation d'un libellé dynamique avec l'interface.",
    ],
    'lib/config/getx/updatescreen.dart': [
        "// Utilitaire GetX pour piloter un état d'écran ou de vue.",
        '// Il aide à forcer ou déclencher des rafraîchissements ciblés.',
    ],
    'lib/config/utils/dropdownlist.dart': [
        '// Contient des listes ou helpers liés aux menus déroulants.',
        "// Simplifie la réutilisation de données pour les sélecteurs d'interface.",
    ],
    'lib/config/utils/my_navbar.dart': [
        "// Widget de barre de navigation réutilisable dans l'application.",
        "// Uniformise l'entête et la navigation entre les modules.",
    ],
    'lib/config/utils/my_titlerusult.dart': [
        '// Widget utilitaire pour afficher un titre de résultat.',
        "// Permet d'harmoniser la présentation des écrans de résultats.",
    ],
    'lib/config/utils/my_titlesub.dart': [
        '// Widget utilitaire pour afficher un sous-titre.',
        '// Facilite une présentation cohérente des sections secondaires.',
    ],
    'lib/config/utils/resizable.dart': [
        '// Utilitaires responsives pour adapter les tailles à l\'écran.',
        '// Ce fichier aide à construire des interfaces plus adaptatives.',
    ],
    'lib/config/utils/slide_img.dart': [
        "// Widget d'entête avec image réutilisable par plusieurs modules.",
        '// Sert à afficher une bannière visuelle avec un titre.',
    ],
}


def add_header_comment(path: Path, desc: list[str]) -> None:
    lines = path.read_text(encoding='utf-8').splitlines()
    existing = '\n'.join(lines[:8])
    if desc[0] in existing:
        return

    insert_at = 0
    while insert_at < len(lines) and (
        lines[insert_at].startswith('// ignore_for_file:')
        or lines[insert_at].startswith('// ignore:')
        or lines[insert_at].strip() == ''
    ):
        insert_at += 1

    new_lines = lines[:insert_at]
    if insert_at > 0 and new_lines and new_lines[-1].strip() != '':
        new_lines.append('')
    new_lines.extend(desc)
    new_lines.append('')
    new_lines.extend(lines[insert_at:])
    path.write_text('\n'.join(new_lines) + '\n', encoding='utf-8')


for file_path in sorted(Path('lib').rglob('*.dart')):
    key = str(file_path).replace('\\', '/')
    description = DESCRIPTIONS.get(key)
    if description:
        add_header_comment(file_path, description)

print('Commentaires ajoutés aux fichiers Dart ciblés de lib/.')