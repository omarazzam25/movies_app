import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movies_app/core/config/routes/app_routes_name.dart';
import 'package:movies_app/core/widgets/custom_text_form_field.dart';
import 'package:movies_app/feature/layout/search/search_cubit/search_cubit.dart';
import 'package:movies_app/main.dart';

import '../../../../core/config/them/screen_size.dart';
import '../../../../core/config/them/text_them.dart';
import '../../home/widget/movie_card.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: context.width * 0.04),
            child: CustomTextFormField(
              hint: 'Search',
              prefixIcon: Padding(
                padding: const EdgeInsets.all(10.0),
                child: SvgPicture.asset('assets/icons/search.svg'),
              ),
              onChanged: (value) {
                context.read<SearchCubit>().searchMovie(value);
              },
            ),
          ),
      
          const SizedBox(height: 20),
      
          Expanded(
            child: BlocBuilder<SearchCubit, SearchState>(
              builder: (context, state) {
                if (state is SearchLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state is SearchInitial) {
                  return Center(
                    child: Image.asset(
                      'assets/images/empty.png',
                      width: 124,
                      height: 124,
                    ),
                  );
                }
      
                if (state is SearchEmpty) {}
      
                if (state is SearchSuccess) {
                  return GridView.builder(
                    padding: EdgeInsets.symmetric(
                      horizontal: context.width * 0.04,
                    ),
                    itemCount: state.movies.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 16,
                      childAspectRatio: 0.65,
                    ),
                    itemBuilder: (context, index) {
                      final movie = state.movies[index];
      
                      return GestureDetector(
                        onTap: (){
                          navigatorKey.currentState?.pushNamed(AppRoutesName.movieDetails,arguments: movie.id);
                        },
                        child: MovieCard(
                          imageUrl: movie.largeCoverImage ?? '',
                          rating: movie.rating,
                          width: context.width * 0.42,
                          height: context.height * 0.25,
                          ratingTextStyle: TextThem.robotoRegular10White,
                          starSize: 14,
                        ),
                      );
                    },
                  );
                }
                if (state is SearchError) {
                  return Center(child: Text(state.message));

                }
                return const SizedBox();
              },
            ),
          ),
        ],
      ),
    );
  }
}

//Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 16.0),
//         child: SafeArea(
//           child: Column(
//             children: [
//               CustomTextFormField( hint: 'Search',prefixIcon: Padding(
//                 padding: const EdgeInsets.all(12.0),
//                 child: SvgPicture.asset('assets/icons/search.svg'),
//               )),
//               SizedBox(height: 250,),
//               Image.asset('assets/images/empty.png',width: 124,height: 124,),
//
//             ],
//
//           ),
//         ),
//       ),
//     );
