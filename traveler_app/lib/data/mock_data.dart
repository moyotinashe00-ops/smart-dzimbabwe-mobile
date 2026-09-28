import 'package:flutter/material.dart';
import '../models/experience.dart';
import '../theme/app_theme.dart';

/// Static, in-memory content standing in for the backend. Everything here
/// is designed to be swapped for real API calls later without touching the
/// screens that consume it.
class MockData {
  MockData._();

  static const categories = ['All', 'Wildlife', 'Heritage', 'Adventure', 'Culture', 'Water & Falls'];

  static final experiences = <Experience>[
    Experience(
      id: 'exp-01',
      title: 'Sunrise Hike Through the Nyanga Highlands',
      location: 'Nyanga, Manicaland',
      category: 'Adventure',
      pricePerPerson: 45,
      rating: 4.9,
      reviewCount: 128,
      operatorName: 'Highland Trails Co.',
      durationHours: 4,
      description:
          'Start before dawn and climb through misty pine forest to catch sunrise over the highlands. '
          'A local guide shares the folklore of Nyangani along the way.',
      highlights: const ['Local guide included', 'Breakfast at the summit', 'Small groups only'],
      photo: const PlaceholderPhoto([Color(0xFF2E5E43), Color(0xFF0E2A1E)], Icons.terrain_rounded),
    ),
    Experience(
      id: 'exp-02',
      title: 'Victoria Falls Township Walk',
      location: 'Victoria Falls, Matabeleland North',
      category: 'Culture',
      pricePerPerson: 25,
      rating: 4.8,
      reviewCount: 96,
      operatorName: 'Mosi-oa-Tunya Collective',
      durationHours: 3,
      description:
          'Walk the streets behind the falls with a resident host — market stalls, a curio workshop, '
          'and a shared lunch with a local family.',
      highlights: const ['Meet a local family', 'Curio workshop visit', 'Lunch included'],
      photo: const PlaceholderPhoto([Color(0xFF3E6E52), Color(0xFF0E2A1E)], Icons.storefront_rounded),
    ),
    Experience(
      id: 'exp-03',
      title: 'Lake Kariba Houseboat Sunset',
      location: 'Kariba, Mashonaland West',
      category: 'Water & Falls',
      pricePerPerson: 60,
      rating: 4.95,
      reviewCount: 214,
      operatorName: 'Zambezi Waters',
      durationHours: 3,
      description:
          'Cruise the shoreline as elephants come down to drink, then anchor for a golden-hour sunset '
          'with drinks on deck.',
      highlights: const ['Drinks & snacks on board', 'Wildlife spotting', 'Photography friendly'],
      photo: const PlaceholderPhoto([Color(0xFF1C4A63), Color(0xFF0E2A1E)], Icons.directions_boat_filled_rounded),
    ),
    Experience(
      id: 'exp-04',
      title: 'Great Zimbabwe Ruins Heritage Tour',
      location: 'Masvingo',
      category: 'Heritage',
      pricePerPerson: 30,
      rating: 4.85,
      reviewCount: 173,
      operatorName: 'Zimbabwe Heritage Trust',
      durationHours: 2,
      description:
          'Walk the Great Enclosure with a heritage-trained guide and hear the oral histories behind the '
          "kingdom that gave the country its name.",
      highlights: const ['Certified heritage guide', 'Hill Complex access', 'Small groups only'],
      photo: const PlaceholderPhoto([Color(0xFF6B5836), Color(0xFF0E2A1E)], Icons.account_balance_rounded),
    ),
    Experience(
      id: 'exp-05',
      title: 'Matobo Hills Rock Art Trail',
      location: 'Matobo, Matabeleland South',
      category: 'Wildlife',
      pricePerPerson: 55,
      rating: 4.9,
      reviewCount: 88,
      operatorName: 'Matobo Rangers',
      durationHours: 5,
      description:
          'Track rhino on foot through balancing granite boulders, then climb to a San rock-art shelter '
          'thousands of years old.',
      highlights: const ['Rhino tracking on foot', 'San rock art site', 'Ranger-led'],
      photo: const PlaceholderPhoto([Color(0xFF4C4A2E), Color(0xFF0E2A1E)], Icons.pets_rounded),
    ),
    Experience(
      id: 'exp-06',
      title: 'Harare Street Food Crawl',
      location: 'Harare CBD',
      category: 'Culture',
      pricePerPerson: 18,
      rating: 4.7,
      reviewCount: 61,
      operatorName: 'Harare Eats',
      durationHours: 3,
      description:
          'From sadza stalls to roadside braai, taste your way through Harare with a host who knows '
          'every vendor by name.',
      highlights: const ['5 tasting stops', 'Vegetarian options', 'Evening start'],
      photo: const PlaceholderPhoto([Color(0xFF7A3E2A), Color(0xFF0E2A1E)], Icons.ramen_dining_rounded),
    ),
    Experience(
      id: 'exp-07',
      title: 'Mana Pools Wild Canoe Safari',
      location: 'Mana Pools, Mashonaland West',
      category: 'Wildlife',
      pricePerPerson: 90,
      rating: 4.97,
      reviewCount: 152,
      operatorName: 'Zambezi Waters',
      durationHours: 6,
      description:
          'Paddle the Zambezi floodplain among hippo pods and elephant herds, guided by a licensed '
          'professional trails guide.',
      highlights: const ['Licensed trails guide', 'Packed lunch', 'UNESCO site'],
      photo: const PlaceholderPhoto([Color(0xFF2E5E43), Color(0xFF163A2A)], Icons.kayaking_rounded),
    ),
    Experience(
      id: 'exp-08',
      title: 'Chimanimani Mountain Trek',
      location: 'Chimanimani, Manicaland',
      category: 'Adventure',
      pricePerPerson: 40,
      rating: 4.88,
      reviewCount: 74,
      operatorName: 'Eastern Highlands Guides',
      durationHours: 8,
      description:
          'A full-day trek through waterfalls and quartzite peaks on the Mozambique border, finishing '
          'at a hidden swimming hole.',
      highlights: const ['Waterfall swim stop', 'Packed lunch', 'Moderate fitness needed'],
      photo: const PlaceholderPhoto([Color(0xFF1E4A33), Color(0xFF0E2A1E)], Icons.landscape_rounded),
    ),
  ];

