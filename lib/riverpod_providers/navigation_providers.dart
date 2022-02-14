import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kcounter/counters/entities/counter_read_dto.dart';
import 'package:kcounter/navigation/app_route.dart';

final routeProvider =
    StateNotifierProvider.autoDispose<AppRouteNotifier, AppRoute>((_) => AppRouteNotifier());

class AppRouteNotifier extends StateNotifier<AppRoute> {
  AppRouteNotifier() : super(const AppRoute(name: AppRouteName.dashboard));

  void toCreatePage() => state = const AppRoute(name: AppRouteName.create);

  void toDashboardPage() => state = const AppRoute(name: AppRouteName.dashboard);

  void toSettingsPage() => state = const AppRoute(name: AppRouteName.settings);

  void toGraphPage(CounterReadDto counter) {
    state = AppRoute(
      name: AppRouteName.graph,
      currentCounter: counter,
    );
  }

  void toUpdatePage(CounterReadDto counter) {
    state = AppRoute(
      name: AppRouteName.update,
      currentCounter: counter,
    );
  }
}
