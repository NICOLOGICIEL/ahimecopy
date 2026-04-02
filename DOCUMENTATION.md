# Documentation complète du projet Ahime

## 1. Vue d’ensemble

Ce projet est une application Flutter nommée **Ahime**. Elle utilise principalement :

- **Flutter** pour l’interface utilisateur
- **GetX** pour la navigation, l’injection de dépendances et l’état réactif
- **Dio** et parfois **http** pour les appels réseau
- plusieurs utilitaires personnalisés dans `lib/config/my_config.dart`

L’application semble proposer plusieurs domaines fonctionnels :

- **Accueil**
- **Transport**
- **Hôtel**
- **Artisan**
- **Immobilier**

L’architecture générale suit globalement ce schéma :

- **main.dart** : point d’entrée
- **bindings/** : injection des dépendances au démarrage
- **controllers/** : logique métier et état réactif
- **models/** : représentation des données
- **services/** : accès API
- **pages/** : interface utilisateur
- **config/** : constantes globales, helpers UI, formatage, webview, géolocalisation et fonctions utilitaires

---

## 2. Structure du projet

### Dossiers principaux analysés

- `lib/main.dart`
- `lib/bindings/app_bindings.dart`
- `lib/config/my_config.dart`
- `lib/config/utils/resizable.dart`
- `lib/controllers/`
- `lib/models/`
- `lib/pages/`
- `lib/services/api_service.dart`

### Logique globale

Le projet suit une architecture proche de :

**UI → Controller → Service API → JSON → Model → UI**

Cela signifie :

1. l’utilisateur interagit avec l’interface
2. la page délègue la logique au contrôleur
3. le contrôleur appelle le service API
4. la réponse JSON est convertie en modèle Dart
5. l’interface se met à jour automatiquement grâce à GetX

---

## 3. Point d’entrée : `lib/main.dart`

## Rôle

Ce fichier démarre l’application et configure la racine Flutter avec GetX.

## Fonctionnement

### `main()`

```dart
void main() {
  runApp(const MyApp());
}
```

- Lance l’application Flutter
- `MyApp` devient le widget racine

### `MyApp`

La méthode `build()` retourne un `GetMaterialApp`, qui est la version GetX de `MaterialApp`.

### Paramètres importants

- `debugShowCheckedModeBanner: false` : supprime le bandeau DEBUG
- `title: 'Ahime'` : nom logique de l’application
- `theme` : thème global de l’application
- `initialBinding: AppBindings()` : initialise les dépendances GetX
- `home: const PageAccueil()` : page d’accueil au démarrage
- `getPages` : liste des routes nommées

### Routes définies

- `/accueil`
- `/transport`
- `/hotel`
- `/artisan`
- `/immobilier`

---

## 4. Injection des dépendances : `lib/bindings/app_bindings.dart`

## Rôle

Ce fichier enregistre les services et contrôleurs dans GetX.

## Code expliqué

```dart
class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ApiService());
    Get.lazyPut(() => AccueilController());
    Get.lazyPut(() => ArtisanController());
    Get.lazyPut(() => HotelController());
    Get.lazyPut(() => TransportController());
    Get.lazyPut(() => ImmobilierController());
  }
}
```

## Interprétation

- `Get.lazyPut()` diffère la création de l’objet jusqu’à son premier usage
- Tous les contrôleurs deviennent récupérables avec `Get.find()`
- `ApiService` est censé être partagé entre plusieurs contrôleurs

## Remarque

`ArtisanController` n’utilise pas `Get.find<ApiService>()` mais crée directement `ApiService()`. Cela introduit une incohérence avec les autres contrôleurs.

---

## 5. Fichier central de configuration : `lib/config/my_config.dart`

Ce fichier est très volumineux et joue plusieurs rôles.

## 5.1 Constantes graphiques

Le fichier définit les couleurs principales du projet :

- `myColorBlue`
- `myColorBlue2`
- `myColorGreen`
- `myColorWhite`
- `myColorRed`
- etc.

### Utilité

- harmoniser le design
- éviter la répétition de couleurs codées en dur

---

## 5.2 Configuration API

Variables importantes :

- `APIServeur`
- `apiBaseURL`
- `endpoint`
- `endpointINI`
- `apiurl`
- `apiurlINI`

### Rôle

Centraliser l’URL du backend.

---

## 5.3 Navigation Flutter classique

### `pushPage(BuildContext context, Widget page)`

Permet de naviguer vers une nouvelle page avec `Navigator.push`.

### `popPage(BuildContext context)`

Permet de revenir à la page précédente.

### Remarque

Le projet repose surtout sur **GetX** pour la navigation. Ces fonctions sont donc plutôt secondaires.

---

## 5.4 Classe `MyListf`

Cette classe est utilisée avec un dropdown filtrable.

### Rôle

- encapsuler une valeur texte
- fournir une logique de filtrage

### Méthodes

- `toString()` : retourne le nom
- `filter(String query)` : teste si le nom contient la recherche

---

## 5.5 Extension de chaîne

### `StringExtension.capitalized()`

Ajoute une méthode aux chaînes de caractères pour capitaliser proprement la première lettre.

---

## 5.6 Fonctions de formatage

### `moneyFormat(String price)`

- enlève les caractères non numériques
- ajoute un espace tous les 3 chiffres

### `phoneFormat(String number)`

- enlève les caractères non numériques
- ajoute un espace tous les 2 chiffres

---

## 5.7 Helpers d’images

### `myNetImage(...)`

Affiche une image réseau avec :

- indicateur de chargement
- animation d’apparition
- fallback en cas d’erreur

### `myMemoryImage(...)`

Affiche une image à partir d’octets mémoire.

### `myAssetImage(String imgUrl)`

Affiche une image locale depuis les assets.

### `logoIcon(...)` et `logoIconD(...)`

Construisent des widgets d’image/logo réutilisables.

---

## 5.8 Composants UI réutilisables

### `ntEtoile(...)`

Retourne un widget de notation par étoiles.

### `class myButton`

Un bouton personnalisable avec :

- label
- couleur
- rayon de bordure
- style texte
- callback `onPressed`

### `myBtn(...)`

Version utilitaire sous forme de fonction.

### `myBtnIcon()`

Bouton avec icône prédéfinie.

---

## 5.9 Anciennes fonctions réseau

Le fichier contient aussi plusieurs fonctions réseau globales :

- `getData`
- `postData`
- `getdata`
- `postdata`
- `sendReq`

### Rôle

- exécuter des GET/POST
- décoder le JSON
- renvoyer une liste

### Observation importante

Il existe ici un chevauchement avec `lib/services/api_service.dart`.

Cela montre que le projet semble être en transition entre :

1. une ancienne approche réseau globale
2. une approche plus propre par service dédié

---

## 5.10 Construction de requêtes et payloads

Le fichier contient plusieurs fonctions qui fabriquent des chaînes SQL ou des structures de données :

- `mydata(...)`
- `dataMulti(...)`
- `dataR(...)`
- `myReq(...)`
- `myReqArtisant(...)`
- `myReqTransport(...)`
- `myReqHoraire(...)`
- `myReqEscale(...)`

### Rôle

Construire dynamiquement les requêtes de recherche selon les filtres saisis.

### Principe général

1. on prépare plusieurs segments de requête
2. on supprime ceux qui ne sont pas utiles
3. on concatène l’ensemble dans une requête finale

### Point sensible

Construire du SQL sous forme de chaînes côté client est fragile et doit être manipulé avec prudence.

---

## 5.11 Fonctions utilitaires diverses

### `tTotal(int nbrTot)`

Retourne un libellé correct :

- `1 résultat trouvé`
- `N résultats trouvés`

### `imgBase64Dec(img)`

Décode une image encodée en Base64.

---

## 5.12 Lancement d’actions externes

Fonctions :

- `launchURL`
- `launchCALL`
- `launchSMS`
- `launchURI`
- `defMAPS`
- `glMAPS`

### Rôle

Permettre l’ouverture de :

- liens externes
- téléphone
- SMS
- cartes

---

## 5.13 Presse-papiers et SnackBar

### `copyClipBord(...)`

- copie du texte dans le presse-papiers
- affiche une confirmation via `SnackBar`

### `fnSnackmsg(context, txtmsg)`

Affiche un message temporaire à l’écran.

---

## 5.14 Widgets webview

### `MyBrowser`

Utilise `flutter_inappwebview`.

### `MyBrowserView`

Utilise `webview_flutter`.

### `myPub({required String myUrl})`

Choisit automatiquement le widget webview selon la plateforme.

Usage observé : affichage de publicités ou contenus distants.

---

## 5.15 Listes globales

Des listes préparées existent pour les dropdowns :

- `listPays`
- `listVille`
- `listCat`
- `listMetier`
- `listCompagnie`

Elles servent de base de données locale simple ou de valeurs par défaut.

---

## 5.16 Géolocalisation

### `determinePosition()`

Étapes exécutées :

1. vérifie si la localisation est activée
2. vérifie les permissions
3. demande les permissions si nécessaire
4. renvoie la position GPS actuelle

### `locationSettings`

Paramètres de précision et distance minimale de mise à jour.

---

## 6. Service API : `lib/services/api_service.dart`

## Rôle

Centraliser les appels réseau dans une classe dédiée.

## Construction

Le service utilise **Dio** avec :

- `baseUrl: APIServeur`
- `connectTimeout: 10s`
- `receiveTimeout: 10s`

## Méthodes génériques

### `get(String endpoint, {Map<String, dynamic>? queryParameters})`

Envoie une requête GET.

### `post(String endpoint, {Map<String, dynamic>? data})`

Envoie une requête POST.

Les erreurs sont capturées puis transformées en exceptions lisibles.

---

## 6.1 Méthodes métier du service API

### `getArtisans(...)`

Envoie une requête pour récupérer les artisans selon des filtres optionnels.

### `getHotels(...)`

Récupère les hôtels selon une requête texte et un type.

### `searchTransportsByLine(...)`

Recherche des transports par ville de départ et ville d’arrivée.

### `searchTransportsByCompagnie(...)`

Recherche par compagnie.

### `getCompagnies()`

Charge la liste des compagnies.

### `getImmobiliers(...)`

Recherche les biens immobiliers selon :

- mot-clé
- type
- ville

### `getVilles()`

Charge la liste des villes.

---

## 7. Contrôleurs GetX

Les contrôleurs sont responsables :

- de l’état réactif
- de la logique de filtrage
- des appels API
- de la transformation JSON → modèle

---

## 7.1 `AccueilController`

Fichier : `lib/controllers/accueil_controller.dart`

### Rôle

Controller très simple dédié à la navigation.

### Méthodes

- `navigateToTransport()`
- `navigateToHotel()`
- `navigateToArtisan()`
- `navigateToImmobilier()`

Chaque méthode redirige vers une route GetX nommée.

---

## 7.2 `ArtisanController`

Fichier : `lib/controllers/artisan_controller.dart`

### Rôle

Gérer le formulaire et la recherche d’artisans.

### États réactifs

- `isLoading`
- `artisans`
- `metiers`
- `categories`
- `villes`

### Filtres réactifs

- `selectedMetier`
- `selectedCategorie`
- `selectedVille`
- `commune`
- `quartier`

### Cycle de vie

#### `onInit()`

Appelle `loadInitialData()`.

#### `loadInitialData()`

- active le chargement
- appelle l’API pour récupérer métiers et catégories
- remplit `metiers` et `categories`
- coupe le chargement

#### `searchArtisans()`

- récupère les filtres actuels
- appelle l’API
- convertit chaque JSON en `ArtisanModel`
- remplit `artisans`

### Méthodes de mise à jour

- `updateSelectedMetier`
- `updateSelectedCategorie`
- `updateSelectedVille`
- `updateCommune`
- `updateQuartier`

### Observation

Le contrôleur possède `villes`, mais cette liste n’est pas chargée dans `loadInitialData()`.

---

## 7.3 `HotelController`

Fichier : `lib/controllers/hotel_controller.dart`

### Rôle

Gérer la recherche d’hôtels.

### État réactif

- `isLoading`
- `hotels`
- `searchQuery`
- `selectedType`
- `villes`
- `communes`

### Cycle de vie

#### `onInit()`

Appelle `loadInitialData()`.

#### `loadInitialData()`

- charge les hôtels initiaux
- charge les villes

#### `fetchHotels({query, type})`

- appelle `ApiService.getHotels(...)`
- convertit le résultat en `HotelModel`
- met à jour `hotels`

#### `loadVilles()`

Charge la liste des villes.

#### `updateSearchQuery(String query)`

Met à jour le texte de recherche puis déclenche une recherche.

#### `updateSelectedType(String? type)`

Met à jour le type sélectionné puis relance la recherche.

#### `searchHotels()`

Recherche manuelle avec les filtres actifs.

---

## 7.4 `TransportController`

Fichier : `lib/controllers/transport_controller.dart`

### Rôle

Gérer la recherche transport selon deux modes :

- par ligne
- par compagnie

### États réactifs

- `isLoading`
- `transports`
- `selectedVilleDepart`
- `selectedVilleArrivee`
- `selectedCompagnie`
- `searchMode`
- `villes`
- `compagnies`

### Cycle de vie

#### `onInit()`

Appelle `loadInitialData()`.

#### `loadInitialData()`

Charge :

- les villes
- les compagnies

#### `searchTransports()`

Selon `searchMode` :

- appelle `searchTransportsByLine(...)`
- ou appelle `searchTransportsByCompagnie(...)`

Puis convertit les résultats en `TransportModel`.

### Méthodes de saisie

- `updateVilleDepart`
- `updateVilleArrivee`
- `updateCompagnie`
- `setSearchMode`

### `setSearchMode(String mode)`

Change le mode et réinitialise les champs devenus inutiles.

---

## 7.5 `ImmobilierController`

Fichier : `lib/controllers/immobilier_controller.dart`

### Rôle

Gérer la recherche immobilière.

### États réactifs

- `isLoading`
- `immobiliers`
- `searchQuery`
- `selectedType`
- `selectedVille`
- `villes`
- `types`

### Cycle de vie

#### `onInit()`

Appelle `loadInitialData()`.

#### `loadInitialData()`

- charge les biens immobiliers initiaux
- charge les villes

#### `fetchImmobiliers({query, type, ville})`

Appelle le service puis convertit les résultats en `ImmobilierModel`.

#### `updateSearchQuery`, `updateSelectedType`, `updateSelectedVille`

Met à jour les filtres et relance la recherche.

#### `searchImmobiliers()`

Recherche manuelle avec les filtres actifs.

---

## 8. Modèles de données

Les modèles servent à convertir les réponses JSON en objets Dart plus propres.

---

## 8.1 `ArtisanModel`

Fichier : `lib/models/artisan_model.dart`

### Champs

- `id`
- `nom`
- `metier`
- `categorie`
- `ville`
- `commune`
- `quartier`
- `note`

### `fromJson`

Construit un objet depuis une map JSON et protège contre les valeurs nulles.

---

## 8.2 `HotelModel`

Fichier : `lib/models/hotel_model.dart`

### Champs

- `id`
- `nom`
- `type`
- `ville`
- `commune`
- `quartier`
- `note`
- `description`

---

## 8.3 `TransportModel`

Fichier : `lib/models/transport_model.dart`

### Champs

- `id`
- `compagnie`
- `villeDepart`
- `villeArrivee`
- `horaire`
- `prix`
- `type`

### Particularité

Le mapping JSON utilise des clés backend comme `ville_depart`.

---

## 8.4 `ImmobilierModel`

Fichier : `lib/models/immobilier_model.dart`

### Champs

- `id`
- `titre`
- `type`
- `ville`
- `commune`
- `quartier`
- `prix`
- `description`
- `chambres`
- `superficie`

---

## 9. Responsive : `lib/config/utils/resizable.dart`

## Rôle

La classe `SizeConfig` permet d’adapter l’interface à la taille de l’écran.

## Fonctionnement

La méthode `init(BuildContext context)` calcule :

- la largeur écran
- la hauteur écran
- les unités de bloc horizontales et verticales
- les blocs sécurisés tenant compte des zones système

### Variables importantes

- `screenWidth`
- `screenHeight`
- `blockSizeHorizontal`
- `blockSizeVertical`
- `safeBlockHorizontal`
- `safeBlockVertical`

### Utilisation typique

```dart
SizeConfig().init(context);
var myWidth = SizeConfig.safeBlockHorizontal!;
var myHeight = SizeConfig.safeBlockVertical!;
```

---

## 10. Pages principales

---

## 10.1 `lib/pages/page_accueil.dart`

## Rôle

Page d’entrée de l’application.

### Contenu principal

- barre d’en-tête
- publicité intégrée via webview
- catégories
- partenaires
- pied de page

### `DoubleBackToCloseApp`

Force l’utilisateur à appuyer deux fois sur retour pour quitter.

### `listCategorie`

Widget qui affiche les cartes cliquables :

- Transport
- Hôtel
- Artisan
- Immobilier

Chaque carte appelle une méthode du `AccueilController`.

### `headBar`

Affiche le logo, le texte de bienvenue et une icône menu.

### `MyFooter`

Affiche les réseaux sociaux et le copyright.

### `logoSociete`

Affiche les logos partenaires.

---

## 10.2 `lib/pages/artisan/page_artisan.dart`

## Rôle

Page d’entrée du module artisan avec un formulaire de recherche.

### Structure

- `MyNavbar`
- bannière image
- bouton rechercher
- bandeau de prévention défilant
- formulaire de filtres
- zone publicitaire

### `PageArtisan`

Récupère `ArtisanController` via `Get.find()`.

### `SlideImgAWidget`

Affiche la bannière du module artisan.

Le bouton rechercher :

- sur mobile : comportement `TODO`
- sur web : ouvre `PageArtisantRecherche`

### `ScrollWarningWidget`

Affiche un texte de prudence défilant à l’utilisateur.

### `CtnMenuWidget`

Formulaire contenant :

- dropdown métier
- dropdown catégorie
- dropdown ville
- champ commune
- champ quartier
- bouton rechercher

Le bouton lance `controller.searchArtisans()`.

### Observation

Le dropdown ville dépend de `controller.villes`, mais cette liste n’est pas chargée dans le contrôleur.

---

## 10.3 `lib/pages/hotel/page_hotel.dart`

## Rôle

Page de recherche hôtel.

### Structure

- `MyNavbar`
- `SlideImg`
- champ de recherche
- menu de raccourcis
- état de chargement / résumé des résultats
- publicité

### Champ de recherche

- `onChanged` appelle `controller.updateSearchQuery`
- le bouton loupe appelle `controller.searchHotels`

### Menu de boutons

Trois actions :

1. `Résidence meublée`
2. `Hôtels`
3. `Recherche filtrée`

Les deux premières ouvrent `PageHotelResult` avec des paramètres.

### Point important

La troisième option appelle `Get.toNamed('/hotel/search')`, mais cette route n’est pas définie dans `main.dart`.

### Résultats actuels

La page n’affiche pas encore la liste détaillée des hôtels, seulement un compteur.

---

## 10.4 `lib/pages/transport/page_transport.dart`

## Rôle

Permet la recherche de transport par :

- ligne
- compagnie

### Structure

- `MyNavbar`
- `SlideImg`
- conteneur à onglets
- publicité

### Onglet `Ligne`

Contient :

- ville de départ
- ville d’arrivée
- bouton rechercher

Le bouton :

1. lance `controller.searchTransports()`
2. ouvre `PageTransportResult`

### Onglet `Compagnie`

Contient :

- liste des compagnies
- bouton rechercher

Le bouton :

1. lance `controller.searchTransports()`
2. ouvre `PageTransportResult`

### `TabBar`

Met à jour le mode via `controller.setSearchMode(...)`.

---

## 10.5 `lib/pages/immobilier/page_immobilier.dart`

## Rôle

Page de recherche immobilière.

### Structure

- `MyNavbar`
- `SlideImg`
- recherche texte
- filtre type
- filtre ville
- bouton rechercher
- résumé des résultats
- publicité

### Comportement

- le champ texte met à jour `searchQuery`
- le dropdown type met à jour `selectedType`
- le dropdown ville met à jour `selectedVille`
- le bouton lance `searchImmobiliers()`

### Résultats actuels

Comme pour l’hôtel, seule une synthèse textuelle est affichée, pas encore une liste détaillée.

---

## 11. Flux d’exécution pas à pas

### Étape 1 : démarrage

- Flutter lance `main()`
- `MyApp` construit `GetMaterialApp`
- `AppBindings` enregistre les dépendances
- `PageAccueil` s’affiche

### Étape 2 : navigation

L’utilisateur choisit une catégorie depuis l’accueil.

Le `AccueilController` redirige vers le module correspondant.

### Étape 3 : initialisation du module

La page récupère son contrôleur avec `Get.find()`.

Si le contrôleur implémente `onInit()`, il charge les données nécessaires.

### Étape 4 : interaction utilisateur

L’utilisateur saisit des filtres :

- texte
- dropdowns
- boutons

Chaque modification alimente le contrôleur.

### Étape 5 : appel réseau

Le contrôleur appelle `ApiService`.

### Étape 6 : transformation des données

Le JSON backend est converti en :

- `ArtisanModel`
- `HotelModel`
- `TransportModel`
- `ImmobilierModel`

### Étape 7 : mise à jour de l’UI

Les variables observables `.obs` changent.

Les widgets entourés par `Obx()` se reconstruisent automatiquement.

---

## 12. Points forts de l’architecture

- bonne séparation générale entre UI, logique et données
- GetX utilisé pour navigation et réactivité
- modèles simples et lisibles
- service API dédié présent
- composants UI réutilisables
- gestion responsive via `SizeConfig`

---

## 13. Incohérences ou limites observées

### 1. Double couche réseau

Le projet possède :

- des fonctions réseau dans `my_config.dart`
- un `ApiService` dédié

### 2. Incohérence d’injection dans `ArtisanController`

Il instancie directement `ApiService()` au lieu d’utiliser `Get.find<ApiService>()`.

### 3. Liste des villes artisan non chargée

Le dropdown existe dans l’interface mais la donnée n’est pas récupérée.

### 4. Routes ou pages référencées mais non incluses dans l’analyse

Exemples :

- `PageArtisantRecherche`
- `PageHotelResult`
- `PageTransportResult`
- `MyNavbar`
- `SlideImg`

### 5. Route potentiellement manquante

`/hotel/search` est appelée mais n’est pas enregistrée dans `main.dart`.

### 6. Résultats partiellement implémentés

Les pages hôtel et immobilier affichent seulement un résumé au lieu d’une vraie liste détaillée.

### 7. `my_config.dart` concentre trop de responsabilités

Ce fichier contient à lui seul :

- design
- réseau
- formatage
- widgets
- webview
- géolocalisation
- lancement d’URL
- génération de requêtes

Cela complique sa maintenance.

---

## 14. Résumé simple par fichier

### `lib/main.dart`

Point d’entrée, thème, routes, initialisation GetX.

### `lib/bindings/app_bindings.dart`

Enregistrement des services et contrôleurs.

### `lib/config/my_config.dart`

Fichier utilitaire global multi-usage.

### `lib/config/utils/resizable.dart`

Calcul responsive basé sur la taille écran.

### `lib/services/api_service.dart`

Service réseau principal basé sur Dio.

### `lib/controllers/accueil_controller.dart`

Navigation depuis l’accueil.

### `lib/controllers/artisan_controller.dart`

Recherche artisan et filtres.

### `lib/controllers/hotel_controller.dart`

Recherche hôtel et chargement des villes.

### `lib/controllers/transport_controller.dart`

Recherche transport par ligne ou compagnie.

### `lib/controllers/immobilier_controller.dart`

Recherche immobilière par mot-clé, type et ville.

### `lib/models/*.dart`

Mapping JSON → objets métier.

### `lib/pages/page_accueil.dart`

Accueil principal avec catégories et navigation.

### `lib/pages/artisan/page_artisan.dart`

Entrée du module artisan et formulaire de recherche.

### `lib/pages/hotel/page_hotel.dart`

Entrée du module hôtel et recherche simplifiée.

### `lib/pages/transport/page_transport.dart`

Recherche transport avec onglets.

### `lib/pages/immobilier/page_immobilier.dart`

Recherche immobilière avec filtres.

---

## 15. Conclusion

Le projet Ahime est une application Flutter structurée autour de **GetX**, avec une organisation globalement saine entre pages, contrôleurs, modèles et service API. Les fonctionnalités principales sont déjà identifiables et la logique générale est claire.

Le code montre toutefois une coexistence entre ancienne et nouvelle architecture, surtout autour du réseau et des utilitaires globaux. Cela n’empêche pas la compréhension, mais c’est une information importante pour toute évolution future du projet.

Si besoin, la suite logique serait de produire une **documentation encore plus poussée par fichier ou par ligne**, ou de transformer ce document en **documentation technique d’architecture avec diagrammes et recommandations de refactorisation**.