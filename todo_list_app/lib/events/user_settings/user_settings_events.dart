abstract class UserSettingsEvent {}

class UserNameChanged extends UserSettingsEvent {
  final String userName;
  UserNameChanged(this.userName);
}

class DarkThemeToggled extends UserSettingsEvent {
  final bool isEnabled;
  DarkThemeToggled(this.isEnabled);
}
