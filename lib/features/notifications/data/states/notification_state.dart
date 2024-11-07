import 'package:wasq_tech/features/notifications/data/model/notification_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_state.freezed.dart';

@freezed
class NotificationsState with _$NotificationsState {
  const factory NotificationsState({
    @Default(NotificationsResponse(proposals: [])) NotificationsResponse notificationsResponse,
    @Default(false) bool loading,
    @Default(null) String? errorMessage,
    @Default(false) bool addLoading,
    @Default("") String add,
  }) = _NotificationsState;
}
