import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class WaitingList extends StatelessWidget {
  // static final routeName = '/waiting-list';
  @override
  Widget build(BuildContext context) {
    return  StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('waiting').doc('20201114').collection('list')
              // .orderBy('forWhen', descending: true)
              .snapshots(),
          builder: (ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            final waitingData = snapshot.data.documents;
            print('streambuilder: ${waitingData.length}');
            return SingleChildScrollView(
              child: SizedBox(
                // height: 500,
                child: Column(
                  children: [
                    // ListTile(title: Text('Current waiting ')),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: waitingData.length,
                      itemBuilder: (ctx, index) => ListTile(
                        // title:Text('User ${userData[index].documentID}'),
                        key: ValueKey(waitingData[index].documentID.toString()),
                        title: Text(waitingData[index]['name']),
                        leading: CircleAvatar(
                          child: Text(waitingData[index]['people'].toString()),
                          radius: 25,
                        ),
                        onTap: () {
                          
                          print(waitingData[index].documentID);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
    );
  }
}
