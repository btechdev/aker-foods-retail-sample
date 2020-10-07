import 'package:flutter_segment/flutter_segment.dart';

class AnalyticsUtil {
  static void trackEvent({String eventName, Map<String, dynamic> properties}) {
    Segment.track(eventName: eventName, properties: properties);
  }

  static void trackScreen(
      {String screenName, Map<String, dynamic> properties}) {
    Segment.screen(screenName: screenName, properties: properties);
  }
}
