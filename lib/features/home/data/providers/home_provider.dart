import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../notifications/data/model/notification_response.dart';
import '../models/home_response.dart';
import '../repositories/home_repository.dart';
import '../states/home_state.dart';
import 'package:geocoding/geocoding.dart';

class HomeNotifierProvider extends StateNotifier<HomeState> {
  HomeNotifierProvider(this.homeRepository) : super(const HomeState()) {
    getSliders();
    // init();
  }

  final HomeRepository homeRepository;


  getHomeData({
    required int page,
    required int perPage,
    required double lang,
    required double lat,
  }) async {
    try {
      // state = state.copyWith(loading: true);
      final ProviderProposalsResponse providerProposalsResponse =
      await homeRepository.fetchHomeData(
        perPage: perPage,
        page: page,
        lang: lang,
        lat: lat,
      );

      if (providerProposalsResponse.projects!=state.providerProposalsResponse.projects||state.providerProposalsResponse.slides==null||state.providerProposalsResponse.slides!.isEmpty) {
        state = state.copyWith(

            providerProposalsResponse: providerProposalsResponse,
            loading: false);
      }
    } catch (e) {
      state = state.copyWith(loading: false, errorMessage: e.toString());
    }
  }


  getSliders() async {
    try {
      state = state.copyWith(slidersLoading: true);
      final List<String> sliders = await homeRepository.getSliders();
      state = state.copyWith(sliders: sliders, slidersLoading: false);

    } catch (e) {
      state = state.copyWith(slidersLoading: false, errorMessage: e.toString());
    }
  }

  //
  // Future<void> getMainServices() async {
  //   state = state.copyWith(mainServiceLoading: true);
  //   try {
  //     final mainServices = await homeRepository.fetchMainServices();
  //
  //
  //     state = state.copyWith(mainServices: mainServices, mainServiceLoading: false);
  //   } catch (e) {
  //     state = state.copyWith(mainServiceLoading: false, errorMessage: e.toString());
  //   }
  // }


  getAddressFromCoordinates(double latitude, double longitude) async {
    try {
      state = state.copyWith(requestLoading: true);

      List<Placemark> placemarks =
      await placemarkFromCoordinates(latitude, longitude);

      if (placemarks.isNotEmpty) {
        Placemark firstPlacemark = placemarks.first;

        String address =
            "${firstPlacemark.subThoroughfare} ${firstPlacemark.thoroughfare}, "
            "${firstPlacemark.subLocality}, ${firstPlacemark.locality}, \n"
            "${firstPlacemark.administrativeArea}, ${firstPlacemark.postalCode}, ";

        state = state.copyWith(add: address, requestLoading: false);
      } else {}
    } catch (e) {
      state = state.copyWith(requestLoading: false);
      print("Error fetching address: $e");
    }
  }

  changePageIndex(index) {
    state = state.copyWith(screenIndex: index);
  }

  setStateLoading(bool loading) {
    if(state.providerProposalsResponse.projects!.isEmpty) {
      state = state.copyWith(loading: loading);
    }
  }

  Future<Proposals> getProposal({
    required int id,
  }) async {
    try {
      state = state.copyWith(requestLoading: true);
      final Proposals response = await homeRepository.getProposal(id);
      state = state.copyWith(requestLoading: false);
      return response;
    } catch (e) {
      state = state.copyWith(
          requestLoading: false, requestErrorMessage: e.toString());
      return const Proposals();
    }
  }

  createProposal({
    required int id,
    required double price,
    required String dis,
    String? audioPath,
  }) async {
    try {
      state = state.copyWith(requestLoading: true);
      final String status = await homeRepository.createProposal(
        id: id,
        price: price,
        description: dis,
        audioPath: audioPath,
      );
      state = state.copyWith(requestLoading: false);
      return status;
    } catch (e) {
      state = state.copyWith(
          requestLoading: false, requestErrorMessage: e.toString());
      return null;
    }
  }
}

final homeNotifierProvider =
StateNotifierProvider<HomeNotifierProvider, HomeState>((ref) {
  final homeRepository = ref.watch(homeRepositoryProvider);

  return HomeNotifierProvider(homeRepository);
});