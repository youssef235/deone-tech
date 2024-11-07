import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../web_services/web_services.dart';
import '../../../notifications/data/model/notification_response.dart';
import '../models/home_response.dart';

abstract class HomeRepository {

  Future<List<String>> getSliders();
//  Future<List<Service>> getProjects();



  Future<String> createProposal({
    required int id,
    required double price,
    required String description,
    String? audioPath,
  });


  Future<ProviderProposalsResponse> fetchHomeData({
    required int page,
    required int perPage,
    required double lang,
    required double lat,
  });

  Future<Proposals> getProposal(int id);
}

class HomeRepositoryImpl implements HomeRepository {


  @override
  Future<List<String>> getSliders() async {
    try {
      var slidesResponse = await HttpClient.dio.get(
        EndPoints.slides,
        options: Options(headers: {
          "Accept": "application/json",
        }),
      );
      List<String> slides = [];


      print("asdasdasdaafffaasssssssd ${slides}");

      if (slidesResponse.statusCode == 200) {
        if (slidesResponse.data.containsKey('slides')) {
          slides = List<String>.from(slidesResponse.data['slides']);

          print("asdasdasdaafffaasssssssd ${slides}");
        }
      }

      return slides;
    } catch (e) {
      rethrow;
    }
  }

  // @override
  // Future<List<Service>> getProjects() async {
  //   try {
  //     var response = await HttpClient.dio.get(
  //       EndPoints.allServices,
  //       queryParameters: {'type': 'parent'},
  //       options: Options(headers: {"Accept": "application/json"}),
  //     );
  //
  //     if (response.statusCode == 200) {
  //       List<Service> mainServices = [];
  //
  //       // Check if the 'services' key exists in the response data
  //       if (response.data.containsKey('services')) {
  //         mainServices = (response.data['services'] as List)
  //             .map((item) => Service.fromJson(item))
  //             .toList();
  //       }
  //
  //       numberOfService =  mainServices.length ;
  //
  //       print("Main Services: $mainServices");
  //       return mainServices;
  //     } else {
  //       throw Exception('Failed to load main services');
  //     }
  //   } catch (e) {
  //     print("Error fetching main services: $e");
  //     rethrow;
  //   }
  // }
  @override
  Future<ProviderProposalsResponse> fetchHomeData({
    required int page,
    required int perPage,
    required double lang,
    required double lat,
  }) async {
    try {
      var response = await HttpClient.dio.get(
        EndPoints.providerProposals(
          lang: lang,
          lat: lat,
          page: page,
          perPage: perPage,
        ),
        options: Options(headers: {
          "Accept": "application/json",
        }),
      );
      var slidesResponse = await HttpClient.dio.get(
        EndPoints.slides,
        options: Options(headers: {
          "Accept": "application/json",
        }),
      );
      if ((slidesResponse.statusCode == 200 ||
              slidesResponse.statusCode == 201) &&
          (response.statusCode == 200 || response.statusCode == 201)) {

        return ProviderProposalsResponse.fromJson({
          "projects": response.data["projects"]["data"],
          "have_project": response.data['have_project'],
          "total": response.data["projects"]["total"],
          "current_page": response.data["projects"]["current_page"],
       //   "slides": slidesResponse.data["slides"],
        });
      }
      return const ProviderProposalsResponse();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String> createProposal({
    required int id,
    required double price,
    required String description,
    String? audioPath,
  }) async {
    try {
      FormData formData = FormData.fromMap({
        "description": description,
        "price": price,
        if (audioPath != null)
          "attachments[]": await MultipartFile.fromFile(
            audioPath,
            filename: "recorded_audio.aac",
          ),
      });

      var response = await HttpClient.dio.post(
        EndPoints.createProposals(id: id),
        data: formData,
        options: Options(headers: {
          "Accept": "application/json",
        }),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        print(response.data["proposal"]["id"]);
        sendOffer({
          "id": response.data["proposal"]["id"],
          "description": description,
          "price": ((price + 31) * 1.15) * 1.01,
          "original_price": price,
          "avatar": response.data["proposal"]["provider"]["avatar"],
          "avg_rate": response.data["proposal"]["provider"]["avg_rate"] ?? 0,
          "name": response.data["proposal"]["provider"]["name"],
        }, id);
        return response.data["status"];
      }
      return "حدث خطأ ما";
    } catch (e) {
      rethrow;
    }
  }

  Future<void> sendOffer(Map<String, dynamic> message, int id) async {
    await FirebaseFirestore.instance
        .collection('Offers')
        .doc(id.toString())
        .collection('offers')
        .doc(message["id"].toString())
        .set(message);
  }

  @override
  Future<Proposals> getProposal(int id) async {
    try {
      var response = await HttpClient.dio.get(
        EndPoints.getProposal(id: id),
        options: Options(headers: {
          "Accept": "application/json",
        }),
      );

      if ((response.statusCode == 200 || response.statusCode == 201)) {
        Proposals proposals = Proposals.fromJson(response.data["proposal"]);
        print("proposals ${proposals}");
        return Proposals.fromJson(response.data["proposal"]);
      }
      return const Proposals();
    } catch (e) {


      print("errrrrrrrro ${e.runtimeType}");
      rethrow;
    }
  }
}

final homeRepositoryProvider = Provider<HomeRepository>((ref) {
  return HomeRepositoryImpl();
});
