import 'package:wasq_tech/features/notifications/data/model/notification_response.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../web_services/web_services.dart';

abstract class NotificationsRepository {
  Future<NotificationsResponse> fetchNotificationsData();
  Future<String> refuseProposal(int id);
  Future<String> acceptProposal(int id);
  Future getProposal(int proposalID);
  Future<String> completeProject(int id);


}

class NotificationsRepositoryImpl implements NotificationsRepository {
  @override
  Future<NotificationsResponse> fetchNotificationsData() async {
    try {

      var response = await HttpClient.dio.get(EndPoints.proposals,
        options: Options(headers: {
          "Accept": "application/json",
        }),
      );
      print("resoo $response");
      print("######################################");
      print(response.data["proposals"][0]["customer"]);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return NotificationsResponse.fromJson(
          {
            "proposals": response.data["proposals"],
          }
        );
      }
      return const NotificationsResponse();
    } catch (e) {
      rethrow;
    }
  }

   @override
  Future getProposal(int proposalID) async {
    try {
      var response = await HttpClient.dio.get(EndPoints.getProposal(id: proposalID),
        options: Options(headers: {
          "Accept": "application/json",
        }),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return Proposals.fromJson(response.data["proposal"]);
      }
      
    } catch (e) {
      rethrow;
    }
  }


  @override
  Future<String> refuseProposal(int id) async {
    try {
      var response = await HttpClient.dio.post(EndPoints.refuseProposals(id: id),
        options: Options(headers: {
          "Accept": "application/json",
        }),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data["status"];
      }
      return "حدث خطأ ما";
    } catch (e) {
      rethrow;
    }
  }
  @override
  Future<String> acceptProposal(int id) async {
    try {
      var response = await HttpClient.dio.post(EndPoints.acceptProposals(id: id),
        options: Options(headers: {
          "Accept": "application/json",
        }),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data["status"];
      }
      return "حدث خطأ ما";
    } catch (e) {
      rethrow;
    }
  }
  @override
  Future<String> completeProject(int id) async {
    try {

      var data={
        "status":"completed"
      };
      var response = await HttpClient.dio.put(EndPoints.completeProject(id: id),data: data,
        options: Options(headers: {
          "Accept": "application/json",
        }),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data["message"];
      }
      return "حدث خطأ ما";
    } catch (e) {
      rethrow;
    }
  }

}

final notificationsRepositoryProvider = Provider<NotificationsRepository>((ref) {
  return NotificationsRepositoryImpl();
});
