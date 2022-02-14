import 'package:equatable/equatable.dart';

class SettingsDto extends Equatable {
  final bool online;

  final bool authenticated;

  final bool dailyReminder;

  const SettingsDto({
    required this.online,
    required this.authenticated,
    required this.dailyReminder,
  });

  @override
  List<Object?> get props => [online, authenticated, dailyReminder];

  Map<String, dynamic> toMap() {
    return {
      "online": online,
      "authenticated": authenticated,
      "dailyReminder": dailyReminder,
    };
  }

  SettingsDto copyWith({bool? online, bool? authenticated, bool? dailyReminder}) {
    return SettingsDto(
      online: online ?? this.online,
      authenticated: authenticated ?? this.authenticated,
      dailyReminder: dailyReminder ?? this.dailyReminder,
    );
  }

  static SettingsDto from(Map<String, dynamic> map) {
    if (map.keys.isNotEmpty) {
      return SettingsDto(
        online: map.containsKey("online") ? map["online"] as bool : false,
        dailyReminder: map.containsKey("dailyReminder") ? map["dailyReminder"] as bool : false,
        authenticated: map.containsKey("authenticated") ? map["authenticated"] as bool : false,
      );
    }

    // If no local settings, presume we are offline
    return defaultValue();
  }

  static SettingsDto defaultValue() {
    return const SettingsDto(online: false, authenticated: false, dailyReminder: false);
  }
}
