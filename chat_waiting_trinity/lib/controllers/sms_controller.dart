import 'package:telephony/telephony.dart';

class SmsController {
  static SmsController get instance => SmsController();

  final Telephony telephony = Telephony.instance;

  final SmsSendStatusListener listener = (SendStatus status) {
    // Handle the status
    print(status);
  };

  void sendSMS(String number, String message) {
    telephony.sendSms(to: number, message: message, statusListener: listener);
  }
}

// import 'package:twilio_flutter/twilio_flutter.dart';

// class SmsController {
//   static SmsController get instance => SmsController();

//   // TwilioFlutter twilioFlutter;

//   final TwilioFlutter twilioFlutter = TwilioFlutter(
//         accountSid: '',
//         authToken: '',
//         twilioNumber: '+15005550006');

//   void sendSms(String phone, String message) async {
//     twilioFlutter.sendSMS(
//         // toNumber: '+16478587567', messageBody: 'hello world');
//         toNumber: phone, messageBody: message);
//   }

//   void getSms() async {
//     var data = await twilioFlutter.getSmsList();
//     print(data);

//     await twilioFlutter.getSMS('***************************');
//   }
// }
