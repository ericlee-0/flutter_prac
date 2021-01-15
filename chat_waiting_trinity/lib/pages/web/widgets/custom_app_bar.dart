import 'package:chat_waiting_trinity/pages/web/widgets/widgets.dart';
import './user_card.dart';
import './custom_tab_bar.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final List<IconData> icons;
  final int selectedIndex;
  final Function(int) onTap;

  const CustomAppBar(
      {Key key,
      @required this.icons,
      @required this.selectedIndex,
      @required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      height: 45.0,
      decoration: BoxDecoration(color: Colors.white, boxShadow: const [
        BoxShadow(
          color: Colors.black12,
          offset: Offset(0, 2),
          blurRadius: 4.0,
        )
      ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              'chat-waiting',
              style: const TextStyle(
                color: Colors.blue,
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            height: double.infinity,
            width: 600.0,
            child: CustomTabBar(
                icons: icons,
                selectedIndex: selectedIndex,
                onTap: onTap,
                isBottomIndicator: true),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                UserCard(),
                
                Responsive.isDesktop(context)
                    ? Container(
                        child: Row(
                          children: [
                            const SizedBox(width: 12.0),
                            CircleButton(
                              icon: Icons.search,
                              iconSize: 25.0,
                              onPressed: () => print('Search'),
                            ),
                            CircleButton(
                                icon: Icons.chat,
                                iconSize: 25.0,
                                onPressed: () => print('Chat'))
                          ],
                        ),
                      )
                    : SizedBox.shrink(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
