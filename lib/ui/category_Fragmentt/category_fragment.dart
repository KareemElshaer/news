import 'package:flutter/material.dart';
import 'package:news/l10n/app_localizations.dart';
import 'package:news/model/category.dart';
import 'package:news/ui/category_Fragmentt/category_item.dart';
import 'package:provider/provider.dart';

import '../../providers/theme_provider.dart';

typedef Oncategoryclick = void Function(Category);

class CategoryFragment extends StatelessWidget {
  List<Category> categoryList = [];

  Oncategoryclick oncategoryclick;

  CategoryFragment({super.key, required this.oncategoryclick});

  @override
  Widget build(BuildContext context) {
    var themeProv = Provider.of<ThemeProvider>(context);
    var screenSize = MediaQuery.of(context).size;
    var categoryList = Category.getCategoryList(themeProv.themeMode);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.03),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(
              context,
            )!.good_morning_here_is_some_news_for_you,
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          SizedBox(height: screenSize.height * 0.02),
          Expanded(
            child: ListView.separated(
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    oncategoryclick(categoryList[index]);
                  },
                  child: CategoryItem(
                    category: categoryList[index],
                    index: index,
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(height: screenSize.height * 0.02);
              },
              itemCount: categoryList.length,
            ),
          ),
        ],
      ),
    );
  }
}
