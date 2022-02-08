import 'package:kcounter/counters/entities/counter_read_dto.dart';

enum AppRouteName {
  dashboard,
  create,
  graph,
  settings,
}

class AppRoute {
  final CounterReadDto? currentCounter;
  final AppRouteName name;

  const AppRoute({
    this.currentCounter,
    required this.name,
  });
}
