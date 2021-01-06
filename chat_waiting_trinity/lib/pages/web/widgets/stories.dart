import 'package:flutter/material.dart';

class Stories extends StatelessWidget {
  final Widget item;

  const Stories({Key key, this.item}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      color: Colors.white,
      child: ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
          scrollDirection: Axis.horizontal,
          itemCount: 5,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: _StoryCard(item: item),
            );
          }),
    );
  }
}

class _StoryCard extends StatelessWidget {
  final Widget item;

  const _StoryCard({Key key, this.item}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12.0),
          child: Image.asset(
            'assets/images/food_beef.jpg',
            fit: BoxFit.cover,
            height: double.infinity,
            width: 110,
          ),
        ),
        Container(
          height: double.infinity,
          width: 110,
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
                  child: Text('M'),
                )),
          ),
        ),
        Positioned(
          bottom: 8.0,
          left: 8.0,
          right: 8.0,
          child: Text(
            'Menu Name',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
