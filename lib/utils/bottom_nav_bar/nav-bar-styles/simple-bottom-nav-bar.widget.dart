import 'package:flutter/material.dart';
import 'package:spotify_clone_provider/utils/bottom_nav_bar/models/nav-bar-essentials.model.dart';

class BottomNavSimple extends StatelessWidget {
  final NavBarEssentials? navBarEssentials;
  const BottomNavSimple({
    Key? key,
    this.navBarEssentials = const NavBarEssentials(items: null),
  }) : super(key: key);

  Widget _buildItem(item, bool isSelected, double? height) {
    return AnimatedContainer(
      height: height,
      width: 100,
      duration: const Duration(milliseconds: 1000),
      child: IconTheme(
        data: IconThemeData(
          size: item.iconSize,
          color: isSelected
              ? (item.activeColorSecondary ?? item.activeColorPrimary)
              : item.inactiveColorPrimary ?? item.activeColorPrimary,
        ),
        child: isSelected ? item.icon : item.inactiveIcon ?? item.icon,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: navBarEssentials!.navBarHeight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: navBarEssentials!.items!.map((item) {
          int index = navBarEssentials!.items!.indexOf(item);
          return Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                if (navBarEssentials!.items![index].onPressed != null) {
                  navBarEssentials!.items![index]
                      .onPressed!(navBarEssentials!.selectedScreenBuildContext);
                } else {
                  navBarEssentials!.onItemSelected!(index);
                }
              },
              child: _buildItem(
                item,
                navBarEssentials!.selectedIndex == index,
                navBarEssentials!.navBarHeight,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
