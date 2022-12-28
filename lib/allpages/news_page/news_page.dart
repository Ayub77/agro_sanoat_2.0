// ignore_for_file: prefer_const_constructors

import 'package:agro_sanoat/allpages/animation_loading/loading.dart';
import 'package:agro_sanoat/allpages/news_page/news_page_provider.dart';
import 'package:agro_sanoat/allpages/news_page/widgets/big_view_news.dart';
import 'package:agro_sanoat/funcsions/main_colors.dart';
import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import 'widgets/list_widget.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({Key? key}) : super(key: key);

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  NewsPageProvider provider = NewsPageProvider();
  @override
  void initState() {
    super.initState();
    provider.onStart();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return ChangeNotifierProvider(
      create: (context) => provider,
      child: Consumer<NewsPageProvider>(
        builder: (context, value, child) => Scaffold(
          backgroundColor: MainColors.fromHex(MainColors.colorBack),
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            centerTitle: true,
            leading: IconButton(
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                icon: SvgPicture.asset(
                  "assets/images/drawer.svg",
                  color: MainColors.fromHex(MainColors.colorGreen),
                )),
            title: Text(
              "Yangiliklar",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.green),
            ),
          ),
          body: RefreshIndicator(
            onRefresh: () async {
              provider.refresh();
            },
            child: Stack(
              children: [
                ListView.builder(
                    itemCount: provider.items.length,
                    physics: BouncingScrollPhysics(),
                    controller: provider.controller,
                    itemBuilder: (context, index) {
                      return ListWidgetNews(
                        item: provider.items[index],
                        size: size,
                        ontap: (value) {
                          provider.bigView(context, value);
                        },
                      );
                    }),
                Visibility(visible: provider.loading, child: Loading())
              ],
            ),
          ),
        ),
      ),
    );
  }
}
