import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:the_movies/src/shared/business/movie/movie_cubit.dart';
import 'package:the_movies/src/shared/business/movie/movie_state.dart';

class MoviesPage extends StatelessWidget {
  const MoviesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = Modular.get<MovieCubit>();
    return Scaffold(
      appBar: AppBar(),
      bottomNavigationBar: BottomNavigationBar(currentIndex: 0, items: const [
        BottomNavigationBarItem(icon: Icon(Icons.pedal_bike), label: '1'),
        BottomNavigationBarItem(icon: Icon(Icons.pedal_bike), label: '2'),
        BottomNavigationBarItem(icon: Icon(Icons.pedal_bike), label: '3')
      ]),
      body: BlocConsumer(
        bloc: cubit,
        listener: (context, state) {},
        builder: (context, state) {
          if (state is MovieLoadingState) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }
          if (state is MovieLoadedState) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [Text('Most Popular'), Text('see all')],
                  ),
                ),
                Expanded(
                    flex: 1,
                    child: ListView.builder(
                      itemCount: cubit.popularMovies!.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: GestureDetector(
                            onTap: () {
                              // Modular.to.pushNamed('../details/',
                              //     arguments: bloc.listMoviesPopular![index]);
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.network(
                                cubit.popularMovies![index].posterPath!,
                                loadingBuilder: (context, child, loadingProgress) {
                                  if (loadingProgress == null) {
                                    return child;
                                  } else {
                                    return const SizedBox(
                                      height: 200,
                                      child: Center(
                                        child: CircularProgressIndicator.adaptive(),
                                      ),
                                    );
                                  }
                                },
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        );
                      },
                    )),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [Text('Top Rated'), Text('see all')],
                  ),
                ),
                Expanded(
                    flex: 1,
                    child: ListView.builder(
                      itemCount: cubit.topRatedMovies!.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: GestureDetector(
                            onTap: () {
                              // Modular.to.pushNamed('../details/',
                              //     arguments: bloc.listMoviesPopular![index]);
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.network(
                                cubit.topRatedMovies![index].posterPath!,
                                loadingBuilder: (context, child, loadingProgress) {
                                  if (loadingProgress == null) {
                                    return child;
                                  } else {
                                    return const SizedBox(
                                      height: 200,
                                      child: Center(
                                        child: CircularProgressIndicator.adaptive(),
                                      ),
                                    );
                                  }
                                },
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        );
                      },
                    )),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [Text('Up Comming'), Text('see all')],
                  ),
                ),
                Expanded(
                    flex: 1,
                    child: ListView.builder(
                      itemCount: cubit.upCommingMovies!.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: GestureDetector(
                            onTap: () {
                              // Modular.to.pushNamed('../details/',
                              //     arguments: bloc.listMoviesPopular![index]);
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.network(
                                cubit.upCommingMovies![index].posterPath!,
                                loadingBuilder: (context, child, loadingProgress) {
                                  if (loadingProgress == null) {
                                    return child;
                                  } else {
                                    return const SizedBox(
                                      height: 200,
                                      child: Center(
                                        child: CircularProgressIndicator.adaptive(),
                                      ),
                                    );
                                  }
                                },
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        );
                      },
                    )),
              ],
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
