// ignore_for_file: non_constant_identifier_names

import 'package:ahime/controllers/artisan_controller.dart';
import 'package:ahime/pages/artisan/page_artisantrecherche.dart';
import 'package:flutter/material.dart';
import 'package:ahime/config/utils/my_navbar.dart';
import 'package:ahime/config/utils/resizable.dart';
import 'package:ahime/config/my_config.dart';
import 'package:get/get.dart';
import 'package:platform_detector/platform_detector.dart';
import 'package:text_scroll/text_scroll.dart';

class PageArtisan extends StatelessWidget {
  const PageArtisan({super.key});

  @override
  Widget build(BuildContext context) {
    final ArtisanController controller = Get.find();
    SizeConfig().init(context);
    var myHeight = SizeConfig.safeBlockVertical!;
    var myWidth = SizeConfig.safeBlockHorizontal!;

    return Scaffold(
      backgroundColor: myColorBlue,
      body: SafeArea(
        child: Container(
          width: myWidth * 100,
          height: myHeight * 100,
          color: myColorWhite,
          child: SingleChildScrollView(
            child: Column(
              children: [
                MyNavbar(context: context),
                SlideImgAWidget(
                  context: context,
                  imgPath: '$imageUri/ArtisanS.jpg',
                  title: 'Artisan',
                ),
                ScrollWarningWidget(myWidth: myWidth, myHeight: myHeight),
                Obx(() => controller.isLoading.value
                    ? const CircularProgressIndicator()
                    : CtnMenuWidget(controller: controller)),
                const SizedBox(height: 2),
                Padding(
                  padding: const EdgeInsets.only(left: 3, right: 3),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MyPubText(txLibelle: 'Annonce publicitaire'),
                      SizedBox(height: myHeight * 0.5),
                      // TODO: Add myPub widget if needed
                    ],
                  ),
                ),
                const SizedBox(height: 3),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SlideImgAWidget extends StatelessWidget {
  final BuildContext context;
  final String imgPath;
  final String title;

  const SlideImgAWidget({
    super.key,
    required this.context,
    required this.imgPath,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var myWidth = SizeConfig.safeBlockHorizontal!;
    return Container(
      height: 235,
      width: myWidth * 100,
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage(imgPath), fit: BoxFit.fill),
      ),
      child: Column(
        children: [
          const SizedBox(height: 30),
          Text(
            title,
            style: const TextStyle(
                fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 72),
          BtnRechercherWidget(
            onTap: () {
              if (isMobile()) {
                // TODO: Implement bottom sheet
              }
              if (isWeb()) {
                Get.to(() => const PageArtisantRecherche());
              }
            },
          ),
        ],
      ),
    );
  }
}

class BtnRechercherWidget extends StatelessWidget {
  final VoidCallback onTap;

  const BtnRechercherWidget({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var myWidth = SizeConfig.safeBlockHorizontal!;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: myWidth * 80,
        height: 60,
        decoration: BoxDecoration(
          color: myColorBlue,
          borderRadius: BorderRadius.circular(40),
        ),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search,
              color: Colors.white,
              size: 30.0,
            ),
            Text('Rechercher un métier',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ))
          ],
        ),
      ),
    );
  }
}

class ScrollWarningWidget extends StatelessWidget {
  final double myWidth;
  final double myHeight;

  const ScrollWarningWidget({
    super.key,
    required this.myWidth,
    required this.myHeight,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: myWidth * 100,
      height: 25,
      color: Colors.white,
      child: Row(
        children: [
          ImgWarningWidget(),
          Expanded(
            child: LblWarningWidget(),
          ),
          ImgWarningWidget(),
        ],
      ),
    );
  }
}

class LblWarningWidget extends StatelessWidget {
  const LblWarningWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 30,
      color: Colors.white,
      child: const TextScroll(
        " La confiance n'exclut pas le contrôle nous vous invitons a adopter la bonne attitude, régler après la prestation et à voir notre condition générale d'utilisation article 4.",
        velocity: Velocity(pixelsPerSecond: Offset(30, 0)),
        mode: TextScrollMode.endless,
        style: TextStyle(
          color: Color.fromARGB(255, 236, 13, 13),
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class ImgWarningWidget extends StatelessWidget {
  const ImgWarningWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(2),
      width: 30,
      height: 30,
      child: Image.asset(
        '$imageUri/warning.png',
        fit: BoxFit.fill,
      ),
    );
  }
}

class CtnMenuWidget extends StatelessWidget {
  final ArtisanController controller;

  const CtnMenuWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 5, right: 5),
      child: Column(
        children: [
          // Métier
          Obx(() => DropdownButton<String>(
                value: controller.selectedMetier.value.isEmpty
                    ? null
                    : controller.selectedMetier.value,
                hint: const Text('Sélectionner un métier'),
                items: controller.metiers.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (value) => controller.updateSelectedMetier(value),
              )),
          // Catégorie
          Obx(() => DropdownButton<String>(
                value: controller.selectedCategorie.value.isEmpty
                    ? null
                    : controller.selectedCategorie.value,
                hint: const Text('Sélectionner une catégorie'),
                items: controller.categories.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (value) => controller.updateSelectedCategorie(value),
              )),
          // Ville
          Obx(() => DropdownButton<String>(
                value: controller.selectedVille.value.isEmpty
                    ? null
                    : controller.selectedVille.value,
                hint: const Text('Sélectionner une ville'),
                items: controller.villes.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (value) => controller.updateSelectedVille(value),
              )),
          // Commune
          TextField(
            onChanged: controller.updateCommune,
            decoration: const InputDecoration(labelText: 'Commune'),
          ),
          // Quartier
          TextField(
            onChanged: controller.updateQuartier,
            decoration: const InputDecoration(labelText: 'Quartier'),
          ),
          ElevatedButton(
            onPressed: controller.searchArtisans,
            child: const Text('Rechercher'),
          ),
        ],
      ),
    );
  }
}

class MyPubText extends StatelessWidget {
  final String txLibelle;

  const MyPubText({super.key, required this.txLibelle});

  @override
  Widget build(BuildContext context) {
    return Text(
      txLibelle,
      style: const TextStyle(
        color: myColorBlue,
        fontSize: 13,
      ),
    );
  }
}
