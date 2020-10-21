import '../apikeys.dart';

const GOOGLE_API_KEY = APIKeys.GOOGLE_API_KEY;

class LocationHelper {
  static String generateLocationPreviewImage({double latitude, double logitude}){
    return 'https://maps.googleapis.com/maps/api/staticmap?center=$latitude,$logitude&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C$latitude,$logitude&key=$GOOGLE_API_KEY';
  }
}