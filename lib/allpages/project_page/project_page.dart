// ignore_for_file: prefer_const_constructors

import 'package:agro_sanoat/allpages/animation_loading/loading.dart';
import 'package:agro_sanoat/allpages/project_page/project_page_provider.dart';
import 'package:agro_sanoat/allpages/project_page/widgets/list_widget.dart';
import 'package:agro_sanoat/funcsions/main_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class ProjectPage extends StatefulWidget {
  const ProjectPage({Key? key}) : super(key: key);

  @override
  State<ProjectPage> createState() => _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage> {
  ProjectPageProvider provider = ProjectPageProvider();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    provider.onStart();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return ChangeNotifierProvider(
        create: (context) => provider,
        child: Consumer<ProjectPageProvider>(
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
                    "Loyihalar",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.green),
                  ),
                ),
                body: Stack(
                  children: [
                    RefreshIndicator(
                      onRefresh: () async {
                        provider.refresh();
                      },
                      child: ListView.builder(
                          itemCount: provider.items.length,
                          physics: BouncingScrollPhysics(),
                          itemBuilder: ((context, index) => ListVidget(
                                size: size,
                                item: provider.items[index],
                                ontap: (value) {
                                  provider.bigView(context, value);
                                },
                              ))),
                    ),
                    Visibility(visible: provider.loading, child: Loading())
                  ],
                ))));
  }
}
