import 'package:equatable/equatable.dart';

class SettingsDto extends Equatable {
  final bool online;

  const SettingsDto({required this.online});

  @override
  List<Object?> get props => [online];

  Map<String, dynamic> toMap() {
    return {
      "online": online,
    };
  }

  static from(Map<String, dynamic> map) {
    if (map.containsKey("online")) {
      return SettingsDto(online: map["online"] as bool);
    }

    // If no local settings, presume we are offline
    return const SettingsDto(online: false);
  }
}
