import 'package:flutter/material.dart';
import '../widgets/widgets.dart';

class WebBusiness extends StatelessWidget {
  final TrackingScrollController _trackingScrollController =
      TrackingScrollController();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
          body: Responsive(
        mobile: _BusinessMobile(
          scrollController: _trackingScrollController,
        ),
        desktop: _BusinessDesktop(
          scrollController: _trackingScrollController,
        ),
      )),
    );
  }
}

class _BusinessMobile extends StatelessWidget {
  final TrackingScrollController scrollController;

  const _BusinessMobile({Key key, this.scrollController}) : super(key: key);
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
                  child: Text('title : Business mobile'),
                  color: Colors.yellow,
                ),
                Container(
                  height: 550,
                  width: double.infinity,
                  child: Text('content :Business Info'),
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

class _BusinessDesktop extends StatelessWidget {
  final TrackingScrollController scrollController;

  const _BusinessDesktop({Key key, this.scrollController}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
