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
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
            // decoration: BoxDecoration(color: Colors.blue[200]),
            child: Text(
          'Wait Time :',
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
          // stream: JoinWaitingController.instance.getCurrentWaitingTime(),
          builder: (ctx, snapshot) {
            if (!snapshot.hasData ||
                snapshot.hasError ||
                snapshot.data.docs.length == 0) {
              FirebaseFirestore.instance
                  .collection('waiting')
                  .doc(docId)
                  .set({'currentWaitingTime': 0, 'docId': docId});
              return Center(child: Text(' 0 '));
            }
            // print(snapshot.data['docId']);
            // print(snapshot.data.data().length);
            // print(snapshot.data.exists);
            // print(snapshot.data.data()['currentWaitingTime']);
            // print(
            // 'document: ${snapshot.data.docs[0].get('currentWaitingTime')}');
            // if()
            // print(snapshot.data.docs.length);
            return Text(' ${snapshot.data.docs[0].get('currentWaitingTime')} ');
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
    );
  }
}
