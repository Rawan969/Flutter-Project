import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutterproject/modles/cart_modle.dart';
import 'package:flutterproject/modles/categories_modle.dart';
import 'package:flutterproject/modles/food_categories_modle.dart';
import 'package:flutterproject/modles/food_modle.dart';

class MyProvider extends ChangeNotifier {
  List<CategoriesModle> burgerList = [];
  late CategoriesModle burgerModle;
  Future<void> getBurgerCategory() async {
    List<CategoriesModle> newBurgerList = [];
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('categories')
        .doc('QcbGZC0YpZFJTQFofN2H')
        .collection('burger')
        .get();
    querySnapshot.docs.forEach((element) {
      burgerModle = CategoriesModle(
        image: element['image'],
        name: element['name'],
      );
      newBurgerList.add(burgerModle);
      burgerList = newBurgerList;
    });
    notifyListeners();
  }

  get throwBurgerList {
    return burgerList;
  }

  /////////////////// 2nd category ////////////////
  List<CategoriesModle> recipeList = [];
  late CategoriesModle recipeModle;
  Future<void> getRecipeCategory() async {
    List<CategoriesModle> newRecipeList = [];
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('categories')
        .doc('QcbGZC0YpZFJTQFofN2H')
        .collection('Recipe')
        .get();
    querySnapshot.docs.forEach((element) {
      recipeModle = CategoriesModle(
        image: element['image'],
        name: element['name'],
      );
      newRecipeList.add(recipeModle);
      recipeList = newRecipeList;
    });
    notifyListeners();
  }

  get throwRecipeList {
    return recipeList;
  }

  /////////////// 3nd Category///////////////////////

  List<CategoriesModle> pizzaList = [];
  late CategoriesModle pizzaModle;
  Future<void> getPizzaCategory() async {
    List<CategoriesModle> newPizzaList = [];
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('categories')
        .doc('QcbGZC0YpZFJTQFofN2H')
        .collection('Pizza')
        .get();
    querySnapshot.docs.forEach((element) {
      pizzaModle = CategoriesModle(
        image: element['image'],
        name: element['name'],
      );
      newPizzaList.add(pizzaModle);
      pizzaList = newPizzaList;
    });
    notifyListeners();
  }

  get throwPizzaList {
    return pizzaList;
  }

/////////////////4th category /////////////

  List<CategoriesModle> drinkList = [];
  late CategoriesModle drinkModle;
  Future<void> getDrinkCategory() async {
    List<CategoriesModle> newDrinkList = [];
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('categories')
        .doc('QcbGZC0YpZFJTQFofN2H')
        .collection('Drink')
        .get();
    querySnapshot.docs.forEach((element) {
      drinkModle = CategoriesModle(
        image: element['image'],
        name: element['name'],
      );
      newDrinkList.add(drinkModle);
      drinkList = newDrinkList;
    });
    notifyListeners();
  }

  get throwDrinkList {
    return drinkList;
  }

  /////////////////////  Single Food Item     //////////////////////////

 List<FoodModle> foodModleList = [];
late FoodModle foodModle;

Future<void> getFoodList() async {
  List<FoodModle> newSingleFoodList = [];
  QuerySnapshot querySnapshot =
      await FirebaseFirestore.instance.collection('Foods').get();
  querySnapshot.docs.forEach(
    (element) {
      String name = element['name'];
      String image = element['image'];
      
      // Check if 'price' is a valid integer
      int price = 0; // Default value in case parsing fails
      if (element['price'] is int) {
        price = element['price'];
      } else if (element['price'] is String) {
        try {
          price = int.parse(element['price']);
        } catch (e) {
          print('Error parsing price: $e');
        }
      }

      foodModle = FoodModle(
        name: name,
        image: image,
        price: price,
      );
      newSingleFoodList.add(foodModle);
    },
  );

  foodModleList = newSingleFoodList;
  notifyListeners();
}

  get throwFoodModleList {
    return foodModleList;
  }

