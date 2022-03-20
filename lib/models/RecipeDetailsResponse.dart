/// recipe : {"publisher":"101 Cookbooks","ingredients":["4 1/2 cups (20.25 ounces) unbleached high-gluten, bread, or all-purpose flour, chilled","1 3/4 (.44 ounce) teaspoons salt","1 teaspoon (.11 ounce) instant yeast","1/4 cup (2 ounces) olive oil (optional)","1 3/4 cups (14 ounces) water, ice cold (40F)","Semolina flour OR cornmeal for dusting"],"source_url":"http://www.101cookbooks.com/archives/001199.html","recipe_id":"47746","image_url":"http://forkify-api.herokuapp.com/images/best_pizza_dough_recipe1b20.jpg","social_rank":100,"publisher_url":"http://www.101cookbooks.com","title":"Best Pizza Dough Ever"}

class RecipeDetailsResponse {
  RecipeDetailsResponse({
      Recipe? recipe,}){
    _recipe = recipe;
}

  RecipeDetailsResponse.fromJson(dynamic json) {
    _recipe = json['recipe'] != null ? Recipe.fromJson(json['recipe']) : null;
  }
  Recipe? _recipe;

  Recipe? get recipe => _recipe;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_recipe != null) {
      map['recipe'] = _recipe?.toJson();
    }
    return map;
  }

}

/// publisher : "101 Cookbooks"
/// ingredients : ["4 1/2 cups (20.25 ounces) unbleached high-gluten, bread, or all-purpose flour, chilled","1 3/4 (.44 ounce) teaspoons salt","1 teaspoon (.11 ounce) instant yeast","1/4 cup (2 ounces) olive oil (optional)","1 3/4 cups (14 ounces) water, ice cold (40F)","Semolina flour OR cornmeal for dusting"]
/// source_url : "http://www.101cookbooks.com/archives/001199.html"
/// recipe_id : "47746"
/// image_url : "http://forkify-api.herokuapp.com/images/best_pizza_dough_recipe1b20.jpg"
/// social_rank : 100
/// publisher_url : "http://www.101cookbooks.com"
/// title : "Best Pizza Dough Ever"

class Recipe {
  Recipe({
      String? publisher, 
      List<String>? ingredients, 
      String? sourceUrl, 
      String? recipeId, 
      String? imageUrl, 
      dynamic? socialRank,
      String? publisherUrl, 
      String? title,}){
    _publisher = publisher;
    _ingredients = ingredients;
    _sourceUrl = sourceUrl;
    _recipeId = recipeId;
    _imageUrl = imageUrl;
    _socialRank = socialRank;
    _publisherUrl = publisherUrl;
    _title = title;
}

  Recipe.fromJson(dynamic json) {
    _publisher = json['publisher'];
    _ingredients = json['ingredients'] != null ? json['ingredients'].cast<String>() : [];
    _sourceUrl = json['source_url'];
    _recipeId = json['recipe_id'];
    _imageUrl = json['image_url'];
    _socialRank = json['social_rank'];
    _publisherUrl = json['publisher_url'];
    _title = json['title'];
  }
  String? _publisher;
  List<String>? _ingredients;
  String? _sourceUrl;
  String? _recipeId;
  String? _imageUrl;
  dynamic? _socialRank;
  String? _publisherUrl;
  String? _title;

  String? get publisher => _publisher;
  List<String>? get ingredients => _ingredients;
  String? get sourceUrl => _sourceUrl;
  String? get recipeId => _recipeId;
  String? get imageUrl => _imageUrl;
  int? get socialRank => _socialRank;
  String? get publisherUrl => _publisherUrl;
  String? get title => _title;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['publisher'] = _publisher;
    map['ingredients'] = _ingredients;
    map['source_url'] = _sourceUrl;
    map['recipe_id'] = _recipeId;
    map['image_url'] = _imageUrl;
    map['social_rank'] = _socialRank;
    map['publisher_url'] = _publisherUrl;
    map['title'] = _title;
    return map;
  }

}