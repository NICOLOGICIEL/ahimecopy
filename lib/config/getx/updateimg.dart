// Utilitaire GetX dédié à la mise à jour d'état pour les images.
// Sert à notifier l'interface lors d'un changement lié aux médias.

import 'package:get/get.dart';

class ImgController extends GetxController {
  var txtDescription = ''.obs;
  var  iMg64=''.obs;

  void fDescription(txt) {
      txtDescription.value = txt;
  }
  void fImg64(img) {
      iMg64.value = img;
  }
}
