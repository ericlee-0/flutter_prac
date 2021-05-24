import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'dart:async';

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
    int count = 0;
    Stream<QuerySnapshot> docSnap;
    try {
      docSnap = FirebaseFirestore.instance
          .collection('waiting')
          .doc(docId)
          .collection('list')
          .where('waitingStatus', isEqualTo: 'waiting')
          .snapshots();
      docSnap.map((event) {
        count = event.docs.length;
        print(event.docs.length);
      }).toList();
    } catch (e) {
      print(e);
    }
    return count;
  }

  Future<dynamic> makeReservation(answers) async {
    // final isValid = true
    // = docSnap.docs.length + 1;
    int _reservationNumber = 1;
    String _waitingStatus;

    final DateTime now = DateTime.now();
    // if (isValid) {
    // _formKey.currentState.save();
    // final docId = _reserveAt.substring(0,10);
    // final docId = DateFormat('yyyy/MM/dd').format(DateTime.now());
    final docId = DateFormat("yyyy/MM/dd").format(answers['Time']);
    bool isToday = true;
    if (answers['Time'].difference(now).inDays != 0) {
      isToday = false;
    }

    // final docId = '2020/11/18';
    print('makereservation docId:$docId');
    // await _showConfirmDialog();
    try {
      // setState(() {
      //   _isLoading = true;
      // });

      final docSnap = await FirebaseFirestore.instance
          .collection('waiting')
          .doc(docId)
          .collection('list')
          // .where('waitingStatus', isEqualTo: 'waiting')
          .get();
      print('docsnap length : ${docSnap.docs.length}');
      int currentWaitingTime;

      int currentWaitingTimeUpdated;
      // docSnap.docs['currentWaitingTime'];
      if (docSnap.docs.length == 0) {
        // _reservationNumber = 1;
        await FirebaseFirestore.instance
            .collection('waiting')
            .doc(docId)
            .set({'currentWaitingTime': 0, 'docId': docId});
        currentWaitingTime = 0;
        currentWaitingTimeUpdated = 0;
      } else {
        final docRef = await FirebaseFirestore.instance
            .collection('waiting')
            .doc(DateFormat('yyyy/MM/dd').format(now))
            .get();
        // print('docref length : ${docRef.data().length}');
        currentWaitingTime = docRef.data()['currentWaitingTime'];
        print('current wait time $currentWaitingTime');
        _reservationNumber = docSnap.docs.length + 1;
        var counterActive = 0;
        // var currentWaitingTime = 0;
        docSnap.docs.map((e) {
          // print(e['waitingStatus']);
          if (e['waitingStatus'] == 'waiting') {
            counterActive++;
          }
        }).toList();
        print('counteractive $counterActive');
        if (counterActive < 2) {
          currentWaitingTimeUpdated = 0;
        } else if (counterActive < 5) {
          currentWaitingTimeUpdated = 10;
        } else if (counterActive < 10) {
          currentWaitingTimeUpdated = 30;
        } else if (counterActive < 20) {
          currentWaitingTimeUpdated = 45;
        } else if (counterActive < 30) {
          currentWaitingTimeUpdated = 60;
        } else {
          currentWaitingTimeUpdated = 90;
        }
        print('current wainting updated time $currentWaitingTimeUpdated');
      }
      if (currentWaitingTime != currentWaitingTimeUpdated) {
        await FirebaseFirestore.instance
            .collection('waiting')
            .doc(docId)
            .update({'currentWaitingTime': currentWaitingTimeUpdated});
        await this.pendingCheck(currentWaitingTimeUpdated);
      }

      // if (_selectedReserveTime == SelectTime.userPick) {
      _waitingStatus = await this.getStatus(answers['Time']);
      // print('joinwaitingControllergetStatus triggerred');
      // }
      print('_waitingStatus $_waitingStatus');
      // if(_waitingStatus == null){
      //   Timer(Duration(seconds: 1), (){print('_getstatus null why');});
      // }
      final result = await FirebaseFirestore.instance
          .collection('waiting')
          .doc(docId)
          .collection('list')
          .add({
        'createdAt': now,
        'name': answers['Name'],
        'people': answers['Number'],
        'phone': answers['Phone'],
        'reserveAt': answers['Time'],
        'reservationNumber': _reservationNumber,
        'waitingStatus': _waitingStatus
      });

      print(result.path);
      if (_waitingStatus == 'pending' && isToday) {
        final diff = answers['Time'].difference(now);
        final triggerTime = diff - Duration(minutes: currentWaitingTime);
        print('trigger time $triggerTime');
        // Timer(Duration(seconds: 15, minutes: 0), () {
        Timer(triggerTime, () {
          print("Yeah, this line is printed after $triggerTime ");
          this.pendingToWaiting(result.path);
        });
      }
      // setState(() {
      //   _isLoading = false;
      //   _hasDone = true;
      // });
      //   answers.entries.map((k, v) {
      //   print(k.toString() + ':' + v.toString());
      // }).toList();
      return _reservationNumber;
    } catch (e) {
      print(e);
      return e;
      // setState(() {
      // _isLoading = false;
      // });
    }

    // print('$_name $_phone $_people $_reserveAt');
    // Timer(Duration(seconds: 15, minutes: 0), () {
    //   print("Yeah, this line is printed after 15 second");
    //   JoinWaitingController.instance.pendingCheck();
    // });
    // }
  }
}
