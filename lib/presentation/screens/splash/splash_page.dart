import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../contants/apptheme.dart';
import '../../../contants/glitch.dart';
import '../../../utils/assets.dart';
import '../auth/bloc/auth_bloc.dart';
import '../auth/login.dart';
import '../home/homepage.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    onlineSpan();
  }

  onlineSpan() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      BlocProvider.of<AuthBloc>(context, listen: false)
          .add(CheckLoginAuthEvent(context));
      Timer(const Duration(seconds: 3), () async {
        Navigator.of(context).pushReplacement(PageRouteBuilder(
            transitionDuration: const Duration(seconds: 3),
            pageBuilder: (context, animation, secondaryAnimation) =>
                const HomePage(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) =>
                    FadeTransition(opacity: animation, child: child)));
      });
    } else {
      Timer(const Duration(seconds: 3), () async {
        Navigator.of(context).pushReplacement(PageRouteBuilder(
            transitionDuration: const Duration(seconds: 3),
            pageBuilder: (context, animation, secondaryAnimation) =>
                const LoginPage(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) =>
                    FadeTransition(opacity: animation, child: child)));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
        decoration: BoxDecoration(color: MaterialColors.deepOrange[50]),
        child: Scaffold(
            backgroundColor: MaterialColors.deepOrange[50],
            extendBody: true,
            extendBodyBehindAppBar: true,
            body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                      child: SizedBox(
                              width:
                                  MediaQuery.of(context).size.width * 0.8 / 1,
                              child: GlithEffect(
                                  child: Image.asset(Assets.splash)))
                          .animate()
                          .scale()),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                  Text('Todo Task',
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge!
                              .copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: MaterialColors.deepOrange[400],
                                  shadows: [
                                BoxShadow(
                                    color: MaterialColors.deepOrange[200]!,
                                    offset: const Offset(1, 1),
                                    blurRadius: 2)
                              ]))
                      .animate(
                          delay: 500.ms,
                          onPlay: (controller) => controller.repeat())
                      .shakeX()
                      .shimmer(
                          duration: const Duration(seconds: 2),
                          delay: const Duration(milliseconds: 1000))
                      .shimmer(
                          duration: const Duration(seconds: 2),
                          curve: Curves.easeInOut)
                ])));
  }
}

// > Task :url_launcher_android:signingReport
// Variant: debugAndroidTest
// Config: debug
// Store: C:\Users\Hassan Ameer\.android\debug.keystore
// Alias: AndroidDebugKey
// MD5: 32:38:20:57:37:6C:F5:BD:A9:22:37:EC:AE:9A:EE:F3j
// SHA1: 72:9B:EF:3F:CE:88:7C:CA:5E:C1:17:FF:C5:93:5F:CB:B4:8D:E0:76
// SHA-256: 3A:63:FA:43:71:75:82:5A:D0:7D:DA:F6:E6:CC:B8:04:5C:59:A5:66:EE:86:42:8D:53:A3:B0:33:C1:3F:FA:E8
// Valid until: Tuesday, November 25, 2053