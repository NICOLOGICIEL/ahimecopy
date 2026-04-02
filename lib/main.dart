import 'package:ahime/pages/artisan/page_artisan.dart';
import 'package:ahime/pages/hotel/page_hotel.dart';
import 'package:ahime/pages/transport/page_transport.dart';
import 'package:ahime/pages/immobilier/page_immobilier.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ahime/pages/page_accueil.dart';
import 'package:ahime/config/my_config.dart';
import 'package:ahime/bindings/app_bindings.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ahime',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: myColorBlue),
        useMaterial3: true,
      ),
      initialBinding: AppBindings(),
      home: const PageAccueil(),
      getPages: [
        GetPage(name: '/accueil', page: () => const PageAccueil()),
        GetPage(name: '/transport', page: () => const PageTransport()),
        GetPage(name: '/hotel', page: () => const PageHotel()),
        GetPage(name: '/artisan', page: () => const PageArtisan()),
        GetPage(name: '/immobilier', page: () => const PageImmobilier()),
      ],
    );
  }
}
