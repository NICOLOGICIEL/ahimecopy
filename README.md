# Ahime

Application Flutter Ahime.

## Build Android prête pour le Play Store

Le projet a été préparé pour une publication Android avec :

- identifiant d'application : `com.ahime.app`
- configuration de signature release via `android/key.properties`
- génération d'un bundle Android App Bundle (`.aab`) compatible Play Store
- activation de l'optimisation release (`minifyEnabled` et `shrinkResources`)

## Étapes avant publication

### 1. Créer le keystore de signature

Depuis la racine du projet, génère un keystore upload :

```bash
keytool -genkey -v -keystore upload-keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias upload
```

### 2. Configurer `android/key.properties`

Copie le fichier d'exemple puis remplace les valeurs :

```bash
copy android\key.properties.example android\key.properties
```

Exemple :

```properties
storePassword=VOTRE_MOT_DE_PASSE_KEYSTORE
keyPassword=VOTRE_MOT_DE_PASSE_CLE
keyAlias=upload
storeFile=../upload-keystore.jks
```

### 3. Générer le bundle Play Store

```bash
flutter build appbundle --release
```

Le fichier généré se trouve ici :

```text
build\app\outputs\bundle\release\app-release.aab
```

### 4. Vérifications Play Console à faire

Avant soumission, pense aussi à compléter :

- l'icône application finale
- les captures d'écran
- la bannière graphique Play Store
- la fiche de confidentialité / sécurité des données
- la classification du contenu
- la politique de confidentialité si nécessaire

## Commandes utiles

Installer les dépendances :

```bash
flutter pub get
```

Analyser le projet :

```bash
flutter analyze
```

Construire le bundle Android :

```bash
flutter build appbundle --release
```
