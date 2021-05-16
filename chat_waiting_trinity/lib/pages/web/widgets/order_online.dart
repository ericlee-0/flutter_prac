import 'package:flutter/material.dart';

class OrderOnline extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        // height: MediaQuery.of(context).size.width >= 1200 ? 600 : 400,
        width: double.infinity,
        color: Colors.white,
        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OutlinedButton(
              child: Text('Order Delivery'),
              style: OutlinedButton.styleFrom(
                primary: Colors.white,
                backgroundColor: Colors.teal[400],
                shadowColor: Colors.red,
                elevation: 10,
              ),
              onPressed: () {
                print('Pressed');
              },
            ),
            SizedBox(
              height: 25,
            ),
            FittedBox(
              child: Row(
                children: [
                  ElevatedButton(
                      onPressed: () => print('button clicked'),
                      child: Text('Online')),
                  ElevatedButton(
                      onPressed: () => print('button clicked'),
                      child: Text('UberEat')),
                  ElevatedButton(
                      onPressed: () => print('button clicked'),
                      child: Text('DoorDash')),
                  // ElevatedButton(
                  //     onPressed: () => print('button clicked'),
                  //     child: Text('etc..')),
                ],
              ),
            )
          ],
        ));
  }
}
