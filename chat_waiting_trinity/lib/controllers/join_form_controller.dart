import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

enum SelectTime { nowPick, userPick, pick5pm, pick7pm }

class JoinFormController {
  static JoinFormController get instance => JoinFormController();

  bool timePassed(String pickedTime) {
    print('pickedTime :$pickedTime');
    final DateTime now = DateTime.now();
    DateTime picked;
    try {
      picked = DateFormat('yyyy/MM/dd HH:mm').parse(pickedTime);
    } catch (e) {
      picked = DateFormat('yyyy-MM-dd HH:mm').parse(pickedTime);
    }

    print('picked: $picked');

    final DateTime openHourBefore = DateFormat('Hm').parse('11:55');
    print('openhourbefore: $openHourBefore');
    final DateTime openHourAfter = DateFormat('Hm').parse('22:00');
    print('openhourafter : $openHourAfter');
    final DateTime pickedHour =
        DateFormat('Hm').parse(DateFormat('HH:mm').format(picked));

    print('pickedHour: $pickedHour');

    // final nowformatted = DateFormat('yyyy/MM/dd HH:mm').format(now);
    final earlier = now.subtract(const Duration(minutes: 5));
    // final earlierFormatted = DateFormat('yyyy/MM/dd HH:mm').format(now);
    // print(pickedTime);
    bool passed = false;
    if (earlier.isBefore(picked) &&
        openHourBefore.isBefore(pickedHour) &&
        openHourAfter.isAfter(pickedHour)) {
      passed = true;
    }

    // print(pickedTime);
    print('earllier: $earlier');
    print(passed);
    final diff = now.difference(picked);
    print(diff);

    return passed;
  }

  String roundUpTime(DateTime dt) {
    DateTime roundUpTime = dt.add(Duration(minutes: (5 - dt.minute % 5)));
    // _reserveAt = roundUpTime;

    return DateFormat('yyyy/MM/dd HH:mm').format(roundUpTime);
    // formatDate(roundUpTime, [dd, '/', mm, '/', yyyy, ' ', HH, ':' nn]);
    // return roundUpTime;
  }

  String roundUpTime2(DateTime dt) {
    DateTime roundUpTime = dt.add(Duration(minutes: (5 - dt.minute % 5)));
    // _reserveAt = roundUpTime;
    print('dt: $dt ,roundUpTime2 : $roundUpTime');
    return DateFormat('HH:mm').format(roundUpTime);
  }

  Future<String> reserveAtPicker(context) async {
    try {
      final selectedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime.now(),
          lastDate: DateTime.now().add(
            Duration(days: 100),
          ));
      final selectedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
      DateTime resultTime = DateTime(selectedDate.year, selectedDate.month,
          selectedDate.day, selectedTime.hour, selectedTime.minute);
      print(resultTime.toString());
      // _reserveAtController.text = this.roundUpTime(resultTime);
      return this.roundUpTime(resultTime);
    } catch (e) {
      print(e);
      return e;
    }
  }

  Future<String> timeAtPicker(context) async {
    try {
      // final selectedDate = await showDatePicker(
      //     context: context,
      //     initialDate: DateTime.now(),
      //     firstDate: DateTime.now(),
      //     lastDate: DateTime.now().add(
      //       Duration(days: 100),
      //     ));
      final selectedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      // = DateTime(selectedTime.hour, selectedTime.minute);
      DateTime resultTime = DateFormat('hh:mm')
          .parse('${selectedTime.hour}:${selectedTime.minute}');
      // _reserveAtController.text = this.roundUpTime(resultTime);
      return this.roundUpTime2(resultTime);
    } catch (e) {
      print(e);
      return e;
    }
  }

  // String dateOnPicker(BuildContext context) {
  //   // String pickedDate;
  //   DateTime resultTime;
  //   try {
  //     showDatePicker(
  //         context: context,
  //         initialDate: DateTime.now(),
  //         firstDate: DateTime.now().subtract(Duration(days: 100)),
  //         lastDate: DateTime.now().add(
  //           Duration(days: 100),
  //         )).then((value) {
  //       print(value is DateTime);
  //       resultTime = value;
  //       if (value is DateTime) return DateFormat('yyyy/MM/dd').format(value);
  //     });
  //   } catch (e) {
  //     print(e);
  //     return e;
  //   }

  //   print('resulttime : $resultTime');
  //   return '';
  // }

  // Future<void> dateOnPicker(BuildContext context) async {
  //   try {
  //     final selectedDate = await showDatePicker(
  //         context: context,
  //         initialDate: DateTime.now(),
  //         firstDate: DateTime.now(),
  //         lastDate: DateTime.now().add(
  //           Duration(days: 100),
  //         ));

  //     DateTime resultTime = DateTime(
  //       selectedDate.year,
  //       selectedDate.month,
  //       selectedDate.day,
  //     );

  //     return this._pickedDateToString(resultTime);
  //     //  = _roundUpTime(resultTime);
  //     // print('date: ${_dateOnController.text}');
  //   } catch (e) {
  //     print(e);
  //   }
  // }
}
