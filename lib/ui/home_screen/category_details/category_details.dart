import 'package:flutter/material.dart';
import 'package:news/api/api_manger.dart';
import 'package:news/model/category.dart';
import 'package:news/model/sourcerecponse.dart';
import 'package:news/ui/home_screen/category_details/sources/sources_tab.dart';
import 'package:news/utils/app_colors.dart';

class CategoryDetails extends StatefulWidget {
  Category category;

  CategoryDetails({super.key, required this.category});

  @override
  State<CategoryDetails> createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails> {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return FutureBuilder<Sourcerecponse?>(
      future: ApiManger.getSources(widget.category.id),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(color: AppColors.greyColor),
          );
        } else if (snapshot.hasError) {
          return Column(
            //crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Text(
                  "somthing went error",
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ),
              SizedBox(height: screenSize.height * 0.01),
              ElevatedButton(
                onPressed: () {
                  ApiManger.getSources(widget.category.id);
                  setState(() {});
                },
                child: Text(
                  "Try Again",
                  style: TextStyle(color: AppColors.blackColor),
                ),
              ),
            ],
          );
        }
        if (snapshot.data?.status != 'ok') {
          return Column(
            children: [
              Text(
                snapshot.data!.message!,
                style: Theme.of(context).textTheme.labelMedium,
              ),
              SizedBox(height: screenSize.height * 0.02),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).indicatorColor,
                ),
                onPressed: () {
                  ApiManger.getSources(widget.category.id);
                  setState(() {});
                },
                child: Text(
                  "Try Again",
                  style: TextStyle(color: AppColors.blackColor),
                ),
              ),
            ],
          );
        }
        var sourceslist = snapshot.data?.sources ?? [];
        return SourcesTab(sources: sourceslist);
      },
    );
  }
}
