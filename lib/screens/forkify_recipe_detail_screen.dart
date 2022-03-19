import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:forkify/models/RecipeDetailsResponse.dart';
import 'package:http/http.dart' as http;

class RecipeDetailScreen extends StatefulWidget {
  const RecipeDetailScreen({Key? key, required this.recipeId})
      : super(key: key);

  final String recipeId;

  @override
  State<RecipeDetailScreen> createState() => _RecipeDetailScreenState();
}

class _RecipeDetailScreenState extends State<RecipeDetailScreen> {
  Future<RecipeDetailsResponse>? recipeDetailsResponse;

  @override
  RecipeDetailScreen get widget => super.widget;

  @override
  void initState() {
    recipeDetailsResponse = fetchRecipesDetails(widget.recipeId);
    log('recipeId -> ${widget.recipeId}');
    log('response -> $recipeDetailsResponse');
  }

  @override
  void deactivate() {
    recipeDetailsResponse = null;
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
      ),
      body: SafeArea(
        child: FutureBuilder<RecipeDetailsResponse>(
          future: recipeDetailsResponse,
          builder: (context, snapShot) {
            if (snapShot.hasData) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        '${snapShot.data?.recipe?.title}',
                        maxLines: 2,
                        style: const TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.w800),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        '${snapShot.data?.recipe?.publisher}',
                        maxLines: 2,
                        style: const TextStyle(
                            fontSize: 20,
                            color: Colors.grey,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 300,
                      padding: const EdgeInsets.all(10),
                      child: Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image(
                            width: MediaQuery.of(context).size.width,
                            height: 300,
                            fit: BoxFit.fill,
                            image: NetworkImage(
                              '${snapShot.data?.recipe?.imageUrl}',
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: snapShot.data?.recipe?.ingredients?.length,
                        itemBuilder: (context, index) {
                          return Text(
                            '-> ${snapShot.data?.recipe?.ingredients?[index]} \n',
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                            ),
                            maxLines: 2,
                          );
                        },
                      ),
                    ),
                  ],
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

  Future<RecipeDetailsResponse> fetchRecipesDetails(String recipeId) async {
    final response = await http.get(
      Uri.parse('https://forkify-api.herokuapp.com/api/get?rId=$recipeId'),
    );

    if (response.statusCode == 200) {
      log('response with code -> ${response.body}');
      return RecipeDetailsResponse.fromJson(
        jsonDecode(response.body),
      );
    } else {
      throw Exception('Invalid Details');
    }
  }
}
