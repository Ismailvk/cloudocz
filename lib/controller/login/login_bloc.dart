// ignore_for_file: use_build_context_synchronously
import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cloudocz/data/shared_preference/shared_preference.dart';
import 'package:cloudocz/model/user_model.dart';
import 'package:cloudocz/repositories/login_repo.dart';
import 'package:cloudocz/utils/logger.dart';
part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginUser>(loginUser);
  }

  FutureOr<void> loginUser(LoginUser event, Emitter<LoginState> emit) async {
    emit(LoginLoadingState());
    try {
      final data = await LoginRepo().loginUser(event.loginData);
      data.fold((error) {
        Logger.log('Got error', type: LogType.error);
        LoginErrorSate(message: error.message.toString());
      }, (response) {
        UserProfile userProfile = UserProfile.fromJson(response);
        SharedPreference.instance.storeToken(userProfile.token);
        SharedPreference.instance.storeImage(userProfile.image);
        SharedPreference.instance.storeName(userProfile.name);
        SharedPreference.instance.storePosition(userProfile.position);
        emit(LoginSuccessState(userProfile: userProfile));
      });
    } catch (e) {
      emit(LoginErrorSate(message: e.toString()));
    }
  }
}
