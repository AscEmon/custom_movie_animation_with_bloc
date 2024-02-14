import 'dart:ui';

import 'package:custom_movie_animation/global/widget/global_text.dart';
import 'package:custom_movie_animation/utils/enum.dart';
import 'package:custom_movie_animation/utils/extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../global/widget/global_appbar.dart';
import '../bloc/movie_list_bloc.dart';
import '../bloc/movie_list_event.dart';
import '../bloc/movie_list_state.dart';
import 'components/movie_card.dart';

class MovieListScreen extends StatefulWidget {
  const MovieListScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MovieListScreenState createState() => _MovieListScreenState();
}

class _MovieListScreenState extends State<MovieListScreen> {
  PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    context.read<MovieListBloc>().add(LoadMovies());
    _pageController = PageController(
      // so that we can have small portion shown on left and right side
      viewportFraction: 0.8,
      // by default our movie poster
      initialPage: 0,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<MovieListBloc>();
    return Scaffold(
      appBar: GlobalAppBar(title: "Movies"),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned.fill(
            child: BlocBuilder<MovieListBloc, MovieListState>(
              builder: (context, state) {
                if (state.fetchMovieStatus == AppStatus.loading) {
                  return widget.centerCircularProgress();
                } else if (state.fetchMovieStatus == AppStatus.error) {
                  return const SizedBox.shrink();
                } else if (state.fetchMovieStatus == AppStatus.success) {
                  return Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                            state.movies?[state.index].image ?? ""),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                      child: Container(
                        decoration:
                            BoxDecoration(color: Colors.white.withOpacity(0.0)),
                      ),
                    ),
                  );
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 20.w),
                child: AspectRatio(
                  aspectRatio: 0.7,
                  child: BlocBuilder<MovieListBloc, MovieListState>(
                    builder: (context, state) {
                      if (state.fetchMovieStatus == AppStatus.loading) {
                        return widget.centerCircularProgress();
                      } else if (state.fetchMovieStatus == AppStatus.error) {
                        return const SizedBox.shrink();
                      } else if (state.fetchMovieStatus == AppStatus.success) {
                        return PageView.builder(
                          onPageChanged: (index) {
                            bloc.add(BackgroundChanged(index: index));
                          },
                          controller: _pageController,
                          physics: const ClampingScrollPhysics(),
                          itemCount: state.movies!.length,
                          itemBuilder: (context, index) => AnimatedBuilder(
                            animation: _pageController,
                            builder: (context, child) {
                              return Transform.scale(
                                scaleY: state.index == index ? 0.85 : 1,
                                scaleX: state.index == index ? 0.7 : 1,
                                child: MovieCard(
                                  moviesResponse: state.movies![index],
                                ),
                              );
                            },
                          ),
                        );
                      } else {
                        return const GlobalText(str: "No Data Found");
                      }
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
