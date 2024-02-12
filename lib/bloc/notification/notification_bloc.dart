import 'package:expensetracker/bloc/notification/notification_event.dart';
import 'package:expensetracker/bloc/notification/notification_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationBloc extends Bloc<NotificationEvents, NotificationStates> {
  NotificationBloc() : super(InitialState()) {
    on<HasNotification>((event, emit) {
      emit(HasNotificationState(notificationCount: event.notificationCount));
    });

    on<ClearNotification>((event, emit) {
      emit(noNotification());
    });
  }
}
