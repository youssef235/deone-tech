import 'dart:io';

import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../web_services/web_services.dart';
import '../models/service_form_response.dart';
import 'package:path/path.dart' as path;


abstract class ServiceFormRepository {
  Future<String> submitServiceForm(  {
    required int service_id,
    required double lat,
    required double lang,
    required String description,
    required String? audioPath,
    required List<XFile?>? pickedImages,
  });
}

class ServiceFormRepositoryImpl implements ServiceFormRepository {
  @override

  @override
  Future<String> submitServiceForm(
  {
  required int service_id,
    required double lat,
    required double lang,
  required String description,
  required String? audioPath,
    required List<XFile?>? pickedImages,
    }) async {
    try {
    List<MultipartFile> imageFiles = [];
    if(pickedImages!= null){
      for (XFile? imageFile in pickedImages) {
        if (imageFile != null) {
          File file = File(imageFile.path);
          imageFiles.add(await MultipartFile.fromFile(
            file.path,
            filename: path.basename(file.path),
          ));
        }
      }
    }

      FormData formData = FormData.fromMap({
        "service_id": service_id,
        "location_lat": lat,
        "location_lang" : lang,
        "description":description,
        if (audioPath != null)
          "attachments_audios[]": await MultipartFile.fromFile(audioPath, filename: "recorded_audio.aac",),
        "attachments_images[]": imageFiles,
      });
      var response = await HttpClient.dio.post(EndPoints.requestService, data: formData,
        options: Options(headers: {
          "Content-Type": "multipart/form-data",
          "Accept": "application/json",
        }),);
      if (response.statusCode == 200 || response.statusCode == 201) {

        return response.data["status"];
      } else {
        throw(response.data["message"]);
      }
    } catch (e) {
      throw e.toString();
    }
  }
}

final serviceFormRepositoryProvider = Provider<ServiceFormRepository>((ref) {
  return ServiceFormRepositoryImpl();
});
