import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

enum SelectWaitngStatus { pending, waiting, checkedIn, done }

class JoinWaitingController {
  static JoinWaitingController get instance => JoinWaitingController();

  String get defaultStatus {
    SelectWaitngStatus st = SelectWaitngStatus.waiting;
    return st.toString().split('.').last;
  }

  Future<String> getStatus(DateTime reserveAt) async {
    final now = DateTime.now();
    print('joinController $reserveAt');
    final diff = reserveAt.difference(now);

    final docRef = await FirebaseFirestore.instance
        .collection('waiting')
        .doc(DateFormat('yyyy/MM/dd').format(now))
        .get();
    print('get statsu diff minute${diff.inMinutes}');
    final currentWaitngTime = docRef.data()['currentWaitingTime'];
    if (diff.inMinutes < (currentWaitngTime)) {
      return SelectWaitngStatus.waiting.toString().split('.').last;
    }
    return SelectWaitngStatus.pending.toString().split('.').last;
  }

  Future<void> setStatus(String docpath, String selectedStatus) async {
    // final now = DateTime.now();
    // print('joinController $reserveAt');
    // final diff = now.difference(reserveAt);
    // var selectedStatus;
    // List<dynamic> status;
    try {
      // final docRef = await FirebaseFirestore.instance
      // .doc(docpath).get();

      // status = docRef.data()['waitingStatus'];
      // status.add(selectedStatus);
      await FirebaseFirestore.instance
          // .collection('waiting')
          .doc(docpath)
          .update({
        // 'waitingStatus': FieldValue.arrayUnion([selectedStatus])
        'waitingStatus': selectedStatus
      });
      // print(docpath);
      // print(selectedStatus);
      // print(docRef.data());
    } catch (e) {
      print(e);
    }

    // return 'updatedstatus...';
  }

  Future<void> pendingCheck(int currentWaitingTime) async {
    print('pendingCheck');
    final now = DateTime.now();
    final docId = DateFormat('yyyy/MM/dd').format(now);
    // final docRefTime =
    //     await FirebaseFirestore.instance.collection('waiting').doc(docId).get();
    final currentWaitngTime = currentWaitingTime;
    // docRefTime.data()['currentWaitingTime'];
    print('currentwaitingtime pendingch $currentWaitngTime');
    final docRef = await FirebaseFirestore.instance
        .collection('waiting')
        .doc(docId)
        .collection('list')
        .where('waitingStatus', isEqualTo: 'pending')
        .get();

    // print(docRef.docs[0]);
    docRef.docs.map((e) async {
      // print(' map e reserveAt${e['reserveAt']}');
      final DateTime rev = e['reserveAt'].toDate();
      final diff = rev.difference(now);
      if (diff.inMinutes < currentWaitngTime) {
        print(e.reference.path);
        await FirebaseFirestore.instance
            .doc(e.reference.path)
            .update({'waitingStatus': 'waiting'});
      }
    }).toList();
  }

  Future<void> pendingToWaiting(String docPath) async {
    try {
      await FirebaseFirestore.instance
          // .collection('waiting')
          .doc(docPath)
          .update({
        // 'waitingStatus': FieldValue.arrayUnion([selectedStatus])
        'waitingStatus': 'waiting'
      });
    } catch (e) {
      print(e);
    }
  }
 // get stream waiting documents and return the totla number
  int getWaitingCount() {
    final now = DateTime.now();
    final docId = DateFormat('yyyy/MM/dd').format(now);
    int count=0;
    Stream<QuerySnapshot> docSnap;
    try {
      docSnap = FirebaseFirestore.instance.collection('waiting').doc(docId).collection('list').where('waitingStatus',isEqualTo: 'waiting').snapshots();
      docSnap.map((event) { count = event.docs.length;print(event.docs.length);}).toList();
    } catch (e) {
      print(e);
    }
    return count;
  }
}
