import 'package:wasq_tech/features/notifications/data/model/notification_response.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geocoding/geocoding.dart';

import '../repositories/notification_repository.dart';
import '../states/notification_state.dart';


class NotificationsNotifierProvider extends StateNotifier<NotificationsState> {
  NotificationsNotifierProvider(this.notificationsRepository) : super(const NotificationsState());

  final NotificationsRepository notificationsRepository;

  getAddressFromCoordinates(double latitude, double longitude) async {
    try {
      state = state.copyWith(addLoading: true);

      List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);

      if (placemarks.isNotEmpty) {
        Placemark firstPlacemark = placemarks.first;

        String address = "${firstPlacemark.subThoroughfare} ${firstPlacemark.thoroughfare}, "
            "${firstPlacemark.subLocality}, ${firstPlacemark.locality}, \n"
            "${firstPlacemark.administrativeArea}, ${firstPlacemark.postalCode}, ";

        state = state.copyWith( add : address, addLoading: false);
      } else {
      }
    } catch (e) {
      state = state.copyWith(addLoading: false);
      print("Error fetching address: $e");
    }
  }

  getNotificationsData() async {
    try {
      if(state.notificationsResponse.proposals!.isEmpty) {
        state = state.copyWith(loading: true);
      }
      final NotificationsResponse notificationsResponse = await notificationsRepository.fetchNotificationsData();
      state = state.copyWith(notificationsResponse: notificationsResponse, loading: false);

    } catch (e) {
      state = state.copyWith(loading: false, errorMessage: e.toString());
    }
  }


getProposal(int proposalID) async {
    try {
      state = state.copyWith(loading: true);
      final res = await notificationsRepository.getProposal(proposalID);
      state = state.copyWith(loading: false);
      return res;
    } catch (e) {
      state = state.copyWith(loading: false, errorMessage: e.toString());
    }
  }


  completeProject(int id) async {
    try {
      state = state.copyWith(loading: true);
      final String status = await notificationsRepository.completeProject(id);
      state = state.copyWith(loading: false);
      return status;
    } catch (e) {
      state = state.copyWith(loading: false, errorMessage: e.toString());
      return null;
    }
  }

  acceptProposal(int id) async {
    try {
      state = state.copyWith(loading: true);
      final String status = await notificationsRepository.acceptProposal(id);
      state = state.copyWith(loading: false);
                return status;
    } catch (e) {
      state = state.copyWith(loading: false, errorMessage: e.toString());
    }
  }

  refuseProposal(int id) async {
    try {
      state = state.copyWith(loading: true);
      final String status = await notificationsRepository.refuseProposal(id);
      state = state.copyWith(loading: false);
                return status;
    } catch (e) {
      state = state.copyWith(loading: false, errorMessage: e.toString());
      return null;
    }
  }

  removeProposalById(int proposalId) {
    // Create a new list without the proposal with the specified ID
    final updatedNotifications = state.notificationsResponse.proposals!
        .where((proposal) => proposal.id != proposalId)
        .toList();

    // Update the 'notificationsResponse' in a new copy of the state
    return state.copyWith(notificationsResponse: NotificationsResponse(proposals: updatedNotifications));
  }



}

final notificationsNotifierProvider =
    StateNotifierProvider<NotificationsNotifierProvider, NotificationsState>((ref) {
  final notificationsRepository = ref.watch(notificationsRepositoryProvider);

  return NotificationsNotifierProvider(notificationsRepository);
});
