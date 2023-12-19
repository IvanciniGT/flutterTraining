import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
      _storeUserName(event.userName); // this is an async method
                                      // so we will call this method and forget about it
                                      // We will not wait for the response of this method
                                      // Therefor we will not know if an error happened or not while storing the value in the device
                                      // We need a way to check for that.
                                      // TODO: Check for errors while storing the value in the device, and alert the user if an error happened
    });

    on<DarkThemeToggled>((event, emit) {
      emit(state.copyWith(darkModeEnabled: event.isEnabled));
      // We will persist the new Value (Using Shared Preferences)
      _storeDarkModeEnabled(event.isEnabled);
      // NOTE: Here we don't want to wait for the response of this method
      // This can take a little bit of time, and we don't want to block the UI while this is happening
    });
  }

  void _storeUserName(String userName) async {
    // We need to get access to the Shared Preferences library
    final preferences = await SharedPreferences.getInstance();
    // We can now store the value
    await preferences.setString('userName', userName);
  }

  void _storeDarkModeEnabled(bool isEnabled)  {
    SharedPreferences.getInstance().then(
            (preferences) => preferences.setBool('darkModeEnabled', isEnabled)
    );
  }
  // Both syntaxes are valid
}
