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
    try {
      // We need to get access to the Shared Preferences library
      final preferences = await SharedPreferences.getInstance();
      // We can now store the value
      await preferences.setString('userName', userName);
      //throw Exception('This is an error'); // This is just to test the error handling
    } catch (e) {
      // We notify a new state to WHOEVER is listening to this bloc
      emit(UserSettingsErrorState.fromState(state, 'Error while storing the user name in the preferences'));
    }
  }

  void _storeDarkModeEnabled(bool isEnabled)  {
    SharedPreferences.getInstance().then(
            (preferences) => preferences.setBool('darkModeEnabled', isEnabled)
    );
    // We should change this code, and write a code instead that looks like the one we have in _storeUserName
    // to be able to notify the user if an error happened while storing the value in the device

    // I'M just writing this code like this because I want you toi have an example of how to use the .then() syntax
  }
  // Both syntaxes are valid
}
