import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/experience.dart';

/// Backend API Client for Smart Dzimbabwe Traveler App.
class ApiService {
  static String baseUrl = const String.fromEnvironment(
    'API_URL',
    defaultValue: 'https://api.smartdzimbabwe.co.zw/v1',
  );

  static Map<String, String> get _headers => {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };

  // --- Experiences ---
  static Future<List<Experience>> getExperiences({String? category, String? query}) async {
    try {
      final uri = Uri.parse('$baseUrl/experiences').replace(queryParameters: {
        if (category != null && category != 'All') 'category': category,
        if (query != null && query.isNotEmpty) 'q': query,
      });
      final res = await http.get(uri, headers: _headers);
      if (res.statusCode == 200) {
        final List list = jsonDecode(res.body);
        return list.map((json) => Experience.fromJson(json)).toList();
      }
    } catch (_) {}
    return [];
  }

  static Future<Experience?> getExperienceById(String id) async {
    try {
      final res = await http.get(Uri.parse('$baseUrl/experiences/$id'), headers: _headers);
      if (res.statusCode == 200) {
        return Experience.fromJson(jsonDecode(res.body));
      }
    } catch (_) {}
    return null;
  }

  // --- Bookings & Trips ---
  static Future<bool> createBooking(Booking booking) async {
    try {
      final res = await http.post(
        Uri.parse('$baseUrl/bookings'),
        headers: _headers,
        body: jsonEncode(booking.toJson()),
      );
      return res.statusCode == 200 || res.statusCode == 201;
    } catch (_) {
      return true;
    }
  }

  static Future<List<Booking>> getUpcomingTrips() async {
    try {
      final res = await http.get(Uri.parse('$baseUrl/trips/upcoming'), headers: _headers);
      if (res.statusCode == 200) {
        final List list = jsonDecode(res.body);
        return list.map((json) => Booking.fromJson(json)).toList();
      }
    } catch (_) {}
    return [];
  }

  static Future<List<Booking>> getPastTrips() async {
    try {
      final res = await http.get(Uri.parse('$baseUrl/trips/past'), headers: _headers);
      if (res.statusCode == 200) {
        final List list = jsonDecode(res.body);
        return list.map((json) => Booking.fromJson(json)).toList();
      }
    } catch (_) {}
    return [];
  }

  // --- Notifications ---
  static Future<List<AppNotification>> getNotifications() async {
    try {
      final res = await http.get(Uri.parse('$baseUrl/notifications'), headers: _headers);
      if (res.statusCode == 200) {
        final List list = jsonDecode(res.body);
        return list.map((json) => AppNotification.fromJson(json)).toList();
      }
    } catch (_) {}
    return [];
  }
}
