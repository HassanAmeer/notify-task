import 'package:abshartodo/models/user_tasks.dart';
import 'package:abshartodo/utils/snackbar.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../../../domain/repo/auth_repo.dart';
import '../../../../models/user_model.dart';
import '../../home/homepage.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<CheckLoginAuthEvent>((event, emit) async {
      emit(AuthLoading());
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        emit(AuthLoaded(UserProfile.fromJson(await AuthRepo().getAuthF()), ""));
      }
    });
    on<SignUpEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        var data = await AuthRepo().createWithEmailAndPassword(
            email: event.email, password: event.password);
        emit(AuthLoaded(UserProfile.fromJson(data), ""));
        Navigator.pushReplacement(event.context,
            MaterialPageRoute(builder: (context) => const HomePage()));
      } catch (e, stackTrace) {
        emit(AuthError(e.toString()));
        debugPrint(
            "💥 SignUpEvent->tryCatch Error: $e, stackTrace:$stackTrace");
      }
    });
    on<LoginWithCredntialEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        var data = await AuthRepo().signInWithEmailAndPassword(
            email: event.email, password: event.password);
        emit(AuthLoaded(UserProfile.fromJson(data), ""));
        Navigator.pushReplacement(event.context,
            MaterialPageRoute(builder: (context) => const HomePage()));
      } catch (e, stackTrace) {
        emit(AuthError(e.toString()));
        debugPrint(
            "💥 LoginWithCredntialEvent->tryCatch Error: $e, stackTrace:$stackTrace");
      }
    });
    on<LoginWithGoogleEvent>((event, emit) async {
      emit(AuthLoadingForGoogle());
      try {
        var data = await AuthRepo().loginWithGoogleVMF();
        if (data == false) {
          emit(const AuthError("Sign in By Google Error with Uid"));
        } else {
          emit(AuthLoaded(UserProfile.fromJson(data), ""));
          Navigator.pushReplacement(event.context,
              MaterialPageRoute(builder: (context) => const HomePage()));
        }
      } on PlatformException catch (e, stackTrace) {
        debugPrint(
            "💥 LoginWithGoogleEvent->tryCatch Error: $e, stackTrace:$stackTrace");
        if (e.code == GoogleSignIn.kNetworkError) {
          String errorMessage = "A network error";
          emit(AuthError(errorMessage.toString()));
        } else {
          String errorMessage = "Something went wrong.";
          emit(AuthError(errorMessage.toString()));
        }
      }
    });
    on<AuthupdateProfileImageEvent>((event, emit) async {
      ///////////////////////////////
      emit(AuthLoading());
      try {
        var data = await AuthRepo().updateImage(event.imgPickerPath);
        emit(AuthLoaded(UserProfile.fromJson(data), event.imgPickerPath));
      } catch (e, stackTrace) {
        emit(AuthError(e.toString()));
        debugPrint(
            "💥 AuthupdateProfileImageEvent->tryCatch Error: $e, stackTrace:$stackTrace");
      }
    });

//////////////////////////// Task Section start
    on<TaskUpdateEvent>((event, emit) async {
      try {
        emit(AuthLoading());
        var data =
            await AuthRepo().updateTaskList(userTaskList: event.userTaskList);
        emit(AuthLoaded(UserProfile.fromJson(data), ""));
        snackBarColorF("Success!", event.context);
      } catch (e, stackTrace) {
        emit(AuthError(e.toString()));
        debugPrint(
            "💥 TaskUpdateEvent->tryCatch Error: $e, stackTrace:$stackTrace");
      }
    });
    on<TaskShareByEmailEvent>((event, emit) async {
      try {
        await AuthRepo().taskShareByEmail(event.context,
            email: event.email, task: event.userTask);
      } catch (e, stackTrace) {
        snackBarColorF("$e!", event.context);
        debugPrint(
            "💥 TaskShareByEmailEvent->tryCatch Error: $e, stackTrace:$stackTrace");
      }
    });
//////////////////////////// Task Section end
  }
}
