import 'package:flutter/material.dart';
import '../../controllers/join_waiting_controller.dart';
import 'package:intl/intl.dart';

class AddReservationPage extends StatefulWidget {
  @override
  _AddReservationPageState createState() => _AddReservationPageState();
}

enum SelectTime { nowPick, userPick, pick5pm, pick7pm }

class _AddReservationPageState extends State<AddReservationPage> {
  final _formKey = GlobalKey<FormState>();
  var _name = '';
  var _phone = '';
  var _people = '';
  DateTime _reserveAt;
  String _waitingStatus;
  List<Step> steps;
  bool toWaiting = false;
  bool isNow = false;
  var _selectedReserveTime;
  TextEditingController _reserveAtController = TextEditingController();
  TextEditingController _dateOnController = TextEditingController();
  TextEditingController _timeAtController = TextEditingController();
  int textFieldsValue = 0;

  @override
  void initState() {
    // toWaiting = false;
    steps = [
      Step(
        title: const Text('New Reservation'),
        isActive: true,
        state: StepState.complete,
        content: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              // TextFormField(
              //   decoration: InputDecoration(labelText: 'Number of Guests'),
              // ),
              // TextFormField(
              //   decoration: InputDecoration(labelText: 'Password'),
              // ),
              TextFormField(
                key: ValueKey('guest_people'),
                initialValue: '0',
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (int.parse(value) < 1) {
                    return 'Please choose number of people.';
                  } else if (int.parse(value) < 6) {
                    //need to go to waiting
                    print('toWaiting working?');
                    textFieldsValue = int.parse(value);

                    return null;
                  } else if (int.parse(value) > 20) {
                    return 'more than 10 people need to contact to the restaurant.';
                  }
                  textFieldsValue = int.parse(value);

                  return null;
                },
                decoration: InputDecoration(labelText: 'People'),
                // obscureText: true,
                onSaved: (value) {
                  _people = value;
                },
              ),
            ],
          ),
        ),
      ),
      toWaiting
          ? Step(
              isActive: false,
              state: StepState.editing,
              title: const Text('Address'),
              content: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Home Address'),
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Posde'),
                  ),
                ],
              ),
            )
          : Step(
              isActive: false,
              state: StepState.editing,
              title: const Text('Address'),
              content: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Back Address'),
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Postcode'),
                  ),
                ],
              ),
            ),
      // toWaiting
      //     ? Step(
      //         isActive: false,
      //         state: StepState.editing,
      //         title: const Text('Time at join waiting'),
      //         content: TextFormField(
      //           key: ValueKey('guest_ReserveAt'),
      //           // initialValue: DateTime.now().toString(),
      //           controller: _reserveAtController,
      //           validator: (value) {
      //             if (value.isEmpty || !_timePassed(value)) {
      //               return 'Please pick a time for the reservation.';
      //             }
      //             return null;
      //           },
      //           decoration: InputDecoration(
      //             labelText: 'reserveAt',
      //             suffixIcon: IconButton(
      //               onPressed: () => _reserveAtController.clear(),
      //               icon: Icon(Icons.clear),
      //             ),
      //           ),
      //           // obscureText: true,
      //           onSaved: (value) {},
      //           onTap: _showMyDialog,
      //         ),

      //       )
      //     : Step(
      //         isActive: false,
      //         state: StepState.editing,
      //         title: const Text('Time for reservation'),
      //         content: Column(
      //           children: <Widget>[
      //             TextFormField(
      //               key: ValueKey('DateOn'),
      //               // initialValue: DateTime.now().toString(),
      //               controller: _dateOnController,
      //               validator: (value) {
      //                 if (value.isEmpty || !_timePassed(value)) {
      //                   return 'Please pick a date for the reservation.';
      //                 }
      //                 return null;
      //               },
      //               decoration: InputDecoration(
      //                 labelText: 'Date On',
      //                 suffixIcon: IconButton(
      //                   onPressed: () => _dateOnController.clear(),
      //                   icon: Icon(Icons.clear),
      //                 ),
      //               ),
      //               // obscureText: true,
      //               onSaved: (value) {
      //              },
      //               onTap: _showDialogDate,
      //             ),
      //             Spacer(),
      //             TextFormField(
      //               key: ValueKey('TimeAt'),
      //               // initialValue: DateTime.now().toString(),
      //               controller: _timeAtController,
      //               validator: (value) {
      //                 if (value.isEmpty || !_timePassed(value)) {
      //                   return 'Please pick a time for the reservation.';
      //                 }
      //                 return null;
      //               },
      //               decoration: InputDecoration(
      //                 labelText: 'Time At',
      //                 suffixIcon: IconButton(
      //                   onPressed: () => _timeAtController.clear(),
      //                   icon: Icon(Icons.clear),
      //                 ),
      //               ),
      //               // obscureText: true,
      //               onSaved: (value) {
      //               },
      //               onTap: _showDialogTime,
      //             ),
      //             Spacer(),
      //           ],
      //         ),
      //       ),
      Step(
        state: StepState.error,
        title: const Text('Avatar'),
        subtitle: const Text("Error!"),
        content: Column(
          children: <Widget>[
            CircleAvatar(
              backgroundColor: Colors.red,
            )
          ],
        ),
      ),
    ];
    super.initState();
  }

  int currentStep = 0;
  bool complete = false;

  next() {
    final isValid = _formKey.currentState.validate();
    print('people" $textFieldsValue');
    if (textFieldsValue < 6) {
      setState(() {
        toWaiting = true;
      });
    }
    if (isValid) {
      currentStep + 1 != steps.length
          ? goTo(currentStep + 1)
          : setState(() => complete = true);
    }
  }

  cancel() {
    if (currentStep > 0) {
      goTo(currentStep - 1);
    }
  }

  goTo(int step) {
    setState(() => currentStep = step);
  }

  String _roundUpTime(DateTime dt) {
    DateTime roundUpTime = dt.add(Duration(minutes: (5 - dt.minute % 5)));
    _reserveAt = roundUpTime;

    return DateFormat('yyyy/MM/dd HH:mm').format(roundUpTime);
  }

  bool _timePassed(String pickedTime) {
    final DateTime now = DateTime.now();
    final DateTime picked = DateFormat('yyyy/MM/dd HH:mm').parse(pickedTime);
    print('picked: $picked');
    // final nowformatted = DateFormat('yyyy/MM/dd HH:mm').format(now);
    final earlier = now.subtract(const Duration(minutes: 5));
    // final earlierFormatted = DateFormat('yyyy/MM/dd HH:mm').format(now);
    // print(pickedTime);
    final passed = earlier.isBefore(picked);
    // print(pickedTime);
    print('earllier: $earlier');
    print(passed);
    final diff = now.difference(picked);
    print(diff);

    return passed;
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Choose Reservation Time',
            textAlign: TextAlign.center,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                child: Text('Now'),
                onPressed: () {
                  setState(() {
                    _selectedReserveTime = SelectTime.nowPick;
                    _waitingStatus =
                        JoinWaitingController.instance.defaultStatus;
                  });
                  print(_selectedReserveTime);

                  // setState(() {
                  // _reserveAt = DateFormat('yyyy/MM/dd HH:mm').format(DateTime.now());
                  _reserveAtController.text = _roundUpTime(DateTime.now());

                  // });
                  Navigator.of(context).pop();
                },
              ),
              ElevatedButton(
                child: Text('Later'),
                onPressed: () {
                  setState(() {
                    _selectedReserveTime = SelectTime.userPick;
                  });
                  print(_selectedReserveTime);

                  Navigator.of(context).pop();
                  _reserveAtPicker();
                },
              ),
              // FlatButton(
              //   child: Text('Cancel'),
              //   onPressed: () {
              //     Navigator.of(context).pop();
              //   },
              // ),
            ],
          ),
          // actions: [

          // ],
        );
      },
    );
  }

  Future<void> _reserveAtPicker() async {
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

      _reserveAtController.text = _roundUpTime(resultTime);
    } catch (e) {
      print(e);
    }
  }

  Future<void> _showDialogDate() async {
    try {
      final selectedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime.now(),
          lastDate: DateTime.now().add(
            Duration(days: 100),
          ));

      DateTime resultTime = DateTime(
        selectedDate.year,
        selectedDate.month,
        selectedDate.day,
      );

      _dateOnController.text = _roundUpTime(resultTime);
    } catch (e) {
      print(e);
    }
  }

  Future<void> _showDialogTime() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Choose Reservation Time',
            textAlign: TextAlign.center,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                child: Text('5:00 PM'),
                onPressed: () {
                  setState(() {
                    _selectedReserveTime = SelectTime.pick5pm;
                    // _waitingStatus =
                    //     JoinWaitingController.instance.defaultStatus;
                  });
                  print(_selectedReserveTime);

                  _timeAtController.text = '5:00 PM';

                  Navigator.of(context).pop();
                },
              ),
              ElevatedButton(
                child: Text('7:00 PM'),
                onPressed: () {
                  setState(() {
                    _selectedReserveTime = SelectTime.pick7pm;
                  });
                  print(_selectedReserveTime);
                  _timeAtController.text = '7:00 PM';
                  Navigator.of(context).pop();
                  // _reserveAtPicker();
                },
              ),
              // FlatButton(
              //   child: Text('Cancel'),
              //   onPressed: () {
              //     Navigator.of(context).pop();
              //   },
              // ),
            ],
          ),
          // actions: [

          // ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Add Reseravation Page'),
        ),
        body: Column(children: <Widget>[
          complete
              ? Expanded(
                  child: Center(
                    child: AlertDialog(
                      title: new Text("New Table Created"),
                      content: new Text(
                        "Tada!",
                      ),
                      actions: <Widget>[
                        new ElevatedButton(
                          child: new Text("Close"),
                          onPressed: () {
                            setState(() => complete = false);
                          },
                        ),
                      ],
                    ),
                  ),
                )
              : Expanded(
                  child: Stepper(
                    steps: steps,
                    currentStep: currentStep,
                    onStepContinue: next,
                    onStepTapped: (step) => goTo(step),
                    onStepCancel: cancel,
                  ),
                ),
        ]));
  }
}
