import 'package:flutter/material.dart';

class ConfirmDialog extends StatefulWidget {
  final bool isWaiting;
  final Map<String, dynamic> answers;
  final Function(bool) doAfterConfirmFn;

  const ConfirmDialog(
      {Key key, this.isWaiting, this.answers, this.doAfterConfirmFn})
      : super(key: key);

  @override
  _ConfirmDialogState createState() => _ConfirmDialogState();
}

class _ConfirmDialogState extends State<ConfirmDialog> {
  List<bool> _isChecked = [false, false];
  bool _canUpload = false;
  // bool _confirmButtonEnabled = false;
  List<String> _textsForWaiting = [
    "We will try to get you table in a timely manner ",
    "We only accept Canadian Debit card or Canadia Cash",
  ];
  List<String> _textsForReseravation = [
    "At least 1 memeber need to check in 10 mins before in order to keep the table",
    "We only accept Canadian Debit card or Canadia Cash",
  ];
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Confirmation'),
      content: Container(
        width: 300,
        height: 450,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Column(
                  children: widget.answers.entries.map((entry) {
                var w =
                    Text(entry.key.toString() + ':' + entry.value.toString());
                // doSomething(entry.key);
                return w;
              }).toList()),
            ),
            Expanded(
              child: ListView(
                  shrinkWrap: true,
                  padding: EdgeInsets.all(8.0),
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: widget.isWaiting
                          ? _textsForWaiting.length
                          : _textsForReseravation.length,
                      itemBuilder: (_, index) {
                        return CheckboxListTile(
                          title: widget.isWaiting
                              ? Text(_textsForWaiting[index])
                              : Text(_textsForReseravation[index]),
                          value: _isChecked[index],
                          onChanged: (val) {
                            setState(() {
                              _isChecked[index] = val;
                              _canUpload = true;
                              for (var item in _isChecked) {
                                if (item == false) {
                                  _canUpload = false;
                                }
                              }
                            });
                          },
                        );
                      },
                    ),
                  ]),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        SizedBox(
            width: 350,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  // color: Colors.blue,
                  onPressed: _canUpload
                      ? () {
                          // print("upload");
                          Navigator.of(context).pop();
                          widget.doAfterConfirmFn(true);
                        }
                      : null,
                  child: _canUpload
                      ? Text('Confirm')
                      : Text('Check the conditions'),
                ),
                ElevatedButton(
                  // color: Colors.blue,
                  onPressed: () {
                    // print("back");
                    Navigator.of(context).pop();
                    widget.doAfterConfirmFn(false);
                  },

                  child: Text('Back'),
                ),
              ],
            ))
      ],
    );
  }
}

// switch (await showDialog<Department>(
//         context: context,
//         builder: (BuildContext context) {
//           return SimpleDialog(
//             title: const Text('Reservation Processing'),
//             children: <Widget>[
//               SimpleDialogOption(
//                 onPressed: () {
//                   Navigator.pop(context, Department.treasury);
//                 },
//                 child: const Text('Treasury department'),
//               ),
//               SimpleDialogOption(
//                 onPressed: () {
//                   Navigator.pop(context, Department.state);
//                 },
//                 child: const Text('State department'),
//               ),
//             ],
//           );
//         })) {
//       case Department.treasury:
//         // Let's go.
//         // ...
//         break;
//       case Department.state:
//         // ...
//         break;
//       default:
//         // dialog dismissed
//         break;
//     }
