import 'package:wasq_tech/features/invoice/data/model/invoice.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'invoice_state.freezed.dart';

@freezed
class InvoiceState with _$InvoiceState {
  const factory InvoiceState({
    @Default(null) Invoice? invoiceResponse,
    @Default(false) bool loading,
    @Default(false) bool addLoading,
    @Default("") String add,
    @Default("") String errorMessage,
  }) = _InvoiceState;
}
