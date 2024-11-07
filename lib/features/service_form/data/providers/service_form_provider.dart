import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../repositories/service_form_repository.dart';
import '../states/service_form_state.dart';


class ServiceFormNotifierProvider extends StateNotifier<ServiceFormState> {
  ServiceFormNotifierProvider(this.serviceFormRepository) : super(const ServiceFormState()) {}

  final ServiceFormRepository serviceFormRepository;


  submitServiceForm(
      {
        required int service_id,
        required double lat,
        required double lang,
        required String description,
        required String? audioPath,
        required List<XFile?>? pickedImages,
      }
      ) async {
    try {
      state = state.copyWith(loading: true);
      await serviceFormRepository.submitServiceForm(service_id: service_id, lat: lat, lang: lang, description: description, audioPath: audioPath, pickedImages: pickedImages);
      state = state.copyWith( loading: false);
      return true;
    } catch (e) {
      state = state.copyWith(loading: false, errorMessage: e.toString());

    }
  }
}

final serviceFormNotifierProvider =
    StateNotifierProvider<ServiceFormNotifierProvider, ServiceFormState>((ref) {
  final serviceFormRepository = ref.watch(serviceFormRepositoryProvider);

  return ServiceFormNotifierProvider(serviceFormRepository);
});
