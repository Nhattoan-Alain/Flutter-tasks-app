import 'package:flutter/material.dart';
import 'package:flutter_bloc_tasks_app/screens/favorite_tasks_screen.dart';
import 'package:flutter_bloc_tasks_app/screens/favorites_screen_drawer.dart';
import 'package:flutter_bloc_tasks_app/screens/recycle_bin.dart';
import 'package:flutter_bloc_tasks_app/screens/tabs_screen.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case RecycleBin.id:
        return MaterialPageRoute(builder: (_) => const RecycleBin());
      case FavoriteTasksScreenDrawer.id:
        return MaterialPageRoute(
            builder: (_) => const FavoriteTasksScreenDrawer());
      case TabsScreen.id:
        return MaterialPageRoute(builder: (_) => const TabsScreen());
      default:
        return null;
    }
  }
}
