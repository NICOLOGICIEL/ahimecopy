// Utilitaire GetX dédié à la mise à jour d'un texte de résultat.
// Facilite la synchronisation d'un libellé dynamique avec l'interface.

import 'package:get/get.dart';

class NbrController extends GetxController {
  var txtresult = ''.obs;


  @override
  void onClose() {
    txtresult.value = '0 résultat trouvé';
  }

  void tTotal(nbrTot) {
    if (nbrTot <= 1) {
      txtresult.value = '$nbrTot résultat trouvé';
    } else {
      txtresult.value = '$nbrTot résultats trouvés';
    }
  }
}
