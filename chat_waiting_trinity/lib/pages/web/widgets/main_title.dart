import 'package:flutter/material.dart';

class MainTitle extends StatelessWidget {
  final scrollInt;

  const MainTitle({Key key, this.scrollInt}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(child: imageShift(scrollInt));
  }
}

Widget imageShift(scrollInt) {
  // var scrollValue = widget.scrollController.offset.round();

  print('scrollInt : $scrollInt');

  return scrollInt < 7
      ? Container(
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
                  'Gyubee',
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
