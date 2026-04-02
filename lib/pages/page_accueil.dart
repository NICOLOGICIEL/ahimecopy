// Page d'accueil principale de l'application.
// Elle présente les différents modules accessibles à l'utilisateur.

import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ahime/controllers/accueil_controller.dart';
import 'package:ahime/config/utils/resizable.dart';
import 'package:ahime/config/my_config.dart';

class _CategoryItem {
  const _CategoryItem({
    required this.title,
    required this.imagePath,
    required this.imageWidth,
    required this.imageHeight,
    required this.onTap,
  });

  final String title;
  final String imagePath;
  final double imageWidth;
  final double imageHeight;
  final VoidCallback onTap;
}

class PageAccueil extends StatelessWidget {
  const PageAccueil({super.key});

  @override
  Widget build(BuildContext context) {
    final AccueilController controller = Get.find();
    SizeConfig().init(context);
    final double myHeight = SizeConfig.safeBlockVertical!;
    final double myWidth = SizeConfig.safeBlockHorizontal!;

    return Scaffold(
      backgroundColor: myColorBlue,
      body: DoubleBackToCloseApp(
        snackBar: SnackBar(
          backgroundColor: Colors.black.withValues(alpha: 0.5),
          margin: const EdgeInsets.all(5),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          content: const Text('Appuyez à nouveau sur retour pour quitter'),
        ),
        child: SafeArea(
          child: Container(
            width: myWidth * 100,
            height: myHeight * 100,
            color: myColorWhite,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: myHeight * 1),
                  const HeadBar(),
                  SizedBox(height: myHeight * 1),
                  myPub(myUrl: 'https://ahime-ci.com/slideshow'),
                  SizedBox(height: myHeight * 1),
                  const CategoryTitle(),
                  SizedBox(height: myHeight * 1),
                  CategoryList(controller: controller),
                  PartnersTitle(heightUnit: myHeight),
                  const CompanyLogos(),
                  SizedBox(height: myHeight * 3),
                  const MyFooter(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CategoryList extends StatelessWidget {
  final AccueilController controller;

  const CategoryList({required this.controller, super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final double myHeight = SizeConfig.safeBlockVertical!;
    final double myWidth = SizeConfig.safeBlockHorizontal!;
    final List<_CategoryItem> items = <_CategoryItem>[
      _CategoryItem(
        title: 'TRANSPORT',
        imagePath: '$imageUri/transport.png',
        imageWidth: 60,
        imageHeight: 50,
        onTap: controller.navigateToTransport,
      ),
      _CategoryItem(
        title: 'HÔTEL',
        imagePath: '$imageUri/hotels.png',
        imageWidth: 45,
        imageHeight: 45,
        onTap: controller.navigateToHotel,
      ),
      _CategoryItem(
        title: 'ARTISAN',
        imagePath: '$imageUri/artisan.png',
        imageWidth: 70,
        imageHeight: 70,
        onTap: controller.navigateToArtisan,
      ),
      _CategoryItem(
        title: 'IMMOBILIER',
        imagePath: '$imageUri/immobilier.png',
        imageWidth: 50,
        imageHeight: 60,
        onTap: controller.navigateToImmobilier,
      ),
    ];

    return SizedBox(
      width: myWidth * 100,
      height: myHeight * 14.2,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 6.5),
        itemCount: items.length,
        separatorBuilder: (_, __) => const SizedBox(width: 6.5),
        itemBuilder: (BuildContext context, int index) {
          final _CategoryItem item = items[index];
          return _CategoryCard(
            title: item.title,
            imagePath: item.imagePath,
            imageWidth: item.imageWidth,
            imageHeight: item.imageHeight,
            onTap: item.onTap,
          );
        },
      ),
    );
  }
}

class _CategoryCard extends StatelessWidget {
  const _CategoryCard({
    required this.title,
    required this.imagePath,
    required this.imageWidth,
    required this.imageHeight,
    required this.onTap,
  });

  final String title;
  final String imagePath;
  final double imageWidth;
  final double imageHeight;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final double myHeight = SizeConfig.safeBlockVertical!;
    final double myWidth = SizeConfig.safeBlockHorizontal!;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: myWidth * 31,
        height: myHeight * 15,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Container(
              width: myWidth * 31,
              height: myHeight * 10,
              decoration: const BoxDecoration(
                color: myColorBlue,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
              child: Center(
                child: Image.asset(
                  imagePath,
                  width: imageWidth,
                  height: imageHeight,
                ),
              ),
            ),
            Container(
              width: myWidth * 31,
              height: myHeight * 4,
              decoration: const BoxDecoration(
                color: myColorGreen,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
              child: Center(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyFooter extends StatelessWidget {
  const MyFooter({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final double myWidth = SizeConfig.safeBlockHorizontal!;

    return Container(
      width: myWidth * 100,
      height: 62,
      color: Colors.white,
      child: Column(
        children: [
          const Text(
            'Retrouvez-nous sur',
            style: TextStyle(
              color: myColorBlue,
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              logoIcon('$imageUri/Face.png', 30, 30),
              SizedBox(width: myWidth * 2),
              logoIcon('$imageUri/what.png', 30, 30),
              SizedBox(width: myWidth * 2),
              logoIcon('$imageUri/insta.png', 30, 30),
              SizedBox(width: myWidth * 2),
              logoIcon('$imageUri/x.png', 30, 30),
            ],
          ),
          const Text(
            'Copyright © 2023 Gek expertise',
            style: TextStyle(
              color: myColorBlue,
              fontSize: 9,
            ),
          ),
        ],
      ),
    );
  }
}

class PartnersTitle extends StatelessWidget {
  const PartnersTitle({required this.heightUnit, super.key});

  final double heightUnit;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      height: heightUnit * 5,
      child: const Center(
        child: Text(
          'Nos partenaires',
          style: TextStyle(
            color: Colors.black,
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class CategoryTitle extends StatelessWidget {
  const CategoryTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: 135,
      height: 24,
      decoration: BoxDecoration(
        color: myColorGreen,
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Text(
        'Catégories',
        style: TextStyle(
          color: Colors.white,
          fontSize: 17,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class HeadBar extends StatelessWidget {
  const HeadBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final double myWidth = SizeConfig.safeBlockHorizontal!;

    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10),
      width: myWidth * 95,
      height: 100,
      decoration: BoxDecoration(
        color: myColorBlue,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 70,
            height: 70,
            color: Colors.grey[300],
            child: Image.asset('$imageUri/ahime.jpg', fit: BoxFit.fill),
          ),
          const Text(
            'Bienvenue',
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: Image.asset('$imageUri/IcMenu.png', width: 30, height: 30),
          ),
        ],
      ),
    );
  }
}

class CompanyLogos extends StatelessWidget {
  const CompanyLogos({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildLogo('$imageUri/gek.jpg'),
          _buildLogo('$imageUri/logoahime.jpg'),
          _buildLogo('$imageUri/aim.jpg'),
        ],
      ),
    );
  }

  Container _buildLogo(String imagePath) {
    final double myHeight = SizeConfig.safeBlockVertical!;
    final double myWidth = SizeConfig.safeBlockHorizontal!;

    return Container(
      width: myWidth * 27,
      height: myHeight * 13,
      color: Colors.grey[300],
      child: Image.asset(imagePath, fit: BoxFit.fill),
    );
  }
}
