import 'package:twilio_flutter/twilio_flutter.dart';

class SmsController {
  static SmsController get instance => SmsController();
  
  // TwilioFlutter twilioFlutter;

  final TwilioFlutter twilioFlutter = TwilioFlutter(
        accountSid: 'AC5dccfa54221ea13e4a503bf6caf397fb',
        authToken: '0dbb78b5da7142e85283401345505a9f',
        twilioNumber: '+15005550006');


  void sendSms(String phone, String message) async {
    twilioFlutter.sendSMS(
        // toNumber: '+16478587567', messageBody: 'hello world');
        toNumber: phone, messageBody: message);
  }

  void getSms() async {
    var data = await twilioFlutter.getSmsList();
    print(data);

    await twilioFlutter.getSMS('***************************');
  }
}