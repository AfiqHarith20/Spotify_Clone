import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import 'package:spotify_clone_provider/screens/home/home_screen.dart';
import 'package:spotify_clone_provider/screens/library/library.dart';
import 'package:spotify_clone_provider/screens/search_page/search_page.dart';
import 'package:spotify_clone_provider/utils/bottom_play_widget.dart';
import '../../controllers/main_controller.dart';
import '../../utils/bottom_nav_bar/models/nav-bar-padding.model.dart';
import '../../utils/bottom_nav_bar/models/persisten-bottom-nav-item.widget.dart';
import '../../utils/bottom_nav_bar/models/persistent-bottom-nav-bar-styles.widget.dart';
import '../../utils/bottom_nav_bar/models/persistent-nav-bar-scaffold.widget.dart';
import '../../utils/bottom_nav_bar/persistent-tab-view.widget.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  PersistentTabController controller = PersistentTabController(initialIndex: 0);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.home),
        inactiveIcon: const Icon(LineIcons.home),
        activeColorSecondary: Colors.white,
        activeColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.search),
        inactiveIcon: const Icon(CupertinoIcons.search),
        activeColorSecondary: Colors.white,
        activeColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.music_albums),
        inactiveIcon: const Icon(CupertinoIcons.music_albums),
        activeColorSecondary: Colors.white,
        activeColorPrimary: Colors.grey,
      ),
    ];
  }

  List<Widget> _buildScreens(con) {
    return [
      HomeScreen(con: con),
      SearchPage(con: con),
      Library(con: con),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MainController()..init(),
      child: Consumer<MainController>(builder: (context, con, child) {
        return PersistentTabView(
          context,
          controller: controller,
          playWidget: Material(
            child: PlayWidget(
                con: con,
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    isDismissible: false,
                    builder: (context) => CurrentPlayingSong(
                      con: con,
                    ),
                  );
                }),
          ),
          screens: _buildScreens(con),
          items: _navBarsItems(),
          confineInSafeArea: true,
          backgroundColor: Colors.black,
          handleAndroidBackButtonPress: true,
          hideNavigationBarWhenKeyboardShows: true,
          resizeToAvoidBottomInset: true,
          popAllScreenOnTapOfSelectedTab: true,
          popActionScreens: PopActionScreensType.all,
          navBarStyle: NavBarStyle.simple,
          navBarHeight: 55,
          padding: const NavBarPadding.all(0),
        );
      }),
    );
  }
}
