import 'package:abshartodo/presentation/screens/auth/bloc/auth_bloc.dart';
import 'package:abshartodo/presentation/widgets/error_box.dart';
import 'package:abshartodo/utils/snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../contants/apptheme.dart';
import '../../../utils/assets.dart';
import '../../widgets/passfield.dart';
import '../../widgets/textformfield.dart';
import '../home/homepage.dart';
import 'login.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController pass2Controller = TextEditingController();
  @override
  void initState() {
    super.initState();
    checkLoginF();
  }

  checkLoginF() async {
    User? user = await FirebaseAuth.instance.currentUser;
    if (user != null) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomePage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return Scaffold(
            bottomNavigationBar: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.06,
                    child: Padding(
                        padding:
                            EdgeInsets.symmetric(
                                horizontal:
                                    MediaQuery.of(context).size.width * 0.04),
                        child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  MaterialColors.deepOrange)),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              if (passController.text.toString() !=
                                  pass2Controller.text.toString()) {
                                snackBarColorF(
                                    'Password Should Be Same', context);
                              } else {
                                context.read<AuthBloc>().add(SignUpEvent(
                                    context: context,
                                    email: emailController.text,
                                    password: passController.text));
                              }
                            }
                          },
                          child: state is AuthLoading
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text('Sign Up',
                                        style: TextStyle(color: Colors.white)),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Transform.scale(
                                        scale: 0.6,
                                        child:
                                            CircularProgressIndicator.adaptive(
                                          backgroundColor: MaterialColors
                                              .deepOrange.shade100,
                                          strokeWidth: 2,
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              : Text("Sign Up",
                                  style: TextStyle(color: Colors.white)),
                        )))
                .animate(onPlay: (controller) => controller.repeat())
                .shimmer(
                    duration: const Duration(seconds: 2),
                    delay: const Duration(seconds: 2)),
            body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    controller: ScrollController(),
                    child: Column(children: [
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.1),
                      Center(
                          child: SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.2 /
                                      1,
                                  child: Image.asset(Assets.splash))
                              .animate(
                                  onPlay: (controller) => controller.repeat())
                              .shimmer(
                                  duration: const Duration(seconds: 2),
                                  delay: const Duration(seconds: 2))),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.1),
                      const Text("SignUp",
                          style: TextStyle(
                              color: MaterialColors.deepOrange,
                              fontSize: 25,
                              fontWeight: FontWeight.bold)),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02),
                      Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 2),
                          child: TextFormFieldCustom(
                              controller: emailController,
                              hint: "Email",
                              validator: (value) {
                                if (value.isEmpty) {
                                  return "Email is Required";
                                }
                              })),
                      Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 2),
                          child: TextFormFieldCustom(
                              controller: passController,
                              hint: "Password",
                              validator: (value) {
                                if (value.isEmpty) {
                                  return "Password is Required";
                                }
                              })),
                      Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 2),
                          child: TextFormFieldCustom(
                              controller: pass2Controller,
                              hint: "Confirm Password",
                              validator: (value) {
                                if (value.isEmpty) {
                                  return "Password is Required";
                                }
                              })),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02),
                      const Text("OR"),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("    Have Account?"),
                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const LoginPage()));
                              },
                              child: const Text("Login"))
                        ],
                      ),
                      if (state is AuthError)
                        ErrorBox(errorMessage: state.errorMsg),
                    ]),
                  ),
                )));
      },
    );
  }
}
