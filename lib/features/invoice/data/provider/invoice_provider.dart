import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wasq_tech/features/invoice/data/model/invoice.dart';
import 'package:wasq_tech/features/invoice/data/repository/invoice_repository.dart';
import 'package:wasq_tech/features/invoice/data/states/invoice_state.dart';

enum LoginStatus { active, waiting, error }

final invoiceNotifierProvider =
    StateNotifierProvider<InvoiceStateNotifier, InvoiceState>((ref) {
  final repo = ref.watch(invoiceRepositoryProvider);
  return InvoiceStateNotifier(repo, null);
});

class InvoiceStateNotifier extends StateNotifier<InvoiceState> {
  final InvoiceRepository _repo;

  InvoiceStateNotifier(this._repo, [Invoice? state])
      : super(const InvoiceState());

  Future getInvoice({required int projectId}) async {
    state = state.copyWith(loading: true);
    try {
      Invoice res = await _repo.getInvoice(project_id: projectId);
      state = state.copyWith(invoiceResponse: res, loading: false);
      return res;
    } catch (e) {
      state = state.copyWith(loading: false,invoiceResponse: null, errorMessage: e.toString());
    }
  }

  clearInvoice() async {
    state = state.copyWith(invoiceResponse: null);
    print("clear invoice");
    print(state.invoiceResponse);
  }

  Future getInvoicePdf(int invoice) async {
    state = state.copyWith(loading: true);
    try {
      var res = await _repo.getInvoicePdf(invoice);
      state = state.copyWith(loading: false);
      return res;
    } catch (e) {
      state = state.copyWith(loading: false, errorMessage: e.toString());
    }
  }

  Future createInvoice({
    required int project_id,
    int? equipment_cost,
    String? note,
    List<XFile?>? attachments,
  }) async {
    state = state.copyWith(loading: true);
    try {
      Invoice? res = await _repo.createInvoice(
          project_id: project_id,
          equipment_cost: equipment_cost,
          note: note,
          attachments: attachments);
      state = state.copyWith(invoiceResponse: res, loading: false);
      return res;
    } catch (e) {
      state = state.copyWith(loading: false, errorMessage: e.toString());
    }
  }

  Future updateInvoice({
    required int invoice_id,
    int? equipment_cost,
    String? note,
    List<XFile?>? attachments,
    required String methods,
  }) async {
    state = state.copyWith(loading: true);
    try {
      Invoice res = await _repo.updateInvoice(
        invoice_id: invoice_id,
        equipment_cost: equipment_cost,
        note: note,
        attachments: attachments,
        methods: methods,
      );
      state = state.copyWith(invoiceResponse: res, loading: false);
      return res;
    } catch (e) {
      state = state.copyWith(loading: false, errorMessage: e.toString());
    }
  }
}