  ///////////////burger categories list//////////
  List<FoodCategoriesModle> burgerCategoriesList = [];
  late FoodCategoriesModle burgerCategoriesModle;
  Future<void> getBurgerCategoriesList() async {
    List<FoodCategoriesModle> newBurgerCategoriesList = [];
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('foodcategories')
        .doc('Dq1PdJRWz7tAdPFoXHNp')
        .collection('burger')
        .get();
    querySnapshot.docs.forEach((element) {
      burgerCategoriesModle = FoodCategoriesModle(
        image: element['image'],
        name: element['name'],
        price: element['price'],
      );
      newBurgerCategoriesList.add(burgerCategoriesModle);
      burgerCategoriesList = newBurgerCategoriesList;
    });
  }

  get throwBurgerCategoriesList {
    return burgerCategoriesList;
  }

  ///////////////Recipe categories list//////////
  List<FoodCategoriesModle> recipeCategoriesList = [];
  late FoodCategoriesModle recipeCategoriesModle;
  Future<void> getrecipeCategoriesList() async {
    List<FoodCategoriesModle> newrecipeCategoriesList = [];
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('foodcategories')
        .doc('Dq1PdJRWz7tAdPFoXHNp')
        .collection('recipe')
        .get();
    querySnapshot.docs.forEach((element) {
      recipeCategoriesModle = FoodCategoriesModle(
        image: element['image'],
        name: element['name'],
        price: element['price'],
      );
      newrecipeCategoriesList.add(recipeCategoriesModle);
      recipeCategoriesList = newrecipeCategoriesList;
    });
  }

  get throwRecipeCategoriesList {
    return recipeCategoriesList;
  }

  ///////////////Pizza categories list//////////
  List<FoodCategoriesModle> pizzaCategoriesList = [];
  late FoodCategoriesModle pizzaCategoriesModle;
  Future<void> getPizzaCategoriesList() async {
    List<FoodCategoriesModle> newPizzaCategoriesList = [];
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('foodcategories')
        .doc('Dq1PdJRWz7tAdPFoXHNp')
        .collection('pizza')
        .get();
    querySnapshot.docs.forEach((element) {
      pizzaCategoriesModle = FoodCategoriesModle(
        image: element['image'],
        name: element['name'],
        price: element['price'],
      );
      newPizzaCategoriesList.add(pizzaCategoriesModle);
      pizzaCategoriesList = newPizzaCategoriesList;
    });
  }

  get throwPizzaCategoriesList {
    return pizzaCategoriesList;
  }

  ///////////////Drink categories list//////////
  List<FoodCategoriesModle> drinkCategoriesList = [];
  late FoodCategoriesModle drinkCategoriesModle;
  Future<void> getDrinkCategoriesList() async {
    List<FoodCategoriesModle> newDrinkCategoriesList = [];
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('foodcategories')
        .doc('Dq1PdJRWz7tAdPFoXHNp')
        .collection('drink')
        .get();
    querySnapshot.docs.forEach((element) {
      drinkCategoriesModle = FoodCategoriesModle(
        image: element['image'],
        name: element['name'],
        price: element['price'],
      );
      newDrinkCategoriesList.add(drinkCategoriesModle);
      drinkCategoriesList = newDrinkCategoriesList;
    });
  }

  get throwDrinkCategoriesList {
    return drinkCategoriesList;
  }

/////////////add to cart ////////////
  List<CartModle> cartList = [];
  List<CartModle> newCartList = [];
  late CartModle cartModle;
  void addToCart({
    required String image,
    required String name,
    required int price,
    required int quantity,
  }) {
    cartModle = CartModle(
      image: image,
      name: name,
      price: price,
      quantity: quantity,
    );
    newCartList.add(cartModle);
    cartList = newCartList;
  }

  get throwCartList {
    return cartList;
  }

  int totalprice() {
    int total = 0;
    cartList.forEach((element) {
      total += element.price * element.quantity;
    });
    return total;
  }
 int? deleteIndex;
 void getDeleteIndex(int index){
     deleteIndex=index;
 }
 void delete(){
   cartList.removeAt(deleteIndex!);
   notifyListeners();
 }
}