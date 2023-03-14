// ignore_for_file: prefer_const_constructors

import 'package:agro_sanoat/allpages/animation_loading/loading.dart';
import 'package:agro_sanoat/allpages/servide_page/service_page_provider.dart';
import 'package:agro_sanoat/allpages/servide_page/widgets/list_widget.dart';
import 'package:agro_sanoat/funcsions/main_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class ServicePage extends StatefulWidget {
  const ServicePage({Key? key}) : super(key: key);

  @override
  State<ServicePage> createState() => _ServicePageState();
}

class _ServicePageState extends State<ServicePage> {
  ServicePageProvider provider = ServicePageProvider();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    provider.onStart();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => provider,
      child: Consumer<ServicePageProvider>(
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
                  "Xizmatlar",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.green),
                ),
              ),
              body: provider.items.isEmpty
                  ? Center(
                      child: Text(
                        "Ma'lumotlar mavjud emas!",
                        style: TextStyle(
                            color: MainColors.fromHex(MainColors.colorBlack),
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
                      ),
                    )
                  : Stack(
                      children: [
                        RefreshIndicator(
                          onRefresh: () async {
                            provider.refresh();
                          },
                          child: ListView.builder(
                              itemCount: provider.items.length,
                              physics: BouncingScrollPhysics(),
                              itemBuilder: (context, index) => ServiceWidget(
                                    item: provider.items[index],
                                    ontab: (value) {
                                      provider.bigView(context, value);
                                    },
                                  )),
                        ),
                        Visibility(visible: provider.loading, child: Loading())
                      ],
                    ))),
    );
  }
}