  static Experience byId(String id) => experiences.firstWhere((e) => e.id == id);

  static List<Booking> upcomingTrips() => [
        Booking(
          id: 'bk-2201',
          experience: experiences[2],
          date: DateTime.now().add(const Duration(days: 6)),
          guests: 2,
          status: BookingStatus.confirmed,
          totalPaid: 120,
          reference: 'SD-88213-KRB',
        ),
        Booking(
          id: 'bk-2148',
          experience: experiences[6],
          date: DateTime.now().add(const Duration(days: 19)),
          guests: 4,
          status: BookingStatus.pending,
          totalPaid: 360,
          reference: 'SD-77190-MNP',
        ),
      ];

  static List<Booking> pastTrips() => [
        Booking(
          id: 'bk-1902',
          experience: experiences[0],
          date: DateTime.now().subtract(const Duration(days: 40)),
          guests: 1,
          status: BookingStatus.completed,
          totalPaid: 45,
          reference: 'SD-55012-NYG',
        ),
      ];

  static List<AppNotification> notifications() => const [
        AppNotification(
          title: 'Booking confirmed',
          body: 'Your Lake Kariba Houseboat Sunset is locked in for the 3rd.',
          time: '2h ago',
          icon: Icons.check_circle_rounded,
          unread: true,
        ),
        AppNotification(
          title: 'Reminder',
          body: 'Mana Pools Wild Canoe Safari starts in 19 days — pack light layers.',
          time: '1d ago',
          icon: Icons.notifications_active_rounded,
          unread: true,
        ),
        AppNotification(
          title: 'New in Matobo',
          body: 'Matobo Rangers just published a new sunrise rhino-tracking slot.',
          time: '3d ago',
          icon: Icons.auto_awesome_rounded,
        ),
      ];
}
