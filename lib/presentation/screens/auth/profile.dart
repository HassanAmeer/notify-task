import 'dart:io';
import 'package:abshartodo/presentation/screens/auth/bloc/auth_bloc.dart';
import 'package:abshartodo/presentation/screens/auth/login.dart';
import 'package:abshartodo/presentation/widgets/delete_alert.dart';
import 'package:abshartodo/presentation/widgets/error_box.dart';
import 'package:abshartodo/presentation/widgets/textformfield.dart';
import 'package:abshartodo/utils/assets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:simple_ripple_animation/simple_ripple_animation.dart';
import '../../../contants/apptheme.dart';
// import 'package:flutter_andomie/core.dart';
// import 'package:manager/vm/authvm.dart';
// import 'package:provider/provider.dart';
// import '../../utils/colors.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // Controllers for the text fields
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    syncFirstF();
    super.initState();
  }

  syncFirstF() async {
    var authLoadedData =
        BlocProvider.of<AuthBloc>(context, listen: false).state;
    if (authLoadedData is AuthLoaded) {
      _emailController.text = authLoadedData.userProfile.email ?? '';
      _passController.text = authLoadedData.userProfile.password ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("user Profile"),
          actions: [
            IconButton(
                onPressed: () {
                  deleteAccountAlert(context, title: "Logout ?",
                      onTap: () async {
                    await FirebaseAuth.instance.signOut();
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginPage()));
                  });
                },
                icon: const Icon(Icons.exit_to_app))
          ],
        ),
        body: SingleChildScrollView(child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.05),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.3,
                            child: Stack(children: [
                              RippleAnimation(
                                  color: MaterialColors.deepOrange.shade400,
                                  delay: const Duration(milliseconds: 300),
                                  repeat: true,
                                  minRadius: 35,
                                  ripplesCount: 6,
                                  duration: const Duration(milliseconds: 1500),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: Hero(
                                      tag: "profile",
                                      child: CircleAvatar(
                                          radius: 50,
                                          child: InkWell(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              onTap: () async {
                                                var img = await ImagePicker()
                                                    .pickImage(
                                                        source: ImageSource
                                                            .gallery);
                                                if (img != null) {
                                                  context.read<AuthBloc>().add(
                                                      AuthupdateProfileImageEvent(
                                                          context: context,
                                                          imgPickerPath:
                                                              img.path));
                                                }
                                              },
                                              child: state is AuthLoaded &&
                                                      state.imgPickerPath
                                                          .isNotEmpty
                                                  ? Image.file(
                                                      File(state.imgPickerPath))
                                                  : state is AuthLoaded &&
                                                          state.imgPickerPath
                                                              .isEmpty
                                                      ? CachedNetworkImage(
                                                          imageUrl: state
                                                              .userProfile
                                                              .profileImageUrl,
                                                          placeholder: (context,
                                                                  url) =>
                                                              CircularProgressIndicator(
                                                                strokeWidth: 2,
                                                                backgroundColor:
                                                                    MaterialColors
                                                                        .deepOrange
                                                                        .shade200,
                                                              ),
                                                          errorWidget: (context,
                                                                  url, error) =>
                                                              Image.asset(
                                                                  Assets.user))
                                                      : Image.asset(
                                                          Assets.user))),
                                    ),
                                  )),
                              Positioned(
                                  right: 0,
                                  bottom: 6,
                                  child: CircleAvatar(
                                      radius: 15,
                                      child: state is AuthLoading
                                          ? Transform.scale(
                                              scale: 0.7,
                                              child: CircularProgressIndicator
                                                  .adaptive(
                                                strokeWidth: 2,
                                                backgroundColor: MaterialColors
                                                    .deepOrange.shade200,
                                              ),
                                            )
                                          : const Icon(Icons.edit, size: 20)))
                            ])),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.1),
                        Opacity(
                            opacity: 1,
                            child: TextFormFieldCustom(
                                controller: _emailController, enabled: false)),
                        Opacity(
                            opacity: 1,
                            child: TextFormFieldCustom(
                                controller: _passController, enabled: false)),
                      ]),
                ));
          },
        )),
        bottomNavigationBar: BottomAppBar(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
                height: 38.0,
                width: MediaQuery.of(context).size.width * 0.5,
                child: Opacity(
                  opacity: 0.4,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            MaterialColors.deepOrange.shade300)),
                    onPressed: () {
                      // if (_formKey.currentState!.validate()) {
                      //   final mapData = {
                      //     "email": _emailController.text,
                      //     "password": _passController.text,
                      //   };
                      //   vmVal.updateAdminAuthF(context, mapData: mapData);
                      // } else {
                      //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      //       content: const Text('All Fields Required'),
                      //       action: SnackBarAction(
                      //           label: 'Ok!', onPressed: () {})));
                      // }
                    },
                    child:
                        // vMval.isLoading
                        //     ?
                        // CircularProgressIndicator.adaptive(
                        //         backgroundColor:
                        //             MaterialColors.deepOrange.shade100)
                        //     :
                        const Text('Update Profile',
                            style: TextStyle(color: Colors.white)),
                  ),
                )),
            Text(" Email Password can Not Modify",
                style: TextStyle(color: Colors.orange.shade800, fontSize: 11)),
          ],
        )));
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passController.dispose();
    super.dispose();
  }
}
