import 'package:equatable/equatable.dart';

class SettingsDto extends Equatable {
  final bool online;

  // TODO not sure if this should be here, probaly not, but until we implement authentication this is an handy place
  final bool authenticated;

  const SettingsDto({required this.online, required this.authenticated});

  @override
  List<Object?> get props => [online, authenticated];

  Map<String, dynamic> toMap() {
    return {
      "online": online,
      "authenticated": authenticated,
    };
  }

  static from(Map<String, dynamic> map) {
    if (map.keys.isNotEmpty) {
      return SettingsDto(
        online: map.containsKey("online") ? map["online"] as bool : false,
        authenticated: map.containsKey("authenticated") ? map["authenticated"] as bool : false,
      );
    }

    // If no local settings, presume we are offline
    return const SettingsDto(online: false, authenticated: false);
  }
}
