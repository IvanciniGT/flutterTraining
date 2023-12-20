import 'package:equatable/equatable.dart';

class UserSettingsState extends Equatable{
  final String userName;
  final bool darkModeEnabled;

  const UserSettingsState({required this.userName, required this.darkModeEnabled});

  // CopyWith method for modifying state
  UserSettingsState copyWith({String? userName, bool? darkModeEnabled}) {
    return UserSettingsState(
      userName: userName ?? this.userName,
      darkModeEnabled: darkModeEnabled ?? this.darkModeEnabled,
    );
  }

  @override
  List<Object?> get props => [userName, darkModeEnabled];
}

class UserSettingsErrorState extends UserSettingsState {
  final String errorMessage;

  const UserSettingsErrorState({required super.userName, required super.darkModeEnabled, required this.errorMessage});

  static UserSettingsErrorState fromState(UserSettingsState state, String errorMessage) {
    return UserSettingsErrorState(userName: state.userName, darkModeEnabled: state.darkModeEnabled, errorMessage: errorMessage);
  }

  @override
  List<Object?> get props => [userName, darkModeEnabled, errorMessage];
}