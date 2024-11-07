import 'package:wasq_tech/web_services/web_services.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../utils/constants.dart';
import '../../../../utils/hive_manager.dart';
import '../model/user.dart';
import 'package:path/path.dart' as path;


abstract class AuthRepository {
  Future<User?> fetchUserData();
  Future<Map<String,dynamic>> getStatics();
  Future<bool> login({required String phone});
  Future<User?> otpVerify({required String phone,required String code,required int temp_user_id,});
  Future<User?> updateUser({String? phone, String? name});
  Future<bool> onOff(
      {
        required String active,
      }
      );
  Future<int> register(
      {required String username,
      required String email,
      required String mobile,
         String ? imagePath,
         String ? idPath,
        required String residentType,
        required String bankName,
        String? stc,
        String? iban,
        List<int>? services,
      });
  Future<ServicesResponse> fetchServices();
  Future<void> registerFCMToken({required String token});

  Future<void> unRegisterFCMToken({required String token});

  void deleteAuthStorage();

  void deleteTokenCachedData();

  getMobileNumber();

  User? getUserData();

  String? getToken();
}

class AuthRepositoryImpl implements AuthRepository {
  @override
  Future<User?> fetchUserData() async {
    try {
      var response = await HttpClient.dio.get("EndPoints");
      _saveUserDataResponse(response.data);

      return User.fromJson(response.data["data"]);
    } catch (e) {
      rethrow;
    }
  }
  @override
  Future<User?> updateUser({String? phone, String? name}) async {
    try {

      final data ={
        if(phone != null)
          "phone": phone,
        if(name != null)
          "name": name,
      };
      var response = await HttpClient.dio.post(EndPoints.updateUser, data: data
        , options: Options(headers: {
          "Accept": "application/json",
        }),);
      if (response.statusCode == 200 || response.statusCode == 201) {
        _saveUserDataResponse(response.data["user"]);

        return User.fromJson(response.data["user"]);
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> onOff(
      {
        required String active,
      }
      ) async {
    try {
      final data = {
        "active": active,
      };
      var response = await HttpClient.dio.post(EndPoints.onOff,data:data ,
        options: Options(headers: {
          "Accept": "application/json",
        }),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      }
      return false;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> login(
      {required String phone}) async {
    try {
      final data = {
        "phone": phone,
      };
      var response = await HttpClient.dio.post(EndPoints.login, data: data, options: Options(headers: {
        "Accept": "application/json",
      }),);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      }
      return false;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<int> register(
      {required String username,
      required String email,
      required String mobile,
         String ? imagePath,
         String ? idPath,
        required String residentType,
        required String bankName,
        String? stc,
        String? iban,
        List<int>? services,
      }) async {
    try {

      FormData formData = FormData.fromMap({
        "name": username,
        "phone": mobile,
      if(imagePath != null)
        "personal_image":  await MultipartFile.fromFile(imagePath, filename:path.basename(imagePath),),
        if(idPath != null)
        "identity_image":  await MultipartFile.fromFile(idPath, filename:path.basename(idPath),),
        "type_resident": residentType,
        "bank_name": bankName,
        "services[]": services,
        if(iban != null&&iban.isNotEmpty)
          "iban_number": iban,
        if(stc != null&&stc.isNotEmpty)
          "stcpay_number": stc,
      });




      var response = await HttpClient.dio.post(EndPoints.register, data: formData,
      options: Options(headers: {
        "Content-Type": "multipart/form-data",
        "Accept": "application/json",
      }),);
      if (response.statusCode == 200 || response.statusCode == 201) {

        return response.data["temp_user_id"];
      } else {
        throw(response.data["message"]);
      }
    } catch (e) {
      throw e.toString();
    }
  }

  void _saveUserLoginResponse(String token) {
    HiveManager.addData(StorageKeys.tokenKey, token);
    // HiveManager.addData(StorageKeys.userId, response.userId);
  }

  void _saveUserDataResponse(response) {
    HiveManager.addData(StorageKeys.userKey, response);
  }

  @override
  Future<void> registerFCMToken({required String token}) {
    // TODO: implement registerFCMToken
    throw UnimplementedError();
  }

  @override
  Future<void> unRegisterFCMToken({required String token}) {
    // TODO: implement unRegisterFCMToken
    throw UnimplementedError();
  }


  @override
  Future<ServicesResponse> fetchServices() async {
    try {
    var servicesResponse = await HttpClient.dio.get("${EndPoints.services}?type=parent",
      options: Options(headers: {
        "Accept": "application/json",
      }),
    );
    if ((servicesResponse.statusCode == 200 || servicesResponse.statusCode == 201)) {
      return ServicesResponse.fromJson(
        {
          "services":servicesResponse.data["services"],
        });
    }
    return const ServicesResponse();
    } catch (e) {
      rethrow;
    }
  }


  @override
  Future<Map<String,dynamic>> getStatics() async {
    try {
      var response = await HttpClient.dio.get(EndPoints.getStatics,
        options: Options(headers: {
          "Accept": "application/json",
        }),
      );
      if ((response.statusCode == 200 || response.statusCode == 201)) {
        return response.data;
      }
      return {};
    } catch (e) {
      rethrow;
    }
  }



  @override
  void deleteAuthStorage() {
    HiveManager.remove(StorageKeys.userKey);
  }

  @override
  void deleteTokenCachedData() {
    HiveManager.remove(StorageKeys.tokenKey);
  }

  @override
  getMobileNumber() {
    // TODO: implement getMobileNumber
    throw UnimplementedError();
  }

  @override
  String? getToken() {
    final tokenData = HiveManager.getData(StorageKeys.tokenKey);
    return tokenData;
  }

  @override
  User? getUserData() {
    var data = HiveManager.getData(StorageKeys.userKey);

    if (data != null) return User.fromJson(data);
    return null;
  }

  @override
  Future<User?> otpVerify({required String phone, required String code , required int temp_user_id,}) async {
    try {
      bool isLogin = temp_user_id == -1 ? true : false;
      final data = isLogin ? {
        "phone": phone,
        "code": code,
        "firebase_token":Constants.fcmToken,
      }:{
        "phone": phone,
        "code": code,
        "temp_user_id": temp_user_id,
        "firebase_token":Constants.fcmToken,
      };
      var response = await HttpClient.dio.post(isLogin?EndPoints.otpLogin:EndPoints.otpRegister, data: data
      , options: Options(headers: {
        "Accept": "application/json",
      }),);
      if (response.statusCode == 200 || response.statusCode == 201) {
        User user = User.fromJson(response.data["user"]);
        if(user.status=="active") {
          _saveUserLoginResponse(response.data["accessToken"]);
          _saveUserDataResponse(response.data["user"]);
        }

        return user;
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }
}

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl();
});
