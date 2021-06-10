import '../widgets/widgets.dart';
import 'package:flutter/material.dart';

class WebContact extends StatelessWidget {
  final TrackingScrollController _trackingScrollController =
      TrackingScrollController();

  @override
  void dispose() {
    // TODO: implement dispose
    _trackingScrollController.dispose();
    // super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
          body: Responsive(
        mobile: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: _ContactDesktop(
            scrollController: _trackingScrollController,
          ),
        ),
        desktop: _ContactDesktop(
          scrollController: _trackingScrollController,
        ),
      )),
    );
  }
}

class _ContactMobile extends StatelessWidget {
  final TrackingScrollController scrollController;

  const _ContactMobile({Key key, this.scrollController}) : super(key: key);
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
                  child: Text('title : Contact mobile'),
                  color: Colors.yellow,
                ),
                Container(
                  height: 550,
                  width: double.infinity,
                  child: Text('content :Contact Info'),
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

class _ContactDesktop extends StatelessWidget {
  final TrackingScrollController scrollController;

  const _ContactDesktop({Key key, this.scrollController}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: scrollController,
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 400,
                width: double.infinity,
                // color: Colors.white,
                padding: EdgeInsets.fromLTRB(0, 100.0, 0, 0),
                child: Text(
                  'Contact Support',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // decoration: BoxDecoration(
                //   color: Colors.white,
                //   border: Border(
                //     bottom: BorderSide(
                //       width: 1.0,
                //     ),
                //   ),
                // ),
              ),
              Container(
                height: 550,
                padding: EdgeInsets.fromLTRB(0, 150.0, 0, 150),
                color: Colors.grey[200],
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            'Get support by phone',
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Talk to an Advisor by calling.',
                            style: TextStyle(fontSize: 15),
                          ),
                          Text(
                            '1-800-000-0000',
                            style: TextStyle(color: Colors.blue),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            'Get support by e-mail',
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Send message via email.',
                            style: TextStyle(fontSize: 15),
                          ),
                          Text(
                            'info@smapleemail.com',
                            style: TextStyle(color: Colors.blue),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 100,
                color: Colors.grey[350],
                width: double.infinity,
                padding: EdgeInsets.fromLTRB(0, 20.0, 0, 0),
                child: Text(
                  'Copyright © 2021 Trinity Inc. All rights reserved.  Privacy Policy Terms of Use | Sales and Refunds | Site Map ',
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
