import 'package:flutter_bloc/flutter_bloc.dart';

import '../events/user_settings/user_settings_events.dart';
import '../state/user_settings_state.dart';
/*
class UserSettingsBloc extends Bloc<UserSettingsEvent, UserSettingsState> {
  UserSettingsBloc() : super(const UserSettingsState(userName: '', darkModeEnabled: false));

  // Old versions of bloc
  @override
  Stream<UserSettingsState> mapEventToState(UserSettingsEvent event) async* {
    if (event is UserNameChanged) {
      yield state.copyWith(userName: event.userName);
    } else if (event is DarkThemeToggled) {
      yield state.copyWith(darkModeEnabled: event.isEnabled);
    }
  }
}
*/

class UserSettingsBloc extends Bloc<UserSettingsEvent, UserSettingsState> {
  UserSettingsBloc({required String initialUserName, required bool initialDarkModeEnabled})
      : super(UserSettingsState(userName: initialUserName, darkModeEnabled: initialDarkModeEnabled)) {

    on<UserNameChanged>((event, emit) {
      emit(state.copyWith(userName: event.userName));
      // We will persist the new Value (Using Shared Preferences)
    });

    on<DarkThemeToggled>((event, emit) {
      emit(state.copyWith(darkModeEnabled: event.isEnabled));
      // We will persist the new Value (Using Shared Preferences)
       });
  }
}
