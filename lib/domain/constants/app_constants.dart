import 'package:expenso_464/data/models/cat_model.dart';

class AppConstants{

  static const String PREF_KEY_UID = "uid";

  static final List<CatModel> mCat = [
    CatModel(id: 1, title: 'Coffee', imgPath: 'assets/icons/coffee.png'),
    CatModel(id: 2, title: 'Fast-Food', imgPath: 'assets/icons/fast-food.png'),
    CatModel(id: 3, title: 'Petrol', imgPath: 'assets/icons/vehicles.png'),
    CatModel(id: 4, title: 'Travel', imgPath: 'assets/icons/travel.png'),
    CatModel(id: 5, title: 'Snacks', imgPath: 'assets/icons/snack.png'),
    CatModel(id: 6, title: 'Restaurant', imgPath: 'assets/icons/restaurant.png'),
    CatModel(id: 7, title: 'Shopping', imgPath: 'assets/icons/hawaiian-shirt.png'),
    CatModel(id: 8, title: 'Movie', imgPath: 'assets/icons/popcorn.png'),
  ];

}