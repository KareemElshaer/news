import 'package:flutter/material.dart';
import 'package:news/l10n/app_localizations.dart';
import 'package:news/model/category.dart';
import 'package:news/utils/app_colors.dart';
import 'package:provider/provider.dart';

import '../../providers/language_provider.dart';

class CategoryItem extends StatelessWidget {
  Category category;

  int index;

  CategoryItem({super.key, required this.category, required this.index});

  @override
  Widget build(BuildContext context) {
    var languageprov = Provider.of<LanguageProvider>(context);
    bool selindex = (index % 2 == 0);

    var screenSize = MediaQuery.of(context).size;
    return Stack(
      alignment: selindex ? Alignment.bottomRight : Alignment.bottomLeft,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Image.asset(category.image),
        ),
        Container(
          margin: EdgeInsets.symmetric(
            horizontal: screenSize.width * 0.03,
            vertical: screenSize.height * 0.015,
          ),
          padding: EdgeInsetsDirectional.only(
            start: selindex ? screenSize.width * 0.02 : 0,
            end: selindex ? screenSize.width * 0 : screenSize.width * 0.02,
          ),
          width: screenSize.width * 0.35,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(84),
            color: AppColors.greyColor,
          ),
          child: Row(
            textDirection: languageprov.appLanguage == 'en'
                ? textDirectionEnglish()
                : textDirectionArabic(),
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppLocalizations.of(context)!.view_all,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              CircleAvatar(
                backgroundColor: Theme.of(context).primaryColor,
                radius: 25,
                child: Icon(
                  selindex
                      ? Icons.arrow_forward_ios_rounded
                      : Icons.arrow_back_ios_new,
                  color: Theme.of(context).indicatorColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  TextDirection textDirectionEnglish() {
    if (index % 2 == 0) {
      return TextDirection.ltr;
    }
    return TextDirection.rtl;
  }

  TextDirection textDirectionArabic() {
    if (index % 2 == 0) {
      return TextDirection.rtl;
    }
    return TextDirection.ltr;
  }
}
