import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WaitingTimePage extends StatelessWidget {
  final docId = DateFormat('yyyy/MM/dd').format(DateTime.now());
  final streamId = DateFormat('yyyy/MM').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    print('docId : $docId');
    print('streamId : $streamId');
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              // decoration: BoxDecoration(color: Colors.blue[200]),
              child: Text(
            'Current Wait Time :',
            style: TextStyle(
                color: Colors.red[400],
                fontSize: 18.0,
                fontWeight: FontWeight.bold),
          )),
          const SizedBox(width: 5.0),
          StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('waiting/$streamId')
                .where('docId', isEqualTo: docId)
                .snapshots(),
            builder: (ctx, snapshot) {
              if (!snapshot.hasData ||
                  snapshot.hasError ||
                  snapshot.data.docs.length == 0) {
                return Center(child: Text(' 0 '));
              }
              // print(snapshot.data.toString());
              // print(
              // 'document: ${snapshot.data.docs[0].get('currentWaitingTime')}');
              // if()
              // print(snapshot.data.docs.length);
              return Text(
                  ' ${snapshot.data.docs[0].get('currentWaitingTime')} ');
            },
          ),
          Text(' min..'),
          // FutureBuilder(
          //   future:
          //       FirebaseFirestore.instance.collection('waiting').doc(docId).get(),
          //   builder: (ctx, snapshot) {
          //     var timeData = snapshot.data;
          //     //  print('streambuilder');
          //     print('futurebuilder: $timeData');
          //     switch (snapshot.connectionState) {
          //       case ConnectionState.waiting:
          //         return Center(
          //           child: CircularProgressIndicator(),
          //         );
          //       default:
          //         if (snapshot.hasError)
          //           return Text('Error: ${snapshot.error}');
          //         else
          //           return Center(
          //               child: Text(
          //                   'Current Waitting Time: ${timeData['currentWaitingTime']}'));
          //     }
          //   },
          // ),
        ],
      ),
    );
  }
}
