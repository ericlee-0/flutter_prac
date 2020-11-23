import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WaitingTimePage extends StatelessWidget {
  final docId = DateFormat('yyyy/MM/dd').format(DateTime.now());
  final streamId = DateFormat('yyyy/MM').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    print(docId);
    return Column(
      children: [
        StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('waiting/$streamId')
              .where('docId', isEqualTo: docId)
              .snapshots(),
          builder: (ctx, snapshot) {
            print(snapshot.data.documents);
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasError)
              return Text('Error: ${snapshot.error}');

            if(snapshot.data.documents.length == 0){
              print('no data');
              return Center(
                  child: Text(
                      'Current Waitting Time null: 0'));
            }
            
            final docdata = snapshot.data.documents;
            print(docdata.length);
            
            
              return Center(
                  child: Text(
                      'Current Waitting Time: ${docdata[0]['currentWaitingTime']}'));
            // return Text(snapshot.data.documents[0]['currentWaitingTime']);
          },
        ),
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
