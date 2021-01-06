import 'package:chat_waiting_trinity/pages/web/widgets/profile_avatar.dart';
import 'package:flutter/material.dart';

class PostContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
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
                _PostHeader(),
                const SizedBox(height: 4.0),
                Text('event descirption- this event is blabalbaldkdkfjdleifjdlifekdjfjlslsdkjf'),
                _PostStats()
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Image.asset('assets/images/event.jpeg'),
          ),
        ],
      ),
    );
  }
}

class _PostHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ProfileAvatar(imageUrl: ''),
        const SizedBox(width: 8.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'event creator',
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
        Row(
          children:[
            // Container(
            //   padding: const EdgeInsets.all(4.0),
            //   decoration: BoxDecoration(color: Colors.blue)
            // ),
            Text('expire date : 2021')
          ]
        )
      ],
    );
  }
}