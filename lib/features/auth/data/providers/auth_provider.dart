import 'package:wasq_tech/utils/constants.dart';
import 'package:wasq_tech/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:wasq_tech/utils/hive_manager.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../../app/app_keys.dart';
import '../../../../web_services/interceptors/main_interceptor.dart';
import '../model/user.dart';
import '../repositories/auth_repository.dart';
import '../states/auth_state.dart';

enum LoginStatus { active, waiting, error }

final authNotifierProvider =
    StateNotifierProvider<AuthStateNotifier, AuthState>((ref) {
  final repo = ref.watch(authRepositoryProvider);
  return AuthStateNotifier(repo, null);
});

class AuthStateNotifier extends StateNotifier<AuthState> {
  final AuthRepository _repo;

  AuthStateNotifier(this._repo,
      [AuthState? state])
      : super(state ?? const AuthState()) {
    checkAuthStatus();
    // onFcmTokenRefresh();
  }

  Future<void> checkAuthStatus() async {
    try {
      final User? user = _repo.getUserData();

      // if authenticated, update state accordingly
      if (user != null) {
        state = state.copyWith(
          user: user,
          isLogin: true,
        );
      } else if (getMobileNumber() != null) {
        state = state.copyWith(
        );
      } else {
        state = state.copyWith(
        );
      }
    } catch (_) {}
  }

  bool isUserLoggedIn() {
    return state.user != null;
  }

  changeAuthStatus(authStatus) {
  }

  setAppLang(appLang) {
  }

  login({required String phone}) async {
    try {
      state = state.copyWith(loading: true, errorMessage: '');

      final result = await _repo.login(phone: phone);
      state = state.copyWith(loading: false, errorMessage: '');

      return result;
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString(), loading: false);
      return false;
    }
  }


  getServices() async {
    try {
      state = state.copyWith(registerLoading: true, errorMessage: '');

      final result = await _repo.fetchServices();
      state = state.copyWith(registerLoading: false, errorMessage: '',servicesResponse: result);

      return result;
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString(), registerLoading: false);
      return false;
    }
  }

  getStatics() async {
    try {
      state = state.copyWith(moreLoading: true,);

      final result = await _repo.getStatics();

      state = state.copyWith(
        moreLoading: false,
          user: state.user!.copyWith(
          balance: double.parse(result["balance"].toString()),
          completed_projects: result["completed_projects"],
      ));

      return result;
    } catch (e) {

      state = state.copyWith(errorMessage: e.toString());
      return false;
    }
  }

  register(
      {required String username,
      required String email,
      required String mobile,
       String ? imagePath,
        String  ? idPath,
      required String residentType,
      required String bankName,
        String? stc,
        String? iban,
        List<int>? services,
      }) async {
    try {
      state = state.copyWith(loading: true, errorMessage: '');

      final result = await _repo.register(
          username: username,
          email: email,
          mobile: mobile,
          imagePath: imagePath,
          idPath: idPath,
          residentType: residentType,
          stc: stc,
          iban: iban,
          services:services,
          bankName: bankName,

          );
      state = state.copyWith(loading: false, errorMessage: '');

      return result;
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString(), loading: false);
      return -1;
    }
  }

  onOff({required String active}) async {
    try {
      await _repo.onOff(active: active);
      state = state.copyWith(
        user: state.user!.copyWith(active: active),
        
      );
      HiveManager.addData(StorageKeys.userKey , state.user);
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString());
    }
  }

  otpVerify({
    required String code,
    required int temp_user_id,
    required String phone}) async {
    try {
      state = state.copyWith(loading: true, errorMessage: '');

      final user = await _repo.otpVerify(
        phone: phone,
        code: code,
        temp_user_id: temp_user_id,
      );
      if(user?.status=="active") {
        _onUserLoggedIn(user);
        return LoginStatus.active;
      }
      state = state.copyWith(
          loading: false, user: user, errorMessage: '', isLogin: false);
      return LoginStatus.waiting;
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString(), loading: false);
      return LoginStatus.error;
    }
  }

  void _onUserLoggedIn(User? user) {
    state = state.copyWith(
        loading: false, user: user, errorMessage: '', isLogin: true);
  }

  getMobileNumber() {
    return _repo.getMobileNumber();
  }

  getToken() {
    return _repo.getToken();
  }
  Future<bool>updateUser(
      {
        String? name,
        String? phone
      }) async {
    try {
      state = state.copyWith(loading: true, errorMessage: '');

      final user = await _repo.updateUser(
        phone: phone,
        name: name,
      );
      _onUserLoggedIn(user);
      return true;
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString(), loading: false);
      return false;
    }
  }

  Future<void> logout() async {
    // state = state.copyWith(
    //   loading: false,
    //   errorMessage: '',
    // );

    //we do not need to wait here
    _repo.deleteAuthStorage();
    _repo.deleteTokenCachedData();

    MainInterceptor.logout();

    state = state.copyWith(
      user: null,
      isLogin: false,
      loading: false,
    );
  }

  Future<void> onFcmTokenRefresh() async {
    try {
      // eventBus.on<UpdateFcmTokenEvent>().listen((event) {
      //   updateFcmToken(event.token);
      // });
    } catch (_) {}
  }

  Future<void> updateFcmToken(String? token) async {
    try {
      // final fcmToken = token ?? await _notificationsHandler.getFcmToken();

      // updateUserProfile(
      //     personalData: state.personalData.copyWith(deviceToken: fcmToken),
      //     isUpdatingFcmToken: true);
    } catch (_) {}
  }
}

