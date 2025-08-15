import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news/model/newsresponse.dart';
import 'package:news/ui/custom/mini_article.dart';
import 'package:news/utils/app_colors.dart';
import 'package:news/utils/app_styles.dart';

class NewsItem extends StatefulWidget {
  Articles articles;

  NewsItem({super.key, required this.articles});

  @override
  State<NewsItem> createState() => _NewsItemState();
}

class _NewsItemState extends State<NewsItem> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    //var publishDate = articles.publishedAt ;
    //var date = DateFormat('m').format(publishDate as DateTime);
    //var format = DateFormat.MINUTE;
    //var dateString = format;

    var time = widget.articles.publishedAt ?? "";
    var dateTime = DateTime.tryParse(time)!;
    var totalMinutes = dateTime.minute;
    return InkWell(
      onTap: () {
        ShowMiniArticle();
      },
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: width * 0.02,
          vertical: height * 0.01,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.02,
          vertical: height * 0.01,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Theme.of(context).indicatorColor, width: 2),
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: CachedNetworkImage(
                imageUrl: widget.articles.urlToImage ?? "",
                placeholder: (context, url) => Center(
                  child: CircularProgressIndicator(color: AppColors.greyColor),
                ),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
            SizedBox(height: height * 0.02),
            Text(
              widget.articles.title ?? "",
              style: Theme.of(context).textTheme.labelLarge,
            ),
            SizedBox(height: height * 0.02),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    "By : ${widget.articles.author ?? ""}",
                    style: AppStyles.medium12Gray,
                  ),
                ),
                Text(
                  "${totalMinutes} minutes ago",
                  style: AppStyles.medium12Gray,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void ShowMiniArticle() {
    showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Theme.of(context).indicatorColor,
      context: context,
      builder: (context) => MiniArticle(articles: widget.articles),
    );
  }
}
