import 'package:custom_movie_animation/modules/movie_list/views/movie_list_screen.dart';
import 'package:flutter/material.dart';


enum AppRoutes {
  dashboard,
}

extension AppRoutesExtention on AppRoutes {
  Widget buildWidget<T extends Object>({T? arguments}) {
    switch (this) {
      case AppRoutes.dashboard:
        return const MovieListScreen();
    }
  }
}


