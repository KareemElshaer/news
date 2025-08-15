import 'package:flutter/material.dart';
import 'package:news/l10n/app_localizations.dart';
import 'package:news/model/category.dart';
import 'package:news/model/newsresponse.dart';
import 'package:news/ui/category_Fragmentt/category_fragment.dart';
import 'package:news/ui/custom/custom_contaner.dart';
import 'package:news/ui/home_screen/category_details/category_details.dart';
import 'package:news/utils/app_colors.dart';
import 'package:news/utils/app_styles.dart';
import 'package:provider/provider.dart';

import '../../api/api_manger.dart';
import '../../providers/language_provider.dart';
import '../../providers/theme_provider.dart';
import 'news_widget/news_item.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isSearching = false;

  List<Articles> articlsbyscearch = [];

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var languageprov = Provider.of<LanguageProvider>(context);
    var themeProv = Provider.of<ThemeProvider>(context);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    Map<String, String> langoption = languageprov.appLanguage == 'en'
        ? {"english": "en", "arabic": "ar"}
        : {"الأنجليزية": "en", "العربيه": "ar"};
    Map<String, String> themeOptions = languageprov.appLanguage == 'en'
        ? {"Dark": "dark", "Light": "light"}
        : {"ليلي": "dark", "نهاري": "light"};
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 10,
        scrolledUnderElevation: 0,
        elevation: 0,
        title: isSearching
            ? TextFormField(
                autofocus: true,
                onFieldSubmitted: (text) async {
                  if (text.trim().isEmpty) {
                    articlsbyscearch.clear();
                    setState(() {});
                    return;
                  }
                  var searchNews = await ApiManger.getnewsSources(
                    selectedCategory?.id,
                    text,
                    1,
                  );
                  articlsbyscearch = searchNews.articles ?? [];
                  setState(() {});
                },
                decoration: InputDecoration(
                  isDense: true,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(
                      color: themeProv.themeMode == ThemeMode.dark
                          ? AppColors.whiteColor
                          : AppColors.blackColor,
                      width: 2,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),

                    borderSide: BorderSide(
                      color: themeProv.themeMode == ThemeMode.dark
                          ? AppColors.whiteColor
                          : AppColors.blackColor,
                      width: 2,
                    ),
                  ),
                  hintText: AppLocalizations.of(context)!.search,
                  prefixIcon: Icon(
                    Icons.search,
                    color: AppColors.whiteColor,
                    size: 30,
                  ),
                  hintStyle: themeProv.themeMode == ThemeMode.dark
                      ? AppStyles.medium20White
                      : AppStyles.medium20Black,
                ),
                cursorColor: themeProv.themeMode == ThemeMode.dark
                    ? AppColors.whiteColor
                    : AppColors.blackColor,
                controller: searchController,
              )
            : Text(
                selectedCategory == null
                    ? AppLocalizations.of(context)!.home
                    : selectedCategory!.id,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
        actions: isSearching
            ? [
                IconButton(
                  onPressed: () {
                    setState(() {
                      isSearching = false;
                      searchController.clear();
                      articlsbyscearch = [];
                    });
                  },
                  icon: Icon(
                    Icons.close,
                    color: themeProv.themeMode == ThemeMode.dark
                        ? AppColors.whiteColor
                        : AppColors.blackColor,
                    size: 30,
                  ),
                ),
              ]
            : [
                IconButton(
                  onPressed: () {
                    setState(() {
                      isSearching = true;
                    });
                  },
                  icon: Icon(Icons.search, size: 30),
                ),
              ],
      ),
      drawer: isSearching
          ? null
          : Drawer(
              backgroundColor: AppColors.blackColor,
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    color: AppColors.whiteColor,
                    width: double.infinity,
                    height: height * 0.25,
                    child: Center(
                      child: Text(
                        "News App",
                        style: AppStyles.bold20Black.copyWith(fontSize: 24),
                      ),
                    ),
                  ),
                  SizedBox(height: height * 0.02),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.02),
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () {
                            selectedCategory = null;
                            Navigator.pop(context);
                            setState(() {});
                          },
                          child: Row(
                            children: [
                              Icon(
                                Icons.home_outlined,
                                color: AppColors.whiteColor,
                                size: 25,
                              ),
                              SizedBox(width: width * 0.01),
                              Text(
                                AppLocalizations.of(context)!.go_to_home,
                                style: AppStyles.bold20White,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: height * 0.02),
                        Divider(
                          color: AppColors.whiteColor,
                          thickness: 2,
                          endIndent: width * 0.04,
                          indent: width * 0.02,
                        ),
                        SizedBox(height: height * 0.02),
                        Row(
                          children: [
                            Icon(
                              Icons.language,
                              color: AppColors.whiteColor,
                              size: 25,
                            ),
                            SizedBox(width: width * 0.01),
                            Text(
                              AppLocalizations.of(context)!.language,
                              style: AppStyles.bold20White,
                            ),
                          ],
                        ),
                        SizedBox(height: height * 0.02),
                        CustomContaner(
                          textSelected: languageprov.appLanguage == 'en'
                              ? AppLocalizations.of(context)!.english
                              : AppLocalizations.of(context)!.arabic,
                          onChange: (lang) {
                            final langsel =
                                langoption[lang!]; // "dark" or "light"
                            languageprov.ChangeLanguage(langsel!);
                          },
                          dropDown: langoption.keys.toList(),
                        ),
                        SizedBox(height: height * 0.02),
                        Divider(
                          color: AppColors.whiteColor,
                          thickness: 2,
                          endIndent: width * 0.04,
                          indent: width * 0.02,
                        ),
                        SizedBox(height: height * 0.02),
                        Row(
                          children: [
                            Icon(
                              Icons.imagesearch_roller,
                              color: AppColors.whiteColor,
                              size: 25,
                            ),
                            SizedBox(width: width * 0.01),
                            Text(
                              AppLocalizations.of(context)!.theme,
                              style: AppStyles.bold20White,
                            ),
                          ],
                        ),
                        SizedBox(height: height * 0.02),
                        CustomContaner(
                          onChange: (selectedLabel) {
                            final actualValue =
                                themeOptions[selectedLabel!]; // "dark" or "light"
                            themeProv.ChangeTheme(actualValue!);
                          },
                          textSelected: themeProv.themeMode == ThemeMode.dark
                              ? AppLocalizations.of(context)!.dark
                              : AppLocalizations.of(context)!.light,
                          dropDown: themeOptions.keys.toList(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
      body: isSearching
          ? ListView.builder(
              itemCount: articlsbyscearch.length,
              itemBuilder: (context, index) {
                return NewsItem(articles: articlsbyscearch[index]);
              },
            )
          : selectedCategory == null
          ? CategoryFragment(oncategoryclick: onCategoryClick)
          : CategoryDetails(category: selectedCategory!),
    );
  }

  Category? selectedCategory;

  void onCategoryClick(Category newCategory) {
    selectedCategory = newCategory;
    setState(() {});
  }
}
