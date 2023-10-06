import 'package:bdconnaissance/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app.dart';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  void initState() {
    super.initState();
    App();
  }

  @override
  Widget build(BuildContext context) {
    return Loader((_) async {
      App.changeLang(Get.locale.toString());
      App.readTheme();
      if (!await App.online()) {
        Future.delayed(const Duration(seconds: 3),
            () => Get.offAll(() => const HomeScreen()));
      } else {
        Get.snackbar('CAGECFI SA', 'Not internet service detected!');
      }
    });
  }
}

class Loader extends StatefulWidget {
  const Loader(this.call, {Key? key}) : super(key: key);

  final dynamic Function(BuildContext context) call;

  @override
  _LoaderState createState() => _LoaderState();
}

class _LoaderState extends State<Loader> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.call(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Color.fromARGB(255, 255, 255, 255),
                Color.fromARGB(255, 0, 140, 255),
                Color.fromARGB(255, 0, 0, 0),
              ],
            ),
          ),
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  alignment: Alignment.center,
                  width: 100,
                  height: 200,
                  child: Text(
                    'CAGECFI SA',
                    style: GoogleFonts.poppins(
                        color: App.backgroundColor,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 50),
                const SizedBox(
                  height: 50,
                  width: 50,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 3,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
