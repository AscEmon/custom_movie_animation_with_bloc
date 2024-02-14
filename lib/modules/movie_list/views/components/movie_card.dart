import 'package:custom_movie_animation/global/widget/global_image_loader.dart';
import 'package:custom_movie_animation/modules/movie_list/model/movies_response.dart';
import 'package:custom_movie_animation/utils/enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../utils/mixin/movie_image_mixin.dart';

class MovieCard extends StatelessWidget with MovieImage {
  const MovieCard({
    super.key,
    required this.moviesResponse,
  });

  final MoviesResponse moviesResponse;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16.r),
          child: GlobalImageLoader(
            imageFor: ImageFor.network,
            imagePath: moviesResponse.image ?? "",
            fit: BoxFit.fill,
            height: 380.h,
            width: 300.w,
          ),
        ),
        Positioned.fill(
          child: Align(
            alignment: Alignment.center,
            child: Icon(
              Icons.play_circle_outline,
              size: 40.w,
              color: Colors.white,
            ),
          ),
        )
      ],
    );
  }
}
