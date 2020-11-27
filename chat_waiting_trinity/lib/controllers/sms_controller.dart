// import 'package:twilio_flutter/twilio_flutter.dart';

// class SmsController {
//   static SmsController get instance => SmsController();
  
//   // TwilioFlutter twilioFlutter;

<<<<<<< HEAD
//   final TwilioFlutter twilioFlutter = TwilioFlutter(
//         accountSid: '',
//         authToken: '',
//         twilioNumber: '+15005550006');
=======
  final TwilioFlutter twilioFlutter = TwilioFlutter(
        accountSid: '',
        authToken: '',
        twilioNumber: '+15005550006');
>>>>>>> d5dfd17f3ce76658e1bfcb1255d18ca5c85b1cbc


//   void sendSms(String phone, String message) async {
//     twilioFlutter.sendSMS(
//         // toNumber: '+16478587567', messageBody: 'hello world');
//         toNumber: phone, messageBody: message);
//   }

//   void getSms() async {
//     var data = await twilioFlutter.getSmsList();
//     print(data);

<<<<<<< HEAD
//     await twilioFlutter.getSMS('***************************');
//   }
// }
=======
    await twilioFlutter.getSMS('***************************');
  }
}
>>>>>>> d5dfd17f3ce76658e1bfcb1255d18ca5c85b1cbc
