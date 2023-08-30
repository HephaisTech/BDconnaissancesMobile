import 'package:bdconnaissance/utils/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ready/ready.dart';
import 'messages/translation.dart';

void main() async {
  await GetStorage.init();
  runApp(
    const ProviderScope(child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        Ready.delegate,
      ],
      supportedLocales: const [
        Locale('en', 'EN'), // English, no country code
        Locale('fr', 'FR'), // French, no country code
      ],
      translations: LocalString(),
      locale: Get.locale,
      debugShowCheckedModeBanner: false,
      fallbackLocale: const Locale('en', 'US'),
      title: 'Base_de_Connaissances'.tr,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        primarySwatch: Colors.amber,
        primaryColor: Colors.blueAccent,
        useMaterial3: true,
      ),
      themeMode: ThemeMode.light,
      darkTheme: ThemeData.dark(),
      home: const Loading(),
    );
  }
}
