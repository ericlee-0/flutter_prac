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

  List allMenuItiems = [
    {
      'group': 'A',
      'image': 'assets/images/400_600.png',
      'name': 'lunch',
      'description': 'lunch',
    },
    {
      'group': 'A',
      'image': 'assets/images/400_600.png',
      'name': 'dinner',
      'description': 'dinner',
    },
    {
      'group': 'D',
      'image': 'assets/images/400_600.png',
      'name': 'drinks',
      'description': 'drinks',
    },
    {
      'group': 'A',
      'image': 'assets/images/400_600.png',
      'name': 'deserts',
      'description': 'deserts',
    },
  ];

  List allSlides = [
    {'widget': 'assets/images/menu.jpeg', 'selected': false, 'text': 'Menu'},
    {
      'widget': 'assets/images/web_menu_2.jpeg',
      'selected': false,
      'text': 'Main Dishes'
    },
    {
      'widget': 'assets/images/web_menu_3.jpeg',
      'selected': false,
      'text': 'Deserts'
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
    {'image': 'assets/images/400_600.png'},
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
    var scrollIntValue = 0;

    if (scrollIntValue < 8) scrollIntValue = (scrollValue / 30).floor();
    // var slideValue = (scrollValue / divisor).round();
    print('scrollvalue ; $scrollValue');
    print('slidevalue ; $slideValue');
    // print('divisor: $divisor');

    // var currentSlide = allSlides.indexWhere((slide) => slide['selected']);

    setState(() {
      scrollInt = scrollIntValue;
      // allSlides[currentSlide]['selected'] = false;
      // selectedSlide = allSlides[slideValue];
      // selectedSlide['selected'] = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: CustomScrollView(
        controller: widget.scrollController,
        slivers: [
          SliverToBoxAdapter(child: menuTitle()),
          SliverPadding(
            padding: EdgeInsets.fromLTRB(0, 10.0, 0, 5.0),
            sliver: SliverToBoxAdapter(
              child: SlideList(item: allMenuItiems),
            ),
          ),
          // SliverToBoxAdapter(child: imagefit()),
          // SliverList(
          //   delegate: SliverChildBuilderDelegate(
          //     (context, index) {
          //       //here will be event container. using as listview
          //       //final Post post = posts[index];

          //       return menuTitle();
          //     },
          //     childCount: allSlides.length,
          //   ),
          // ),
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

  Widget menuTitle() {
    // var scrollValue = widget.scrollController.offset.round();

    print('scrollInt : $scrollInt');

    return scrollInt < 7
        ? Container(
            // height: MediaQuery.of(context).size.height,
            // width: MediaQuery.of(context).size.width >= 1200
            //     ? 1200
            //     : MediaQuery.of(context).size.width,
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                  0 + scrollInt * 20, 0, 0 + scrollInt * 20, 30),
              child: Image.asset(
                'assets/images/main_image.png',
                fit: BoxFit.fill,
              ),
            ),
          )
        : Container(
            // height: MediaQuery.of(context).size.height,
            // width: MediaQuery.of(context).size.width >= 1200
            //     ? 1200
            //     : MediaQuery.of(context).size.width,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(140, 0, 140, 30),
                  child: Image.asset(
                    'assets/images/main_image.png',
                    fit: BoxFit.fill,
                    color: Color.fromRGBO(255, 255, 255, 0.5),
                    colorBlendMode: BlendMode.modulate,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 150),
                  child: Text(
                    'Menu',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 55.0),
                  ),
                ),
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
