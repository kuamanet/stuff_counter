import 'package:kcounter/counters/entities/counter_read_dto.dart';

enum AppRouteName {
  dashboard,
  create,
  graph,
  settings,
  update,
}

class AppRoute {
  final CounterWithDailyReadDto? currentCounter;
  final AppRouteName name;

  const AppRoute({
    this.currentCounter,
    required this.name,
  });
}
