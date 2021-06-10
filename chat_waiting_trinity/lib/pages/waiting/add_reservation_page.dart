import 'package:chat_waiting_trinity/widgets/waiting/cancel_dialog.dart';
import 'package:chat_waiting_trinity/widgets/waiting/confirm_dialog.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../controllers/join_form_controller.dart';
import '../../controllers/join_waiting_controller.dart';

class AddReservationPage extends StatefulWidget {
  final Function closeReservationFn;
  final String userId;

  const AddReservationPage({Key key, this.closeReservationFn, this.userId})
      : super(key: key);
  @override
  _AddReservationPageState createState() => _AddReservationPageState();
}

// List<dynamic> answer = [0, 0, 0, 0];
Map<String, dynamic> answers = {
  'Number': 0,
  'Time': DateTime.now(),
  'Name': '',
  'Phone': '',
  // 'isWaiting': true,
};
List<GlobalKey<FormState>> formKeys = [
  GlobalKey<FormState>(),
  GlobalKey<FormState>(),
  GlobalKey<FormState>(),
];

class _AddReservationPageState extends State<AddReservationPage> {
  int _currentStep;
  var _selectedReserveTime;
  // String _waitingStatus;
  bool _isWaiting;
  bool _isLoading;
  var _reservationNumber;
  bool _hasDone;
  final TextEditingController _reserveAtController = TextEditingController();
  final TextEditingController _dateOnController = TextEditingController();
  final TextEditingController _timeAtController = TextEditingController();

  Map<int, List<TextFormField>> step1Index = {};
  List<TextFormField> step1;
  List<TextFormField> step1_1;
  // List<TextFormField> step3;

  List<TextFormField> step0;
  List<TextFormField> step3;

