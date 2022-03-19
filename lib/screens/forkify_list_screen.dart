import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:forkify/models/RecipesSearchResponse.dart';
import 'package:forkify/screens/forkify_recipe_detail_screen.dart';

import '../utils/constants.dart';
import '../widgets/custom_dialog.dart';
import 'package:http/http.dart' as http;

class ForkifyListScreen extends StatefulWidget {
  const ForkifyListScreen({Key? key}) : super(key: key);

  @override
  _ForkifyListScreenState createState() => _ForkifyListScreenState();
}

class _ForkifyListScreenState extends State<ForkifyListScreen> {
  String query = 'pizza';
  late Future<RecipesSearchResponse> recipesSearchResponse;

  @override
  void initState() {
    recipesSearchResponse = fetchRecipesList(query);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ForkifyApp Flutter',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          InkWell(
            child: const Padding(
              padding: EdgeInsets.all(20.0),
              child: Icon(
                Icons.filter_list,
                color: Colors.white,
              ),
            ),
            onTap: () {
              setState(
                () {
                  showDialogFunc(
                    context,
                    onChange: (returnedQuery) {
                      query = returnedQuery;
                    },
                  );
                  recipesSearchResponse = fetchRecipesList(query);
                },
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: FutureBuilder<RecipesSearchResponse>(
          future: recipesSearchResponse,
          builder: (context, snapShot) {
            if (snapShot.hasData) {
              return ListView.builder(
                itemCount: snapShot.data?.recipes?.length,
                itemBuilder: (context, index) => InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => RecipeDetailScreen(
                            recipeId:
                                '${snapShot.data?.recipes?[index].recipeId}'),
                      ),
                    );
                  },
                  child: Card(
                    color: Colors.grey[500],
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ClipRRect(
                          child: Image(
                            image: NetworkImage(
                              '${snapShot.data?.recipes?[index].imageUrl}',
                            ),
                            fit: BoxFit.fill,
                            width: 120,
                            height: 120,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        Container(
                          padding: const EdgeInsets.all(10),
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${snapShot.data?.recipes?[index].title}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                maxLines: 2,
                                textWidthBasis: TextWidthBasis.parent,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                '${snapShot.data?.recipes?[index].publisher}',
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                maxLines: 2,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }

  showDialogFunc(context, {Function? onChange}) {
    return showDialog<void>(
      context: context,
      builder: (context) {
        return Material(
          type: MaterialType.transparency,
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[100]),
              width: MediaQuery.of(context).size.width * 0.7,
              height: MediaQuery.of(context).size.height * 0.8,
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: Constants.queries.length,
                itemBuilder: (context, index) => Column(
                  children: [
                    InkWell(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 40,
                        alignment: Alignment.center,
                        child: Text(
                          Constants.queries[index],
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      onTap: () {
                        onChange!(Constants.queries[index]);
                        Navigator.pop(context);
                      },
                    ),
                    SizedBox(
                      height: 2,
                      child: Container(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Future<RecipesSearchResponse> fetchRecipesList(String putQuery) async {
    final response = await http.get(
      Uri.parse('https://forkify-api.herokuapp.com/api/search?q=$putQuery'),
    );

    if (response.statusCode == 200) {
      log('response -> ${response.body}');
      return RecipesSearchResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load data');
    }
  }
}
