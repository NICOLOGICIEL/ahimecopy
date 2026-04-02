import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ahime/controllers/transport_controller.dart';
import 'package:ahime/config/utils/my_navbar.dart';
import 'package:ahime/config/my_config.dart';
import 'package:ahime/config/utils/resizable.dart';
import 'package:ahime/config/utils/slide_img.dart';
import 'package:ahime/pages/transport/page_tranportresult.dart';

class PageTransport extends StatelessWidget {
  const PageTransport({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final TransportController controller = Get.find<TransportController>();

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
                    imgPath: '$imageUri/SldTransport.jpg', title: 'Transport'),
                Padding(
                  padding: const EdgeInsets.only(left: 7, right: 7),
                  child: Obx(() => Column(
                        children: [
                          SizedBox(height: SizeConfig.safeBlockVertical! * 1),
                          _buildTabMenu(context, controller),
                          const SizedBox(height: 1),
                          Container(
                            alignment: Alignment.centerLeft,
                            margin: const EdgeInsets.only(left: 7),
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

  Widget _buildTabMenu(BuildContext context, TransportController controller) {
    return Container(
      width: SizeConfig.safeBlockHorizontal! * 100,
      height: 194,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
      child: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            Container(
              height: 30,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5),
                  topRight: Radius.circular(5),
                ),
                color: myColorGreen,
              ),
              child: TabBar(
                indicatorSize: TabBarIndicatorSize.tab,
                labelColor: Colors.white,
                unselectedLabelColor: Colors.white,
                dividerColor: Colors.transparent,
                indicator: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5),
                    topRight: Radius.circular(5),
                  ),
                  color: myColorBlue,
                ),
                labelStyle: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
                unselectedLabelStyle: const TextStyle(
                  fontSize: 12,
                ),
                tabs: const [
                  Tab(text: 'Ligne'),
                  Tab(text: 'Compagnie'),
                ],
                onTap: (index) {
                  controller.setSearchMode(index == 0 ? 'ligne' : 'compagnie');
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 4),
              height: 164,
              width: SizeConfig.safeBlockHorizontal! * 96,
              child: TabBarView(
                children: [
                  // Onglet Ligne
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildDropdown(
                          'Ville de départ',
                          controller.villes,
                          controller.selectedVilleDepart,
                          controller.updateVilleDepart),
                      const SizedBox(height: 6),
                      _buildDropdown(
                          "Ville d'arrivée",
                          controller.villes,
                          controller.selectedVilleArrivee,
                          controller.updateVilleArrivee),
                      const SizedBox(height: 6),
                      _buildSearchButton('Rechercher', () {
                        controller.searchTransports();
                        Get.to(() => PageTransportResult(
                              titre: 'Transport',
                              xVilleDepart:
                                  controller.selectedVilleDepart.value,
                              xVilleArrivee:
                                  controller.selectedVilleArrivee.value,
                            ));
                      }),
                    ],
                  ),
                  // Onglet Compagnie
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildDropdown(
                          'Destination par compagnie',
                          controller.compagnies,
                          controller.selectedCompagnie,
                          controller.updateCompagnie),
                      const SizedBox(height: 14),
                      _buildSearchButton('Rechercher', () {
                        controller.searchTransports();
                        Get.to(() => PageTransportResult(
                              titre: 'Transport',
                              xCompagnie: controller.selectedCompagnie.value,
                            ));
                      }),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdown(String hintText, List<String> items,
      RxString selectedValue, Function(String?) onChanged) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      child: DropdownButtonFormField<String>(
        initialValue: selectedValue.value.isEmpty ? null : selectedValue.value,
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
        items: items.map((item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(item),
          );
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildSearchButton(String titre, VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(10),
        width: 150,
        height: 40,
        decoration: const ShapeDecoration(
          color: myColorBlue,
          shape: StadiumBorder(),
        ),
        child: Text(
          titre,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
