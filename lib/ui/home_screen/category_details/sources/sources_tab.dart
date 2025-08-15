import 'package:flutter/material.dart';
import 'package:news/model/sourcerecponse.dart';
import 'package:news/ui/home_screen/category_details/sources/source_name.dart';
import 'package:news/ui/home_screen/news_widget/news_widget.dart';
import 'package:news/utils/app_colors.dart';

class SourcesTab extends StatefulWidget {
  List<Sources> sources;

  SourcesTab({super.key, required this.sources});

  @override
  State<SourcesTab> createState() => _SourcesTabState();
}

class _SourcesTabState extends State<SourcesTab> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return DefaultTabController(
      length: widget.sources.length,
      child: Column(
        children: [
          TabBar(
            isScrollable: true,
            dividerColor: AppColors.transparentColor,
            indicatorColor: Theme.of(context).indicatorColor,
            tabAlignment: TabAlignment.start,
            onTap: (index) {
              selectedIndex = index;
              setState(() {});
            },
            tabs: widget.sources.map((source) {
              return SourceName(
                sources: source,
                isSelected: selectedIndex == widget.sources.indexOf(source),
              );
            }).toList(),
          ),
          SizedBox(height: height * 0.005),
          Expanded(child: NewsWidget(source: widget.sources[selectedIndex])),
        ],
      ),
    );
  }
}
