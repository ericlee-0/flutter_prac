import '../widgets/widgets.dart';
import 'package:flutter/material.dart';

class WebHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            brightness: Brightness.light,
            backgroundColor: Colors.white,
            title: SizedBox(
              height: 80,
              width: 150,
              child: Image.asset(
                'assets/images/logo_150_113.png',
              ),
            ),
            //  Text(
            //   'chat_wait',
            //   style: const TextStyle(
            //       color: Colors.blue,
            //       fontSize: 28.0,
            //       fontWeight: FontWeight.bold),
            // ),
            centerTitle: false,
            floating: true,
            actions: [
              CircleButton(
                  icon: Icons.home,
                  iconSize: 30.0,
                  onPressed: () => print('home')),
              CircleButton(
                  icon: Icons.message_rounded,
                  iconSize: 30.0,
                  onPressed: () => print('message')),
              CircleButton(
                  icon: Icons.timelapse,
                  iconSize: 30.0,
                  onPressed: () => print('waiting'))
            ],
          ),
          SliverToBoxAdapter(
            child: CreatePostContainer(waitTime: 10),
          ),
          SliverPadding(
            padding: EdgeInsets.fromLTRB(0, 10.0, 0, 5.0),
            sliver: SliverToBoxAdapter(
              child: Rooms(waitingPeople: Text('list of waiting people')),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.fromLTRB(0, 10.0, 0, 5.0),
            sliver: SliverToBoxAdapter(
              child: Stories(item: Text('list of Menu items')),
            ),
          ),
          SliverList(delegate: SliverChildBuilderDelegate(
            (context,index){
              //here will be event container. using as listview
              //final Post post = posts[index];
              return PostContainer();
            },
            childCount:5,
          ))
        ],
      ),
    );
  }
}
