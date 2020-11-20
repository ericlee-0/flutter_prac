import 'package:cloud_firestore/cloud_firestore.dart';

class WaitingListController {

  static WaitingListController get instance => WaitingListController();

  List<QueryDocumentSnapshot> getWaitingList (List<QueryDocumentSnapshot> data){
    List<QueryDocumentSnapshot> result=[];
    data.map((e) { if( e['waitingStatus'] == 'waiting'){
      result.add(e);
    }}).toList();
    // print('id : ${result[0].id} path: ${result[0].reference.path}');
    return result;
  }
   List<QueryDocumentSnapshot> getPendingList (List<QueryDocumentSnapshot> data){
    List<QueryDocumentSnapshot> result=[];
    data.map((e) { if( e['waitingStatus'] == 'pending'){
      result.add(e);
    }}).toList();
    // print('id : ${result[0].id} path: ${result[0].reference.path}');
    return result;
  }
   List<QueryDocumentSnapshot> getCheckedInList (List<QueryDocumentSnapshot> data){
    List<QueryDocumentSnapshot> result=[];
    data.map((e) { if( e['waitingStatus'] == 'checkedIn'){
      result.add(e);
    }}).toList();
    // print('id : ${result[0].id} path: ${result[0].reference.path}');
    return result;
  }
   List<QueryDocumentSnapshot> getDoneList (List<QueryDocumentSnapshot> data){
    List<QueryDocumentSnapshot> result=[];
    data.map((e) { if( e['waitingStatus'] == 'done'){
      result.add(e);
    }}).toList();
    // print('id : ${result[0].id} path: ${result[0].reference.path}');
    return result;
  }
   List<QueryDocumentSnapshot> getActiveList (List<QueryDocumentSnapshot> data){
    List<QueryDocumentSnapshot> result=[];
    data.map((e) { if( e['waitingStatus'] != 'done' && e['waitingStatus'] !='pending'){
      result.add(e);
    }}).toList();
    // print('id : ${result[0].id} path: ${result[0].reference.path}');
    return result;
  }
}