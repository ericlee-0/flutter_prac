import 'package:flutter/material.dart';
import '../widgets/widgets.dart';

class WebMenu extends StatelessWidget {
  final TrackingScrollController _trackingScrollController =
      TrackingScrollController();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
          body: Responsive(
        mobile: _MenuMobile(
          scrollController: _trackingScrollController,
        ),
        desktop: _MenuDesktop(
          scrollController: _trackingScrollController,
        ),
      )),
    );
  }
}

class _MenuMobile extends StatelessWidget {
  final TrackingScrollController scrollController;

  const _MenuMobile({Key key, this.scrollController}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: scrollController,
      slivers: [
        SliverPadding(
          padding: EdgeInsets.fromLTRB(0, 10.0, 0, 5.0),
          sliver: SliverToBoxAdapter(
            child: Column(
              children: [
                Container(
                  height: 30,
                  width: double.infinity,
                  child: Text('menu'),
                  color: Colors.yellow,
                ),
                Container(
                  height: 550,
                  width: double.infinity,
                  child: Text('menu info'),
                  color: Colors.green,
                ),
                Container(
                  height: 400,
                  width: double.infinity,
                  child: Text('Footer : support & Copyright'),
                  color: Colors.orange,
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}

class _MenuDesktop extends StatefulWidget {
  final TrackingScrollController scrollController;

  const _MenuDesktop({Key key, this.scrollController}) : super(key: key);

  @override
  __MenuDesktopState createState() => __MenuDesktopState();
}

class __MenuDesktopState extends State<_MenuDesktop> {
  // ScrollController _scrollController;
  var selectedSlide;
  var scrollInt;

  List allSlides = [
    {
      'widget': 'assets/images/web_menu_1.jpeg',
      'selected': false,
      'text': 'Menu'
    },
    {
      'widget': 'assets/images/web_menu_2.jpeg',
      'selected': false,
      'text': 'Dinner'
    },
    {
      'widget': 'assets/images/web_menu_3.jpeg',
      'selected': false,
      'text': 'Lunch'
    },
    {
      'widget': 'assets/images/web_menu_1.jpeg',
      'selected': false,
      'text': 'Drinks'
    },
    // {'widget': 'assets/images/web_menu_1.jpeg', 'selected': false},
    // {'widget': 'assets/images/web_menu_1.jpeg', 'selected': false},
    // {'widget': 'assets/images/web_menu_1.jpeg', 'selected': false},
    // {'widget': 'assets/images/web_menu_1.jpeg', 'selected': false},
  ];

  List allSlides2 = [
    {'image': 'assets/images/web_menu_2.jpeg'},
    {'image': 'assets/images/web_menu_2.jpeg'},
    {'image': 'assets/images/web_menu_3.jpeg'},
    {'image': 'assets/images/web_menu_3.jpeg'},
  ];

  @override
  void initState() {
    super.initState();
    // _scrollController = ScrollController();
    widget.scrollController.addListener(changeSelector);
    setState(() {
      scrollInt = 0;
      selectedSlide = allSlides[0];
      selectedSlide['selected'] = true;
    });
  }

  changeSelector() {
    // var maxScrollVal = _scrollController.position.maxScrollExtent;

    // var divisor = (maxScrollVal / allSlides.length) + 25;
    // var divisor = 65;

    var scrollValue = widget.scrollController.offset.round();
    var slideValue = 0;
    var scrollIntValue;
    if (scrollValue <= 150)
      scrollIntValue = 0;
    else if (scrollValue < 180)
      scrollIntValue = 1;
    else if (scrollValue < 210)
      scrollIntValue = 2;
    else if (scrollValue < 240)
      scrollIntValue = 3;
    else if (scrollValue < 270)
      scrollIntValue = 4;
    else if (scrollValue < 300)
      scrollIntValue = 5;
    else if (scrollValue < 330)
      scrollIntValue = 6;
    else {
      scrollIntValue = 7;
      slideValue = 1;
    }

    // var slideValue = (scrollValue / divisor).round();
    print('scrollvalue ; $scrollValue');
    print('slidevalue ; $slideValue');
    // print('divisor: $divisor');

    // var currentSlide = allSlides.indexWhere((slide) => slide['selected']);

    setState(() {
      scrollInt = scrollIntValue;
      // allSlides[currentSlide]['selected'] = false;
      // selectedSlide = allSlides[slideValue];
      selectedSlide['selected'] = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: CustomScrollView(
        controller: widget.scrollController,
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              height: 200,
              width: double.infinity,
              // color: Colors.white,
              padding: EdgeInsets.fromLTRB(0, 100.0, 0, 0),
              child: Text(
                'Menu',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          // SliverToBoxAdapter(child: imagefit()),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                //here will be event container. using as listview
                //final Post post = posts[index];

                return imagefit2(allSlides[index]);
              },
              childCount: allSlides.length,
            ),
          ),
          // SliverList(
          //   delegate: SliverChildBuilderDelegate(
          //     (context, index) {
          //       //here will be event container. using as listview
          //       //final Post post = posts[index];
          //       print('index : ${index % 3}');
          //       return getCards(allSlides[index], index);
          //     },
          //     childCount: allSlides.length,
          //   ),
          // ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                //here will be event container. using as listview
                //final Post post = posts[index];

                return getCards2(allSlides2[index]);
              },
              childCount: allSlides2.length,
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              height: 100,
              color: Colors.grey[350],
              width: double.infinity,
              padding: EdgeInsets.fromLTRB(0, 20.0, 0, 0),
              child: Text(
                'Copyright © 2021 Trinity Inc. All rights reserved.  Privacy Policy Terms of Use | Sales and Refunds | Site Map ',
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget imagefit() {
    // var scrollValue = widget.scrollController.offset.round();

    print('scrollInt : $scrollInt');

    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      // padding: EdgeInsets.all(0 + (index + 1) * 50),
      decoration: BoxDecoration(
        color: Colors.green[100],
        // border: Border.all(width: index * 3),
        image: DecorationImage(
          scale: 0.3 + (scrollInt * 0.1),
          // fit: BoxFit.fill,
          image: AssetImage('assets/images/web_menu_1.jpeg'),
        ),
      ),
    );
  }

  Widget imagefit2(slide) {
    // var scrollValue = widget.scrollController.offset.round();

    print('scrollInt : $scrollInt');

    return scrollInt < 7
        ? Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            // padding: EdgeInsets.all(0 + (index + 1) * 50),
            decoration: BoxDecoration(
              color: Colors.green[100],
              // border: Border.all(width: index * 3),
              image: DecorationImage(
                scale: 0.3 + (scrollInt * 0.1),
                // fit: BoxFit.fill,
                // image: AssetImage('assets/images/web_menu_1.jpeg'),
                image: AssetImage(slide['widget']),
              ),
            ),
          )
        : Center(
            child: Stack(
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.green[100],
                    // border: Border.all(width: index * 3),
                    image: DecorationImage(
                      scale: 1,
                      // fit: BoxFit.fill,
                      // image: AssetImage('assets/images/web_menu_1.jpeg'),
                      image: AssetImage(slide['widget']),
                    ),
                  ),
                ),
                Container(
                    alignment: Alignment.center,
                    child: Text(
                      slide['text'],
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 22.0),
                    )),
              ],
            ),
          );
  }

  Widget getCards(slide, index) {
    return slide['selected']
        ? Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            // padding: EdgeInsets.all(0 + (index + 1) * 50),
            decoration: BoxDecoration(
              color: Colors.green[100],
              // border: Border.all(width: index * 3),
              image: DecorationImage(
                scale: 0.3 + (index * 0.1),
                image: AssetImage(
                  slide['widget'],
                  // 'assets/images/web_menu_1.jpeg'
                ),
              ),
            ),
          )
        : SizedBox.shrink();
  }

  Widget getCards2(slide) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      // padding: EdgeInsets.all(0 + (index + 1) * 50),
      decoration: BoxDecoration(
        color: Colors.yellow[100],
        // border: Border.all(width: index * 3),
        image: DecorationImage(
          scale: 1,
          image: AssetImage(
            slide['image'],
          ),
        ),
      ),
    );
  }
  // Widget getCards(slide, nextSlide) {
  //   print('slide widget :${slide['widget']}');
  //   return Padding(
  //     padding: EdgeInsets.all(0),
  //     child: AnimatedCrossFade(
  //       firstChild: Container(
  //         height: MediaQuery.of(context).size.height,
  //         width: MediaQuery.of(context).size.width * 0.7,
  //         decoration: BoxDecoration(
  //           image: DecorationImage(
  //             image: AssetImage(
  //               slide['widget'],
  //               // 'assets/images/web_menu_1.jpeg'
  //             ),
  //           ),
  //         ),
  //       ),
  //       duration: Duration(seconds: 1),
  //       secondChild: Container(
  //         height: MediaQuery.of(context).size.height,
  //         width: MediaQuery.of(context).size.width * 0.7,
  //         decoration: BoxDecoration(
  //           image: DecorationImage(
  //             image: AssetImage(
  //               nextSlide['widget'],
  //               // 'assets/images/web_menu_1.jpeg'
  //             ),
  //           ),
  //         ),
  //       ),
  //       crossFadeState: slide['selected']
  //           ? CrossFadeState.showFirst
  //           : CrossFadeState.showSecond,
  //     ),
  //   );
  // }
}
