import 'package:flutter/material.dart';

class SlideList extends StatelessWidget {
  final List<dynamic> item;

  const SlideList({Key key, this.item}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.width >= 1200 ? 600 : 400,
      width: MediaQuery.of(context).size.width >= 1200 ? 400 : 270,
      alignment: Alignment.center,
      color: Colors.black,
      padding: MediaQuery.of(context).size.width >= 1200
          ? EdgeInsets.fromLTRB(150, 10, 150, 10)
          : EdgeInsets.fromLTRB(10, 10, 10, 10),
      child: ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
          scrollDirection: Axis.horizontal,
          itemCount: item.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: _Card(item: item[index]),
            );
          }),
    );
  }
}

class _Card extends StatelessWidget {
  final Map<String, dynamic> item;

  const _Card({Key key, this.item}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final cardWidth = MediaQuery.of(context).size.width >= 1200 ? 330.0 : 200.0;

    return Stack(
      children: [
        Image.asset(
          item['image'],
          fit: BoxFit.cover,
          height: double.infinity,
          width: cardWidth,
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(12.0),
          child: Image.asset(
            item['image'],
            fit: BoxFit.cover,
            height: double.infinity,
            width: cardWidth,
          ),
        ),
        Container(
          height: double.infinity,
          width: cardWidth,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(12.0)),
        ),
        Positioned(
          top: 8.0,
          left: 8.0,
          child: Container(
            height: 40.0,
            width: 40,
            decoration:
                BoxDecoration(color: Colors.white, shape: BoxShape.circle),
            child: CircleAvatar(
                radius: 25,
                backgroundColor: Colors.blue,
                child: CircleAvatar(
                  radius: 23.0,
                  backgroundColor: Colors.grey[200],
                  child: Text(item['group']),
                )),
          ),
        ),
        Positioned(
          bottom: 8.0,
          left: 8.0,
          right: 8.0,
          child: Text(
            item['name'],
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
