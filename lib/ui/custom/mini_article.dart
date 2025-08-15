import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news/l10n/app_localizations.dart';
import 'package:news/model/newsresponse.dart';
import 'package:url_launcher/url_launcher.dart';

class MiniArticle extends StatefulWidget {
  Articles articles;

  MiniArticle({super.key, required this.articles});

  @override
  State<MiniArticle> createState() => _MiniArticleState();
}

class _MiniArticleState extends State<MiniArticle> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: height * 0.02,
        horizontal: width * 0.02,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: CachedNetworkImage(
              imageUrl: widget.articles.urlToImage ?? "",
              placeholder: (context, url) =>
                  Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ),
          SizedBox(height: height * 0.01),
          Text(
            widget.articles.content ?? "",
            style: Theme.of(context).textTheme.bodySmall,
          ),
          SizedBox(height: height * 0.02),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              padding: EdgeInsets.symmetric(vertical: height * 0.02),
              backgroundColor: Theme.of(context).primaryColor,
            ),
            onPressed: () async {
              launch(widget.articles.url ?? "");
            },
            child: Text(
              AppLocalizations.of(context)!.view_all_article,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          SizedBox(height: height * 0.01),
        ],
      ),
    );
  }
}
