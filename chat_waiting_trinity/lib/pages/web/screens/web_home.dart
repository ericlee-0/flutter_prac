import '../widgets/widgets.dart';
import 'package:flutter/material.dart';

class WebHome extends StatefulWidget {
  @override
  _WebHomeState createState() => _WebHomeState();
}

class _WebHomeState extends State<WebHome> {
  final TrackingScrollController _trackingScrollController =
      TrackingScrollController();

  @override
  void dispose() {
    // TODO: implement dispose
    _trackingScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(), // on tap -> unfocus
      child: Scaffold(
        body: Responsive(
          mobile: _HomeMobile(scrollController: _trackingScrollController),
          desktop: _HomeDesktop(scrollController: _trackingScrollController),
        ),
      ),
    );
  }
}

class _HomeMobile extends StatelessWidget {
  final TrackingScrollController scrollController;

  const _HomeMobile({Key key, this.scrollController}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: scrollController,
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
                onPressed: () => print('Home')),
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
        SliverList(
            delegate: SliverChildBuilderDelegate(
          (context, index) {
            //here will be event container. using as listview
            //final Post post = posts[index];
            return PostContainer();
          },
          childCount: 5,
        ))
      ],
    );
  }
}

class _HomeDesktop extends StatelessWidget {
  final TrackingScrollController scrollController;

  const _HomeDesktop({Key key, this.scrollController}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return
    //  Row(
    //   children: [
    //     Flexible(
    //       flex: 2,
    //       child: Container(color: Colors.orange),
    //     ),
    //     const Spacer(),
        Container(
            width: 600.0,
            // color: Colors.yellow,
            child: CustomScrollView(
              controller: scrollController,
              slivers: [
                // SliverAppBar(
                //   brightness: Brightness.light,
                //   backgroundColor: Colors.white,
                //   title: SizedBox(
                //     height: 80,
                //     width: 150,
                //     child: Image.asset(
                //       'assets/images/logo_150_113.png',
                //     ),
                //   ),
                //   //  Text(
                //   //   'chat_wait',
                //   //   style: const TextStyle(
                //   //       color: Colors.blue,
                //   //       fontSize: 28.0,
                //   //       fontWeight: FontWeight.bold),
                //   // ),
                //   centerTitle: false,
                //   floating: true,
                //   actions: [
                //     CircleButton(
                //         icon: Icons.home,
                //         iconSize: 30.0,
                //         onPressed: () => print('Home')),
                //     CircleButton(
                //         icon: Icons.message_rounded,
                //         iconSize: 30.0,
                //         onPressed: () => print('message')),
                //     CircleButton(
                //         icon: Icons.timelapse,
                //         iconSize: 30.0,
                //         onPressed: () => print('waiting'))
                //   ],
                // ),
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
                SliverList(
                    delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    //here will be event container. using as listview
                    //final Post post = posts[index];
                    return PostContainer();
                  },
                  childCount: 5,
                ))
              ],
            )
            )
            // ,
        // const Spacer(),
        // Flexible(
        //   flex: 2,
        //   child: Align(
        //     alignment: Alignment.centerRight,
        //     child: Padding(
        //       padding: const EdgeInsets.all(12.0),
        //       child: WebChatContainer(),
        //     ),
        //   ),
        // ),
      // ],
    // )
    ;
  }
}
