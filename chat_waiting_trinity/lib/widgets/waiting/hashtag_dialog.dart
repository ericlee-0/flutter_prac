import 'package:flutter/material.dart';

class HashtagDialog extends StatefulWidget {
  final Function(List<String>) doAfterConfirmFn;

  const HashtagDialog({Key key, this.doAfterConfirmFn}) : super(key: key);

  @override
  _HashtagDialogState createState() => _HashtagDialogState();
}

class _HashtagDialogState extends State<HashtagDialog> {
  List<String> list = [
        "Cool",
        "Awesome",
        "Why",
        "No way",
        "Sick",
        "Late",
        "Too",
        "Cash",
        "Free",
        "Employee",
        "Discount",
        "Call",
        "Police",
      ],
      selected = [];
  TextEditingController tc = TextEditingController();
  // bool _canUpload = false;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Hashtags'),
      content: Container(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
                keyboardType: TextInputType.multiline,
                maxLines: null,
                controller: tc,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                    prefixIcon: selected.length < 1
                        ? null
                        : Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: Wrap(
                                spacing: 5,
                                runSpacing: 5,
                                children: selected.map((s) {
                                  return Chip(
                                      backgroundColor: Colors.blue[100],
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(7),
                                      ),
                                      label: Text(s,
                                          style: TextStyle(
                                              color: Colors.blue[900])),
                                      onDeleted: () {
                                        setState(() {
                                          selected.remove(s);
                                        });
                                      });
                                }).toList()),
                          ))),
          ),
          SizedBox(height: 10),
          Expanded(
            child: Container(
              height: 50,
              width: 300,
              child: GridView.count(
                // Create a grid with 2 columns. If you change the scrollDirection to
                // horizontal, this produces 2 rows.
                crossAxisCount: 4,
                // Generate 100 widgets that display their index in the List.
                children: List.generate(list.length, (i) {
                  return Center(
                    child: ListTile(
                      title: Text(
                        list[i],
                        style: TextStyle(color: Colors.blue[900]),
                      ),
                      onTap: () {
                        setState(() {
                          if (!selected.contains(list[i]))
                            selected.add(list[i]);
                        });
                      },
                    ),
                  );
                }),
              ),

              // ListView.builder(
              //     // shrinkWrap: true,
              //     itemCount: list.length,
              //     itemBuilder: (c, i) {
              //       return list[i].toLowerCase().contains(tc.text.toLowerCase())
              //           ? ListTile(
              //               title: Text(list[i],
              //                   style: TextStyle(color: Colors.blue[900])),
              //               onTap: () {
              //                 setState(() {
              //                   if (!selected.contains(list[i]))
              //                     selected.add(list[i]);
              //                 });
              //               })
              //           : null;
              //     }),
            ),
          )
        ]),
      ),
      actions: <Widget>[
        ElevatedButton(
          // color: Colors.blue,
          onPressed: () {
            // print("upload");
            Navigator.of(context).pop();
            widget
                .doAfterConfirmFn([...selected, ...tc.text.trim().split(',')]);
          },
          child: Text('Add'),
        ),
        ElevatedButton(
          // color: Colors.blue,
          onPressed: () {
            // print("back");
            Navigator.of(context).pop();
            // widget.doAfterConfirmFn(false);
          },

          child: Text('Back'),
        ),
      ],
    );
  }
}