  @override
  void initState() {
    super.initState();

    step1Index = {
      0: [
        TextFormField(
          key: ValueKey('guest_ReserveAt'),
          // initialValue: DateTime.now().toString(),
          controller: _reserveAtController,
          validator: (value) {
            if (value.isEmpty) return 'Please pick a time for the reservation.';
            if (!JoinFormController.instance.timePassed(value)) {
              return 'Please pick a time properly';
            }

            return null;
          },
          decoration: InputDecoration(
            labelText: 'reserveAt',
            suffixIcon: IconButton(
              onPressed: () => _reserveAtController.clear(),
              icon: Icon(Icons.clear),
            ),
          ),
          // obscureText: true,
          onSaved: (value) {},
          onTap: _showMyDialog,
        ),
      ],
      1: [
        TextFormField(
          key: ValueKey('DateOn'),
          // initialValue: DateTime.now().toString(),
          controller: _dateOnController,
          validator: (value) {
            if (value.isEmpty) {
              return 'Please pick a date for the reservation.';
            }

            return null;
          },
          decoration: InputDecoration(
            labelText: 'Date On',
            suffixIcon: IconButton(
              onPressed: () => _dateOnController.clear(),
              icon: Icon(Icons.clear),
            ),
          ),
          // obscureText: true,
          onSaved: (value) {},
          onTap: _showDialogDate,
        ),
        TextFormField(
          key: ValueKey('TimeAt'),
          // initialValue: DateTime.now().toString(),
          controller: _timeAtController,
          validator: (value) {
            if (value.isEmpty) {
              return 'Please pick a time for the reservation.';
            }
            if (!JoinFormController.instance
                .timePassed(answers['Time'].toString())) {
              return 'Please pick a time properly';
            }

            return null;
          },
          decoration: InputDecoration(
            labelText: 'Time At',
            suffixIcon: IconButton(
              onPressed: () => _timeAtController.clear(),
              icon: Icon(Icons.clear),
            ),
          ),
          // obscureText: true,
          onSaved: (value) {},
          onTap: _showDialogTime,
        ),
      ],
    };
    step1 = step1Index['0'];
    step1_1 = step1Index['1'];

    _currentStep = 0;

    _isWaiting = true;
    _isLoading = false;

    _hasDone = false;

    step0 = [
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

            answers['Number'] = int.parse(value);

            return null;
          } else if (int.parse(value) > 20) {
            return 'more than 10 people need to contact to the restaurant.';
          }

          answers['Number'] = int.parse(value);
          return null;
        },
        decoration: InputDecoration(labelText: 'People'),
        // obscureText: true,
        onSaved: (value) {
          // _people = value;
        },
      ),
    ];
    step3 = [
      TextFormField(
        key: ValueKey('guest_name'),
        // autocorrect: false,
        textCapitalization: TextCapitalization.words,
        enableSuggestions: false,
        validator: (value) {
          if (value.isEmpty || value.length < 2) {
            return 'Prease name at least 2 characters';
          }

          answers['Name'] = value;
          return null;
        },
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          labelText: 'Name',
        ),
        onSaved: (value) {
          // _name = value;
        },
      ),
      TextFormField(
        key: ValueKey('guest_phone'),
        keyboardType: TextInputType.phone,
        validator: (value) {
          if (value.isEmpty || value.length != 10) {
            return 'phone must be 10 digits long.';
          }

          answers['Phone'] = value;
          return null;
        },
        decoration: InputDecoration(labelText: 'phone'),
        // obscureText: true,
        onSaved: (value) {
          // _phone = '+1' + value;
        },
      ),
    ];
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext dialogContext) {
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
                  // setState(() {
                  //   _selectedReserveTime = SelectTime.nowPick;
                  //   _waitingStatus =
                  //       JoinWaitingController.instance.defaultStatus;
                  // });
                  // print(_selectedReserveTime);

                  _reserveAtController.text =
                      JoinFormController.instance.roundUpTime(DateTime.now());

                  answers['Time'] = DateFormat("yyyy/MM/dd hh:mm")
                      .parse(_reserveAtController.text);
                  // });
                  Navigator.of(context).pop();
                },
              ),
              ElevatedButton(
                child: Text('Later'),
                onPressed: () async {
                  // setState(() {
                  //   _selectedReserveTime = SelectTime.userPick;
                  // });
                  // print(_selectedReserveTime);
                  Navigator.of(dialogContext).pop();
                  _reserveAtController.text = await JoinFormController.instance
                      .reserveAtPicker(context);
                  answers['Time'] = DateFormat("yyyy/MM/dd hh:mm")
                      .parse(_reserveAtController.text);
                },
              ),
            ],
          ),
        );
      },
    );
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

      _dateOnController.text = DateFormat('yyyy/MM/dd').format(resultTime);
      //  = _roundUpTime(resultTime);
      print('date: ${_dateOnController.text}');
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
          content: _dateOnController.text == null
              ? ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Okay'))
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ElevatedButton(
                      child: Text('17:00'),
                      onPressed: () {
                        // setState(() {
                        //   _selectedReserveTime = SelectTime.pick5pm;

                        // });
                        // print(_selectedReserveTime);

                        answers['Time'] = DateFormat('yyyy/MM/dd hh:mm')
                            .parse(_dateOnController.text + ' 17:00');
                        _timeAtController.text = ' 17:00 ';
                        _isWaiting = false;
                        Navigator.of(context).pop();
                      },
                    ),
                    ElevatedButton(
                      child: Text('19:00'),
                      onPressed: () {
                        // setState(() {
                        //   _selectedReserveTime = SelectTime.pick7pm;
                        // });
                        // print(_selectedReserveTime);
                        answers['Time'] = DateFormat('yyyy/MM/dd hh:mm')
                            .parse(_dateOnController.text + ' 19:00');
                        _timeAtController.text = '19:00';
                        _isWaiting = false;
                        Navigator.of(context).pop();
                        // _reserveAtPicker();
                      },
                    ),
                    ElevatedButton(
                      child: Text('Other Time to Join Waiting List'),
                      onPressed: () {
                        setState(() {
                          _selectedReserveTime = SelectTime.userPick;
                        });
                        _isWaiting = true;
                        print(_selectedReserveTime);

                        Navigator.of(context).pop();
                        JoinFormController.instance
                            .timeAtPicker(context)
                            .then((String result) {
                          String temp = _dateOnController.text + ' ' + result;
                          print('temp: $temp');
                          answers['Time'] = DateFormat(
                            'yyyy/MM/dd HH:mm',
                          ).parse(temp);

                          _timeAtController.text = result;

                          print('answerTime :${answers['Time']}');
                        });
                      },
                    ),
                  ],
                ),
        );
      },
    );
  }

  Future<void> _checkDualReservation() async {
    print('checkdualreservationFn process..');
    print('user id : ${widget.userId}');
    var result = await JoinWaitingController.instance
        .searchListById(widget.userId, answers['Time']);
    if (widget.userId == 'M0clGRrBRMQSfQykuyA72WwHLgG2')
      return _callConfirm(); //advisor can dual book

    return result == null
        ? _callConfirm()
        : result.length == 0
            ? _callConfirm()
            : showDialog<void>(
                context: context,
                barrierDismissible: true, // user must tap button!
                builder: (BuildContext context) {
                  return CancelDialog(
                    result: result,
                    doAfterConfirmFn: (bool result) {
                      if (result) {
                        _callConfirm();
                      }
                    },
                  );
                });
  }

  Future<void> _callConfirm() async {
    return showDialog<void>(
        context: context,
        barrierDismissible: true, // user must tap button!
        builder: (BuildContext context) {
          return ConfirmDialog(
            answers: answers,
            isWaiting: _isWaiting,
            doAfterConfirmFn: (bool result) {
              if (result) {
                setState(() {
                  _isLoading = true;
                });
                _makeReseravtion();
              }
            },
          );
        });
  }

  // afterConfirm() {}

  Future<void> _makeReseravtion() async {
    print('makeReservationFN run...');
    _reservationNumber = await JoinWaitingController.instance
        .makeReservation(answers, widget.userId);

    print(
      'Reservation Number : $_reservationNumber',
    );
    if (_reservationNumber is int) {
      setState(() {
        _isLoading = false;
        _hasDone = true;
      });
    } else
      setState(() {
        _isLoading = false;
      });
  }

  Widget _finished() {
    //

    return Center(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Reservation Number : $_reservationNumber',
          ),
          Row(children: [
            MediaQuery.of(context).size.width < 900
                ? SizedBox.shrink()
                : ElevatedButton(
                    child: Text('Close'),
                    onPressed: () {
                      // Navigator.of(context).pushNamed('/home');
                      widget.closeReservationFn();
                    },
                  ),
            Spacer(),
            ElevatedButton(
              child: Text('Create New One'),
              onPressed: () {
                // Navigator.of(context).pushNamed('/home');
                formKeys.forEach((element) {
                  element.currentState?.reset();
                });
                setState(() {
                  _currentStep = 0;
                  _isWaiting = true;
                  _isLoading = false;
                  _hasDone = false;
                });

                // _formKeyScreen2.currentState?.reset();
                // widget.closeReservationFn();
              },
            )
          ]),
        ],
      ),
    ));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _reserveAtController.dispose();
    _dateOnController.dispose();
    _timeAtController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(), // on tap -> unfocus
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.grey),
          backgroundColor: Colors.white,
          elevation: 2,
          title: Text("Reservation".toUpperCase(),
              style: TextStyle(
                color: Colors.grey[700],
                fontSize: 17,
              )),
        ),
        body: _isLoading
            ? Center(child: CircularProgressIndicator())
            : _hasDone
                ? _finished()
                : Theme(
                    data: ThemeData(primaryColor: Colors.indigoAccent),
                    child: StatefulBuilder(
                        builder: (BuildContext context, StateSetter setState) {
                      return Stepper(
                        type: StepperType.vertical,
                        currentStep: _currentStep,
                        onStepTapped: (int step) =>
                            setState(() => _currentStep = step),
                        onStepContinue: _currentStep < 2
                            ? () => setState(() => _currentStep += 1)
                            : () {
                                // _showConfirmDialog();
                                // _confirmTest();
                                _checkDualReservation();
                                // _callConfirm();
                              },
                        onStepCancel: _currentStep > 0
                            ? () => setState(() => _currentStep -= 1)
                            : null,
                        controlsBuilder: (BuildContext context,
                                {VoidCallback onStepContinue,
                                VoidCallback onStepCancel}) =>
                            Container(
                          height: 70,
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              _currentStep == 0
                                  ? Text("")
                                  : ElevatedButton(
                                      onPressed: onStepCancel,
                                      //  color:Colors.grey,
                                      // textTheme: ButtonTextTheme.normal,
                                      child: Row(children: <Widget>[
                                        const Icon(Icons.chevron_left),
                                        Text("PREV")
                                      ]),
                                    ),
                              ElevatedButton(
                                onPressed: () {
                                  bool isValid = formKeys[_currentStep]
                                      .currentState
                                      .validate();
                                  print('current step : $_currentStep');
                                  if (isValid) onStepContinue();
                                },
                                // textColor: Colors.white,
                                // color: Colors.indigoAccent,
                                // textTheme: ButtonTextTheme.normal,
                                child: Row(children: <Widget>[
                                  _currentStep >= 2
                                      ? Icon(Icons.done)
                                      : Icon(Icons.chevron_right),
                                  _currentStep >= 2
                                      ? Text("DONE")
                                      : Text("NEXT")
                                ]),
                              ),
                            ],
                          ),
                        ),
                        steps: <Step>[
                          Step(
                            title: Text(
                              "Guests",
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.grey[600],
                              ),
                            ),
                            content: Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8.0, bottom: 10),
                                      child: Text(
                                        "How many guests?:",
                                        style: TextStyle(
                                          fontSize: 17,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SelectableCard(options: step0, step: 0),
                                // ...step0,
                              ],
                            ),
                            isActive: _currentStep >= 0,
                            state: _currentStep >= 0
                                ? StepState.complete
                                : StepState.disabled,
                          ),
                          Step(
                            title: Text(
                              "Time",
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.grey[600],
                              ),
                            ),
                            content: Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8.0, bottom: 10),
                                      child: Text(
                                        "Reserve At?",
                                        style: TextStyle(
                                          fontSize: 17,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SelectableCard(
                                    options: choiceNextStep(), step: 1)
                                // ...choiceNextStep()
                              ],
                            ),
                            isActive: _currentStep >= 1,
                            state: _currentStep >= 1
                                ? StepState.complete
                                : StepState.disabled,
                          ),
                          Step(
                            title: Text(
                              "Guest Info",
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.grey[600],
                              ),
                            ),
                            content: SelectableCard(options: step3, step: 2),
                            // content: step3[0],
                            isActive: _currentStep >= 2,
                            state: _currentStep >= 3
                                ? StepState.complete
                                : StepState.disabled,
                          ),
                        ],
                      );
                    }),
                  ),
      ),
    );
  }

  List<TextFormField> choiceNextStep() {
    if (answers['Number'] < 6) return step1Index[0];

    return step1Index[1];
  }
}

class SelectableCard extends StatelessWidget {
  final List<TextFormField> options;
  final int step;
  SelectableCard({@required this.options, @required this.step});

  @override
  Widget build(BuildContext context) {
    return Form(
        key: formKeys[step],
        child: Column(
          children: [...options],
        ));
  }
}
