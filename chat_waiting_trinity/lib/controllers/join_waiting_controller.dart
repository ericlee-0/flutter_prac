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
    final diff = now.difference(reserveAt);

    final docRef = await FirebaseFirestore.instance
        .collection('waiting')
        .doc(DateFormat('yyyy/MM/dd').format(now))
        .get();
    // print(diff);
    final currentWaingTime = docRef.data()['currentWaitingTime'];
    if(diff.inMinutes < (currentWaingTime + 5)){
      return SelectWaitngStatus.pending.toString().split('.').last;
    }
      return SelectWaitngStatus.waiting.toString().split('.').last;
    

    
  }

  Future<void> setStatus(String docpath, String selectedStatus) async {
    // final now = DateTime.now();
    // print('joinController $reserveAt');
    // final diff = now.difference(reserveAt);
    // var selectedStatus;
    List<dynamic> status;
    try {
      final docRef = await FirebaseFirestore.instance
      .doc(docpath).get();

      status = docRef.data()['waitingStatus'];
      status.add(selectedStatus);
      await FirebaseFirestore.instance
          // .collection('waiting')
          .doc(docpath)
          .update({
        // 'waitingStatus': FieldValue.arrayUnion([selectedStatus])
        'waitingStatus':status
      });
      // print(docpath);
      // print(selectedStatus);
      // print(docRef.data());
    } catch (e) {
      print(e);
    }

    // return 'updatedstatus...';
  }
}
