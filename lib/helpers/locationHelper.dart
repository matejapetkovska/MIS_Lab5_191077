const GOOGLE_API_KEY = 'AIzaSyCqMLMQVgJQxl-oUQ2FvlBJPkeSK5EfIpU';

class LocationHelper {
  static String generateLocationPrevieImage(
    double latitude,
    double longitude,
  ) {
    return "https://maps.googleapis.com/maps/api/staticmap?center=&$latitude,$longitude&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:C%7C$latitude,$longitude&key=$GOOGLE_API_KEY";
  }
}
