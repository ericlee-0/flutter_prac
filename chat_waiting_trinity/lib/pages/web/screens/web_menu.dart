import 'package:flutter/material.dart';
import '../widgets/widgets.dart';

class WebMenu extends StatefulWidget {
  @override
  _WebMenuState createState() => _WebMenuState();
}

class _WebMenuState extends State<WebMenu> {
  final TrackingScrollController _trackingScrollController =
      TrackingScrollController();

  List _appitazers = [
    {
      'group': 'A',
      'image': 'assets/images/food_beef.jpg',
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
  List _dishes = [
    {
      'group': 'A',
      'image': 'assets/images/400_600.png',
      'name': 'lunch',
      'description': 'lunch',
    },
    {
      'group': 'A',
      'image': 'assets/images/food_beef.jpg',
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
  List _desserts = [
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
      'image': 'assets/images/food_beef.jpg',
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
  List _drinks = [
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
      'image': 'assets/images/food_beef.jpg',
      'name': 'deserts',
      'description': 'deserts',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
          body: Responsive(
        mobile: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: _MenuDesktop(
            scrollController: _trackingScrollController,
            appitizers: _appitazers,
            dishes: _dishes,
            desserts: _desserts,
            drinks: _drinks,
          ),
        ),
        desktop: _MenuDesktop(
          scrollController: _trackingScrollController,
          appitizers: _appitazers,
          dishes: _dishes,
          desserts: _desserts,
          drinks: _drinks,
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

class _MenuDesktop extends StatelessWidget {
  final TrackingScrollController scrollController;
  final List appitizers;
  final List dishes;
  final List desserts;
  final List drinks;

  const _MenuDesktop(
      {Key key,
      this.scrollController,
      this.appitizers,
      this.dishes,
      this.desserts,
      this.drinks})
      : super(key: key);

  // @override
  // void initState() {
  //   super.initState();
  //   // _scrollController = ScrollController();
  //   widget.scrollController.addListener(changeSelector);

  //   setState(() {
  //     scrollInt = 0;
  //     selectedSlide = allSlides[0];
  //     selectedSlide['selected'] = true;
  //   });
  // }

  // changeSelector() {
  //   // var maxScrollVal = _scrollController.position.maxScrollExtent;

  //   // var divisor = (maxScrollVal / allSlides.length) + 25;
  //   // var divisor = 65;

  //   var scrollValue = widget.scrollController.offset.round();
  //   var slideValue = 0;
  //   var scrollIntValue = 0;

  //   if (scrollIntValue < 8) scrollIntValue = (scrollValue / 30).floor();
  //   // var slideValue = (scrollValue / divisor).round();
  //   print('scrollvalue ; $scrollValue');
  //   print('slidevalue ; $slideValue');
  //   // print('divisor: $divisor');

  //   // var currentSlide = allSlides.indexWhere((slide) => slide['selected']);

  //   setState(() {
  //     scrollInt = scrollIntValue;
  //     // allSlides[currentSlide]['selected'] = false;
  //     // selectedSlide = allSlides[slideValue];
  //     // selectedSlide['selected'] = true;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: Container(
        color: Colors.black,
        child: CustomScrollView(
          controller: scrollController,
          slivers: [
            SliverToBoxAdapter(
              child: MediaQuery.of(context).size.width < 900
                  ? Image.asset(
                      'assets/images/main_image_mobile.png',
                      fit: BoxFit.fill,
                    )
                  : Image.asset(
                      'assets/images/main_image.png',
                      fit: BoxFit.fill,
                    ),
            ),
            SliverPadding(
              padding: EdgeInsets.fromLTRB(10, 10.0, 0, 5.0),
              sliver: SliverToBoxAdapter(
                child: Text(
                  'Appitaizers',
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.amber[900]),
                ),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.fromLTRB(0, 10.0, 0, 5.0),
              sliver: SliverToBoxAdapter(
                child: SlideList(item: appitizers),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.fromLTRB(10, 10.0, 0, 5.0),
              sliver: SliverToBoxAdapter(
                child: Text(
                  'Main Dishes',
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.amber[900]),
                ),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.fromLTRB(0, 10.0, 0, 5.0),
              sliver: SliverToBoxAdapter(
                child: SlideList(item: dishes),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.fromLTRB(10, 10.0, 0, 5.0),
              sliver: SliverToBoxAdapter(
                child: Text(
                  'Desserts',
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.amber[900]),
                ),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.fromLTRB(0, 10.0, 0, 5.0),
              sliver: SliverToBoxAdapter(
                child: SlideList(item: desserts),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.fromLTRB(10, 10.0, 0, 5.0),
              sliver: SliverToBoxAdapter(
                child: Text(
                  'Dringks',
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.amber[900]),
                ),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.fromLTRB(0, 10.0, 0, 5.0),
              sliver: SliverToBoxAdapter(
                child: SlideList(item: drinks),
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
      ),
    );
  }

  // Widget imagefit() {
  //   // var scrollValue = widget.scrollController.offset.round();

  //   print('scrollInt : $scrollInt');

  //   return Container(
  //     height: MediaQuery.of(context).size.height,
  //     width: MediaQuery.of(context).size.width,
  //     // padding: EdgeInsets.all(0 + (index + 1) * 50),
  //     decoration: BoxDecoration(
  //       color: Colors.green[100],
  //       // border: Border.all(width: index * 3),
  //       image: DecorationImage(
  //         scale: 0.3 + (scrollInt * 0.1),
  //         // fit: BoxFit.fill,
  //         image: AssetImage('assets/images/web_menu_1.jpeg'),
  //       ),
  //     ),
  //   );
  // }

  // Widget menuTitle() {
  //   // var scrollValue = widget.scrollController.offset.round();

  //   print('scrollInt : $scrollInt');

  //   return scrollInt < 7
  //       ? Container(
  //           // height: MediaQuery.of(context).size.height,
  //           // width: MediaQuery.of(context).size.width >= 1200
  //           //     ? 1200
  //           //     : MediaQuery.of(context).size.width,
  //           child: Padding(
  //             padding: EdgeInsets.fromLTRB(
  //                 0 + scrollInt * 20, 0, 0 + scrollInt * 20, 30),
  //             child: Image.asset(
  //               'assets/images/main_image.png',
  //               fit: BoxFit.fill,
  //             ),
  //           ),
  //         )
  //       : Container(
  //           // height: MediaQuery.of(context).size.height,
  //           // width: MediaQuery.of(context).size.width >= 1200
  //           //     ? 1200
  //           //     : MediaQuery.of(context).size.width,
  //           child: Stack(
  //             alignment: Alignment.bottomCenter,
  //             children: <Widget>[
  //               Padding(
  //                 padding: const EdgeInsets.fromLTRB(140, 0, 140, 30),
  //                 child: Image.asset(
  //                   'assets/images/main_image.png',
  //                   fit: BoxFit.fill,
  //                   color: Color.fromRGBO(255, 255, 255, 0.5),
  //                   colorBlendMode: BlendMode.modulate,
  //                 ),
  //               ),
  //               Padding(
  //                 padding: const EdgeInsets.fromLTRB(0, 0, 0, 150),
  //                 child: Text(
  //                   'Menu',
  //                   style: TextStyle(
  //                       color: Colors.white,
  //                       fontWeight: FontWeight.bold,
  //                       fontSize: 55.0),
  //                 ),
  //               ),
  //             ],
  //           ),
  //         );
  // }

  // Widget getCards(slide, index) {
  //   return slide['selected']
  //       ? Container(
  //           height: MediaQuery.of(context).size.height,
  //           width: MediaQuery.of(context).size.width,
  //           // padding: EdgeInsets.all(0 + (index + 1) * 50),
  //           decoration: BoxDecoration(
  //             color: Colors.green[100],
  //             // border: Border.all(width: index * 3),
  //             image: DecorationImage(
  //               scale: 0.3 + (index * 0.1),
  //               image: AssetImage(
  //                 slide['widget'],
  //                 // 'assets/images/web_menu_1.jpeg'
  //               ),
  //             ),
  //           ),
  //         )
  //       : SizedBox.shrink();
  // }

  // Widget getCards2(slide) {
  //   return Container(
  //     height: MediaQuery.of(context).size.height,
  //     width: MediaQuery.of(context).size.width,
  //     // padding: EdgeInsets.all(0 + (index + 1) * 50),
  //     decoration: BoxDecoration(
  //       color: Colors.yellow[100],
  //       // border: Border.all(width: index * 3),
  //       image: DecorationImage(
  //         scale: 1,
  //         image: AssetImage(
  //           slide['image'],
  //         ),
  //       ),
  //     ),
  //   );
  // }
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
