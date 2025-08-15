import 'package:flutter/material.dart';
import 'package:news/utils/app_assets.dart';

class Category {
  String id;

  String title;

  String image;

  Category({required this.id, required this.title, required this.image});

  static List<Category> getCategoryList(ThemeMode thememode) {
    return [
      Category(
        id: 'general',
        title: 'General',
        image: thememode == ThemeMode.dark
            ? AppAssets.generalLight
            : AppAssets.generalDark,
      ),
      Category(
        id: 'business',
        title: 'Business',
        image: thememode == ThemeMode.dark
            ? AppAssets.busniess
            : AppAssets.busniessDark,
      ),
      Category(
        id: 'entertainment',
        title: 'Entertainment',
        image: thememode == ThemeMode.dark
            ? AppAssets.entertainment
            : AppAssets.entertainmentDark,
      ),
      Category(
        id: 'health',
        title: 'Health',
        image: thememode == ThemeMode.dark
            ? AppAssets.healthLight
            : AppAssets.healthDark,
      ),
      Category(
        id: 'science',
        title: 'Science',
        image: thememode == ThemeMode.dark
            ? AppAssets.sciencelight
            : AppAssets.scieneDark,
      ),
      Category(
        id: 'technology',
        title: 'Technology',
        image: thememode == ThemeMode.dark
            ? AppAssets.technology
            : AppAssets.technologyDark,
      ),
      Category(
        id: 'sports',
        title: 'Sports',
        image: thememode == ThemeMode.dark
            ? AppAssets.sportlight
            : AppAssets.sportDark,
      ),
    ];
  }
}

/*

 */
