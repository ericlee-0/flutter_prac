import 'package:flutter/material.dart';

class EventList extends StatelessWidget {
  final List<dynamic> item;

  const EventList({Key key, this.item}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.width >= 1200 ? 600 : 400,
      color: Colors.white,
      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
      child: ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
          // scrollDirection: Axis.horizontal,
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

    return Container(
      // width: MediaQuery.of(context).size.width / 2,
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      color: Colors.white,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _PostHeader(item: item),
                const SizedBox(height: 4.0),
                Text(item['detail']),
                _PostStats()
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Image.asset(item['image']),
          ),
        ],
      ),
    );
  }
}

class _PostHeader extends StatelessWidget {
  final Map<String, dynamic> item;

  const _PostHeader({Key key, this.item}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 23.0,
          backgroundColor: Colors.blue[200],
          child: Text(item['type']),
        ),
        const SizedBox(width: 8.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item['creator'],
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  Text('event time '),
                  Icon(
                    Icons.public,
                    color: Colors.grey,
                    size: 12.0,
                  )
                ],
              ),
            ],
          ),
        ),
        IconButton(
            icon: const Icon(Icons.more_horiz),
            onPressed: () => print('event detail'))
      ],
    );
  }
}

class _PostStats extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(children: [
          // Container(
          //   padding: const EdgeInsets.all(4.0),
          //   decoration: BoxDecoration(color: Colors.blue)
          // ),
          Text('expire date : 2021')
        ])
      ],
    );
  }
}
