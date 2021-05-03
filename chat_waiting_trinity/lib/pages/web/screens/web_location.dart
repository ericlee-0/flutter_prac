import 'package:flutter/material.dart';
import '../widgets/widgets.dart';

class WebLocation extends StatelessWidget {
  final TrackingScrollController _trackingScrollController =
      TrackingScrollController();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
          body: Responsive(
        mobile: _LocationMobile(
          scrollController: _trackingScrollController,
        ),
        desktop: _LocationDesktop(
          scrollController: _trackingScrollController,
        ),
      )),
    );
  }
}

class _LocationMobile extends StatelessWidget {
  final TrackingScrollController scrollController;

  const _LocationMobile({Key key, this.scrollController}) : super(key: key);
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
                  child: Text('title : Location mobile'),
                  color: Colors.yellow,
                ),
                Container(
                  height: 550,
                  width: double.infinity,
                  child: Text('content :Map Info'),
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

class _LocationDesktop extends StatelessWidget {
  final TrackingScrollController scrollController;

  const _LocationDesktop({Key key, this.scrollController}) : super(key: key);
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
                  'Store Location',
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
                width: double.infinity,
                padding: EdgeInsets.fromLTRB(0, 10.0, 0, 10),
                color: Colors.grey[200],
                child: Image.asset(
                  'assets/images/store_location.png',
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
