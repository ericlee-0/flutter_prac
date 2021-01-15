import 'package:flutter/material.dart';

class WebChatDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: 400.0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'web chat',
                  style: TextStyle(
                      fontSize: 18.0,
                      // fontWeight: FontWeight,
                      color: Colors.grey),
                ),
              ),
              Icon(Icons.chat_bubble, color: Colors.grey),
              const SizedBox(width:8.0),
              Icon(Icons.more_horiz, color:Colors.grey),

            ],
          ),
          // RaisedButton(onPressed: ()=>print('chat')),
          SizedBox(height:150),
          RaisedButton(
            onPressed: ()=>print('chat with agent'),
            textColor: Colors.white,
            padding: const EdgeInsets.all(0.0),
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: <Color>[
                    Color(0xFF0D47A1),
                    Color(0xFF1976D2),
                    Color(0xFF42A5F5),
                  ],
                ),
              ),
              padding: const EdgeInsets.all(10.0),
              child:
                  const Text('Chat with Agent', style: TextStyle(fontSize: 20)),
            ),
          ),
          // Expanded(child: ListView.builder(),)
        ],
      ),
    );
  }
}