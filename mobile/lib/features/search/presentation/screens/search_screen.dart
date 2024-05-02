import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/features/search/presentation/aritcal_widget.dart';
import 'package:mobile/features/search/presentation/cubit/search_cubit.dart';
import 'package:mobile/features/search/presentation/screens/details_screen.dart';
import 'package:mobile/injection_container.dart' as di;
class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Articles", 
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back_ios)),
      ),
      body: BlocProvider(
        create: (context) => di.sl<SearchCubit>()..getSearchResult('Skin Cancer'),
        child: BlocBuilder<SearchCubit, SearchState>(
            builder: (context, state) {
          if (state is SearchStateIsloading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is SearchStateLoaded) {
            return Padding(
              padding: const EdgeInsets.all(8),
              child: ListView.separated(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DetialsScreen(
                                      image: state.getNewsData
                                          .articles![index].urlToImage
                                          .toString(),
                                      title: state.getNewsData
                                          .articles![index].title
                                          .toString(),
                                      content: state.getNewsData
                                          .articles![index].content
                                          .toString(),
                                      publishAt: state.getNewsData
                                          .articles![index].publishedAt
                                          .toString(),
                                    )));
                      },
                      child: Articlewidget(
                          imageUrl: state
                              .getNewsData.articles![index].urlToImage
                              .toString(),
                          title: state.getNewsData.articles![index].title
                              .toString(),
                          publishedAt: state
                              .getNewsData.articles![index].publishedAt
                              .toString()),
                    );
                  },
                  separatorBuilder: (context, index) => const Divider(),
                  itemCount: state.getNewsData.articles!.length),
            );
          }
          return const Padding(
            padding: EdgeInsets.all(8.0),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }),
      ),
    );
  }
}
