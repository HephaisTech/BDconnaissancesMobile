// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

var baseUrl = 'http://127.0.0.1:8050/api/v3';
// var baseUrl = 'http://192.168.101.183:8050/api/v3';
var token = '7|UBB18IqXOWz15yfupDwofiJ7Lt3PnX2dsqMcAeVx';

class App extends GetxController {
  static String? lang = 'en';
  static bool mainThemeColor = true;
  static Color textColor = Colors.black;
  static Color backgroundColor = Colors.white;
  static Color loaderColor = const Color.fromARGB(255, 3, 122, 201);
  static final getStorage = GetStorage();
  final positionPermission = '';
  static var DarkMode = false.obs;
  static String token = '';
  static const imgplaceholder =
      "https://i.pinimg.com/564x/c2/67/d4/c267d4a76c9dd312b888e373c6eac785.jpg";
  static List<dynamic> categories = [];

  App() {
    lang = getStorage.read('language');
    DarkMode.value = IsDarkMode();
    mainThemeColor = getStorage.read('main_theme_color') ?? true;
    textColor = mainThemeColor ? Colors.black : Colors.white;
    backgroundColor = mainThemeColor ? Colors.white : Colors.black;
    loaderColor = mainThemeColor ? Colors.amber : Colors.amber;
    categories = [];
  }

  static final Map gradientColors = {
    'dark': const LinearGradient(
      colors: [
        Color(0xFF009d62),
        Color(0xFF00a69c),
      ],
    ),
    'purple': const LinearGradient(colors: [
      Color(0xFF5c37f6),
      Color(0xFFbe4af4),
    ]),
    'green': const LinearGradient(colors: [
      Color(0xFF009d62),
      Color(0xFF00a69c),
    ]),
    'blue': const LinearGradient(colors: [
      Color(0xFF0b6dd9),
      Color(0xFF5fabff),
    ]),
    'orange': const LinearGradient(colors: [
      Color(0xFFde6426),
      Color(0xFFedb01b),
    ]),
  };
  static final kgradientColors = [
    const LinearGradient(
      colors: [
        Color(0xFF009d62),
        Color(0xFF00a69c),
      ],
    ),
    const LinearGradient(colors: [
      Color(0xFF5c37f6),
      Color(0xFFbe4af4),
    ]),
    const LinearGradient(colors: [
      Color(0xFF009d62),
      Color(0xFF00a69c),
    ]),
    const LinearGradient(colors: [
      Color(0xFF0b6dd9),
      Color(0xFF5fabff),
    ]),
    const LinearGradient(colors: [
      Color(0xFFde6426),
      Color(0xFFedb01b),
    ]),
  ];

// charger le theme de l'appli
  static ThemeMode GetThemeMode() {
    return Get.isDarkMode ? ThemeMode.dark : ThemeMode.light;
  }

// lire le dernier theme de l'utilisateur
  static IsDarkMode() {
    return DarkMode.value = getStorage.read('DarkMode') ?? false;
  }

// changer le theme actuelle de l'appli
  static changeTheme() {
    if (DarkMode.value) {
      Get.changeThemeMode(ThemeMode.light);
      DarkMode.value = false;
    } else {
      Get.changeThemeMode(ThemeMode.dark);
      DarkMode.value = true;
    }
    saveTheme();
  }

// écrire le dernier theme de l'utilisateur
  static saveTheme() {
    getStorage.write('DarkMode', DarkMode.value);
    debugPrint(DarkMode.value.toString());
  }

  static readTheme() {
    DarkMode.value = getStorage.read('DarkMode') ?? false;
    Get.changeThemeMode(DarkMode.value ? ThemeMode.dark : ThemeMode.light);
  }

  // static getScreenshoote(String source) async {
  //   final browser = await puppeteer.launch(headless: false);

  //   // final page = await browser.newPage();

  //   // await page.setViewport(
  //   //     const DeviceViewport(isLandscape: true, width: 1080, height: 720));

  //   // await page.goto(source);

  //   // final screenshot = await page.screenshot();

  //   // final TempDir = await getTemporaryDirectory();
  //   // final path = '$TempDir/screenshot.png';

  //   // await File(path).writeAsBytes(screenshot);

  //   // GallerySaver.saveImage(path, albumName: 'cdatargets');
  //   // return path;
  // }

// changer la langue de l'appli
  static changeLang(String loc) {
    var local = Locale(loc, '');
    Get.updateLocale(local);
    lang = loc;
    getStorage.write('language', loc);
  }

// changer la langue de l'appli
  static setAppLang() {
    var appLang = getStorage.read('language') ?? 'en';
    var local = Locale(appLang, '');
    Get.updateLocale(local);
  }

// connexion utilisateur
  static Future<bool> signin(String user, String pass) async {
    var url = Uri.parse('${baseUrl}partner/identify');
    var data = {
      'username': user,
      'password': pass,
    };
    var resp = await http.post(url, body: data);
    var result = jsonDecode(resp.body);
    if (resp.statusCode == 200 && result['error'] == false) {
      // partner.id = result['result']['id'];
      // partner = Partner.fromJson(result['result']);
      App.token = result['result']['token'];
      // getStorage.write('youpartner', partner.toJson());
      getStorage.write('token', App.token);
      return true;
    } else {
      return false;
    }
  }

// verifier si connexion au serveur
  static online() async {
    try {
      final response = await http.get(Uri.parse('https://www.google.com'));
      return response.statusCode == 200 ? true : false;
    } catch (e) {
      e.printError();
      return false;
    }
  }

// Convert a String 's' to Duration hh:mm:ss
  static Duration parseDuration(String s) {
    int hours = 0;
    int minutes = 0;
    int micros;
    List<String> parts = s.split(':');
    if (parts.length > 2) {
      hours = int.parse(parts[parts.length - 3]);
    }
    if (parts.length > 1) {
      minutes = int.parse(parts[parts.length - 2]);
    }
    micros = (double.parse(parts[parts.length - 1]) * 1000000).round();
    return Duration(hours: hours, minutes: minutes, microseconds: micros);
  }

  // To get days between 2 dates
  static int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24).round();
  }

  static String KMBgenerator(num) {
    try {
      if (num > 999 && num < 99999) {
        return "${(num / 1000).toStringAsFixed(1)} K";
      } else if (num > 99999 && num < 999999) {
        return "${(num / 1000).toStringAsFixed(0)} K";
      } else if (num > 999999 && num < 999999999) {
        return "${(num / 1000000).toStringAsFixed(1)} M";
      } else if (num > 999999999) {
        return "${(num / 1000000000).toStringAsFixed(1)} B";
      } else {
        return num.toString();
      }
    } catch (e) {
      return 0.toString();
    }
  }
}
