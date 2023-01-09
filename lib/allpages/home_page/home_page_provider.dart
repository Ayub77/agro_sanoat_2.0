import 'package:agro_sanoat/allpages/add_page/add_page.dart';
import 'package:agro_sanoat/allpages/header_page/header_page.dart';
import 'package:agro_sanoat/allpages/news_page/news_page.dart';
import 'package:agro_sanoat/allpages/project_page/project_page.dart';
import 'package:agro_sanoat/allpages/servide_page/service_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:rect_getter/rect_getter.dart';

class HomePageProvider extends ChangeNotifier {
  int currenttab = 0;
  Rect? rect;
  var thisContext;
  final Duration animationDuration = const Duration(milliseconds: 300);
  final Duration delay = const Duration(milliseconds: 300);
  GlobalKey<RectGetterState> rectGetterKey = RectGetter.createGlobalKey();
  var currentBackPressTime;
  List<Widget> allWindows = [
    const HeaderPage(),
    const NewsPage(),
    const ProjectPage(),
    const ServicePage()
  ];
  selectCurrentTab(index) {
    currenttab = index;
    notifyListeners();
  }

  onstart(context) {
    thisContext = context;
  }

  nextAddPage(context) {
    rect = RectGetter.getRectFromKey(rectGetterKey);
    notifyListeners();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      rect = rect!.inflate(1.3 * MediaQuery.of(context).size.longestSide);
      notifyListeners();
      Future.delayed(animationDuration + delay, goToNextPage);
    });
  }

  void goToNextPage() {
    Navigator.of(thisContext)
        .push(FadeRouteBuilder(page: const AddPage()))
        .then((_) {
      rect = null;
      notifyListeners();
    });
  }

  Future<bool> onWillPop() async {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      EasyLoading.showToast('Dasturdan chiqish uchun yana bir marta bosing!');
      return Future.value(false);
    }
    return Future.value(true);
  }
}

class FadeRouteBuilder<T> extends PageRouteBuilder<T> {
  final Widget page;

  FadeRouteBuilder({required this.page})
      : super(
          pageBuilder: (context, animation1, animation2) => page,
          transitionsBuilder: (context, animation1, animation2, child) {
            return FadeTransition(opacity: animation1, child: child);
          },
        );
}
