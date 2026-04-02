import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ahime/controllers/immobilier_controller.dart';
import 'package:ahime/config/utils/my_navbar.dart';
import 'package:ahime/config/my_config.dart';
import 'package:ahime/config/utils/resizable.dart';
import 'package:ahime/config/utils/slide_img.dart';

class PageImmobilier extends StatelessWidget {
  const PageImmobilier({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final ImmobilierController controller = Get.find<ImmobilierController>();

    return Scaffold(
      backgroundColor: myColorBlue,
      body: SafeArea(
        child: Container(
          width: SizeConfig.safeBlockHorizontal! * 100,
          height: SizeConfig.safeBlockVertical! * 100,
          color: myColorWhite,
          child: SingleChildScrollView(
            child: Column(
              children: [
                MyNavbar(context: context),
                const SlideImg(
                    imgPath: '$imageUri/ImmobilierS.jpg', title: 'Immobilier'),
                Padding(
                  padding: const EdgeInsets.only(top: 8, left: 7, right: 7),
                  child: Obx(() => Column(
                        children: [
                          // Champ de recherche
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            child: TextField(
                              onChanged: controller.updateSearchQuery,
                              decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                hintText: 'Rechercher par mot clé',
                                suffixIcon: IconButton(
                                  icon: const Icon(Icons.search,
                                      color: myColorBlue),
                                  onPressed: controller.searchImmobiliers,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                  borderSide:
                                      const BorderSide(color: Colors.grey),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                  borderSide:
                                      const BorderSide(color: Colors.grey),
                                ),
                              ),
                            ),
                          ),

                          // Dropdown pour le type
                          Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            child: DropdownButtonFormField<String>(
                              value: controller.selectedType.value,
                              decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                labelText: 'Type',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                              ),
                              items: controller.types.map((type) {
                                return DropdownMenuItem<String>(
                                  value: type,
                                  child: Text(type),
                                );
                              }).toList(),
                              onChanged: controller.updateSelectedType,
                            ),
                          ),

                          // Dropdown pour la ville
                          Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            child: DropdownButtonFormField<String>(
                              value: controller.selectedVille.value.isEmpty
                                  ? null
                                  : controller.selectedVille.value,
                              decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                labelText: 'Ville',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                              ),
                              items: controller.villes.map((ville) {
                                return DropdownMenuItem<String>(
                                  value: ville,
                                  child: Text(ville),
                                );
                              }).toList(),
                              onChanged: controller.updateSelectedVille,
                            ),
                          ),

                          // Bouton rechercher
                          Container(
                            width: double.infinity,
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            child: ElevatedButton(
                              onPressed: controller.searchImmobiliers,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: myColorBlue,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 15),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                              child: const Text(
                                'Rechercher',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                            ),
                          ),

                          // Indicateur de chargement
                          if (controller.isLoading.value)
                            const CircularProgressIndicator()
                          else
                            // Liste des résultats (à implémenter selon vos besoins)
                            Container(
                              height: 200,
                              child: Center(
                                child: Text(
                                  controller.immobiliers.isEmpty
                                      ? 'Aucun résultat trouvé'
                                      : '${controller.immobiliers.length} résultats trouvés',
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ),
                            ),

                          // Annonce publicitaire
                          Container(
                            alignment: Alignment.centerLeft,
                            margin: const EdgeInsets.only(top: 20),
                            child: const Text(
                              'Annonce publicitaire',
                              style: TextStyle(
                                color: myColorBlue,
                                fontSize: 13,
                              ),
                            ),
                          ),
                          // Placeholder pour pub
                          Container(
                            height: 100,
                            color: Colors.grey[200],
                            child: const Center(
                                child: Text('Espace publicitaire')),
                          ),
                        ],
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
