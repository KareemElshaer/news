import 'package:flutter/material.dart';
import 'package:news/model/newsresponse.dart';
import 'package:news/model/sourcerecponse.dart';
import 'package:news/ui/home_screen/news_widget/news_item.dart';

import '../../../api/api_manger.dart';
import '../../../utils/app_colors.dart';

class NewsWidget extends StatefulWidget {
  Sources source;

  List<Articles> newsList = [];

  NewsWidget({super.key, required this.source});

  @override
  State<NewsWidget> createState() => _NewsWidgetState();
}

class _NewsWidgetState extends State<NewsWidget> {
  String? text;

  int page = 1;

  ScrollController controller = ScrollController();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getnews();
    controller.addListener(() {
      if (controller.position.pixels >=
          controller.position.maxScrollExtent - 200) {
        getnews();
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Newsresponse>(
      future: ApiManger.getnewsSources(widget.source.id, text ?? "", page),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(color: AppColors.greyColor),
          );
        } else if (snapshot.hasError) {
          return Column(
            children: [
              Text(
                "somthing went error",
                style: Theme.of(context).textTheme.labelMedium,
              ),
              ElevatedButton(
                onPressed: () {
                  ApiManger.getnewsSources(
                    widget.source.id ?? "",
                    text ?? "",
                    page,
                  );
                  setState(() {});
                },
                child: Text(
                  "Try Again",
                  style: Theme.of(context).textTheme.labelMedium,
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
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.greyColor,
                ),
                onPressed: () {
                  ApiManger.getnewsSources(
                    widget.source.id ?? "",
                    text ?? "",
                    page,
                  );
                  setState(() {});
                },
                child: Text(
                  "Try Again",
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ),
            ],
          );
        }
        widget.newsList = snapshot.data?.articles ?? [];
        return ListView.builder(
          controller: controller,
          itemBuilder: (context, index) {
            return NewsItem(articles: widget.newsList[index]);
          },
          itemCount: widget.newsList.length,
        );
      },
    );
  }

  Future<void> getnews() async {
    if (isLoading) return;
    setState(() {
      isLoading = true;
    });
    final response = await ApiManger.getnewsSources(
      widget.source.id,
      text ?? '',
      page,
    );
    print("Page: $page, Articles: ${response.articles?.length}");

    page++;

    setState(() {
      isLoading = false;
    });
  }
}
