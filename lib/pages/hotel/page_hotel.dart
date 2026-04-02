// Page principale du module Hôtel.
// Contient les filtres, la recherche, les raccourcis et l'espace publicitaire.

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ahime/controllers/hotel_controller.dart';
import 'package:ahime/config/utils/my_navbar.dart';
import 'package:ahime/config/my_config.dart';
import 'package:ahime/config/utils/resizable.dart';
import 'package:ahime/config/utils/slide_img.dart';
import 'package:ahime/pages/hotel/page_hotelresult.dart';

class PageHotel extends StatelessWidget {
  const PageHotel({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final HotelController controller = Get.find<HotelController>();

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
                const SlideImg(imgPath: '$imageUri/HotelS.jpg', title: 'Hôtel'),
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
                                  onPressed: controller.searchHotels,
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

                          // Menu des options
                          Container(
                            padding: const EdgeInsets.only(top: 5),
                            width: SizeConfig.safeBlockHorizontal! * 100,
                            height: 95,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: [
                                BoxShadow(
                                  color: myColorGreyBorber,
                                  spreadRadius: 1,
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                _buildMenuButton('Résidence \n  meublée',
                                    '$imageUri/ResidenceA.png', () {
                                  Get.to(() => PageHotelResult(
                                      xEstResidence: true, titre: 'Résidence'));
                                }),
                                _buildMenuButton(
                                    'Hôtels', '$imageUri/hotels.png', () {
                                  Get.to(() => PageHotelResult(
                                      xEstHotel: true, titre: 'Hôtel'));
                                }),
                                _buildMenuButton('Recherche \n     filtrée',
                                    '$imageUri/filtre.png', () {
                                  // Navigation vers page de recherche filtrée
                                  Get.toNamed('/hotel/search');
                                }),
                              ],
                            ),
                          ),

                          SizedBox(height: SizeConfig.safeBlockVertical! * 1),

                          // Indicateur de chargement
                          if (controller.isLoading.value)
                            const CircularProgressIndicator()
                          else
                            // Liste des résultats (à implémenter selon vos besoins)
                            SizedBox(
                              height: 100,
                              child: Center(
                                child: Text(
                                  controller.hotels.isEmpty
                                      ? 'Aucun hôtel trouvé'
                                      : '${controller.hotels.length} hôtels trouvés',
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

  Widget _buildMenuButton(String titre, String imgPath, VoidCallback onTap) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(10),
            width: 70,
            height: 50,
            decoration: const ShapeDecoration(
              color: myColorBlue,
              shape: StadiumBorder(),
            ),
            child: Image.asset(imgPath),
          ),
        ),
        const SizedBox(height: 5),
        Text(
          titre,
          style: const TextStyle(
            color: Colors.black54,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
