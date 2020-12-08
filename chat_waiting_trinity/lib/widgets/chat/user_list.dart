import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../pages/chat/user_profile_page.dart';

class UserList extends StatelessWidget {
  final String userId;
  final Future<QuerySnapshot> listData;
  UserList({this.userId, this.listData,Key key}): super(key:key);
  //  Future<Map<String,dynamic>> _getMyData() async {
  //    final docRef = await FirebaseFirestore.instance.collection('users').doc(userId).get();
  //    return docRef.data();
  // }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        // future: FirebaseFirestore.instance
        //     .collection('users')
        //     // .where('username',isEqualTo:'guest')
        //     .orderBy('username', descending: true)
        //     .get(),
        future: listData,
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final userData = snapshot.data.documents;
          var myData;
          var othersData = [];
          userData.map((e) {
            if (e.documentID == userId) {
              myData = e;
            } else
              othersData.add(e);
          }).toList();
          print('mydata $myData');

          // print('streambuilder: ${userData.length}');
          return 
        
          Column(
            //  mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(myData['image_url']),
                radius: 45,
              ),
              Padding(
                padding: const EdgeInsets.all(28.0),
                child: Text(
                  myData['username'],
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: 
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: userData.length,
                  itemBuilder: (ctx, index) => Padding(
                    padding: const EdgeInsets.all(28.0),
                    child: ListTile(
                      // title:Text('User ${userData[index].documentID}'),
                      key: ValueKey(userData[index].documentID),
                      title: Text(userData[index]['username']),
                      leading: CircleAvatar(
                        backgroundImage:
                            NetworkImage(userData[index]['image_url']),
                        radius: 25,
                      ),
                      onTap: () {
                        Navigator.pushNamed(context, UserProfilePage.routeName,
                            arguments: {
                              'chatUserId': userData[index].documentID,
                              'chatUserName': userData[index]['username'],
                              'chatUserImageUrl': userData[index]['image_url'],
                            });
                        print(userData[index].documentID);
                      },
                    ),
                  ),
                ),
              ),
            ],
          
          );
        });
  }
}
