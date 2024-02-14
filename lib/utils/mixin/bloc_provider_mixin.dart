import 'package:flutter_bloc/flutter_bloc.dart';

import '../../modules/movie_list/bloc/movie_list_bloc.dart';

mixin BlocProviderMixin {
  blocProviders() {
    return [
      BlocProvider(create: (context) => MovieListBloc())
    ];
  }
}
