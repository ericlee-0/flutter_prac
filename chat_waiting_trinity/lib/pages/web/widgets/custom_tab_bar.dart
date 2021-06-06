import 'package:flutter/material.dart';

class CustomTabBar extends StatelessWidget {
  final TabController controller;
  final List<IconData> icons;
  final int selectedIndex;
  final Function(int) onTap;
  final bool isBottomIndicator;
  final Widget unreadChatNum;

  const CustomTabBar(
      {Key key,
      this.controller,
      @required this.icons,
      @required this.selectedIndex,
      @required this.onTap,
      this.isBottomIndicator = false,
      this.unreadChatNum})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: controller,
      isScrollable: false,
      indicatorPadding: EdgeInsets.zero,
      indicator: BoxDecoration(
        border: isBottomIndicator
            ? Border(
                bottom: BorderSide(
                  color: Colors.blue,
                  width: 3.0,
                ),
              )
            : Border(
                top: BorderSide(
                  color: Colors.blue,
                  width: 3.0,
                ),
              ),
      ),
      tabs: icons
          .asMap()
          .map((i, e) => MapEntry(
                i,
                Tab(
                  icon: i == 4
                      ? Stack(children: [
                          Icon(e,
                              color: i == selectedIndex
                                  ? Colors.blue
                                  : Colors.black45),
                          Positioned(
                            top: 0,
                            left: 0,
                            child: unreadChatNum,
                          )
                        ])
                      : Icon(
                          e,
                          color:
                              i == selectedIndex ? Colors.blue : Colors.black45,
                          size: 25.0,
                        ),
                ),
              ))
          .values
          .toList(),
      onTap: onTap,
    );
  }
}
