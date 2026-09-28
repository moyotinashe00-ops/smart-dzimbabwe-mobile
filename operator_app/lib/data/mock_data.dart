import 'package:flutter/material.dart';
import '../models/models.dart';

class MockData {
  MockData._();

  static const businessName = 'Zambezi Waters';
  static const ownerName = 'Aaron Mashingaidze';

  static final listings = <Listing>[
    Listing(
      id: 'ls-01',
      title: 'Lake Kariba Houseboat Sunset',
      location: 'Kariba, Mashonaland West',
      category: 'Water & Falls',
      price: 60,
      status: ListingStatus.published,
      bookingsCount: 214,
      rating: 4.95,
      photo: const PlaceholderPhoto([Color(0xFF1C4A63), Color(0xFF0E2A1E)], Icons.directions_boat_filled_rounded),
    ),
    Listing(
      id: 'ls-02',
      title: 'Mana Pools Wild Canoe Safari',
      location: 'Mana Pools, Mashonaland West',
      category: 'Wildlife',
      price: 90,
      status: ListingStatus.published,
      bookingsCount: 152,
      rating: 4.97,
      photo: const PlaceholderPhoto([Color(0xFF2E5E43), Color(0xFF163A2A)], Icons.kayaking_rounded),
    ),
    Listing(
      id: 'ls-03',
      title: 'Community Waterhole Night Passage',
      location: 'Hwange, Matabeleland North',
      category: 'Wildlife',
      price: 75,
      status: ListingStatus.pending,
      bookingsCount: 0,
      rating: 0,
      photo: const PlaceholderPhoto([Color(0xFF4C4A2E), Color(0xFF0E2A1E)], Icons.nightlight_round),
    ),
    Listing(
      id: 'ls-04',
      title: 'Zambezi Sunrise Fishing Charter',
      location: 'Victoria Falls, Matabeleland North',
      category: 'Water & Falls',
      price: 50,
      status: ListingStatus.draft,
      bookingsCount: 0,
      rating: 0,
      photo: const PlaceholderPhoto([Color(0xFF1C4A63), Color(0xFF163A2A)], Icons.set_meal_rounded),
    ),
  ];

  static final bookings = <OperatorBooking>[
    OperatorBooking(
      id: 'bk-9931',
      listingTitle: 'Lake Kariba Houseboat Sunset',
      guestName: 'Rutendo Chikafu',
      date: DateTime.now().add(const Duration(days: 3)),
      guests: 4,
      amount: 240,
      status: BookingStatus.confirmed,
    ),
    OperatorBooking(
      id: 'bk-9932',
      listingTitle: 'Mana Pools Wild Canoe Safari',
      guestName: 'James Whitfield',
      date: DateTime.now().add(const Duration(days: 8)),
      guests: 2,
      amount: 180,
      status: BookingStatus.pending,
    ),
    OperatorBooking(
      id: 'bk-9899',
      listingTitle: 'Lake Kariba Houseboat Sunset',
      guestName: 'Nomvula Sibanda',
      date: DateTime.now().subtract(const Duration(days: 5)),
      guests: 3,
      amount: 180,
      status: BookingStatus.completed,
    ),
    OperatorBooking(
      id: 'bk-9860',
      listingTitle: 'Mana Pools Wild Canoe Safari',
      guestName: 'Liam O\'Connor',
      date: DateTime.now().subtract(const Duration(days: 12)),
      guests: 2,
      amount: 180,
      status: BookingStatus.cancelled,
    ),
  ];

  static final settlements = <SettlementBatch>[
    SettlementBatch(id: 'st-2291', date: DateTime.now().subtract(const Duration(days: 2)), amount: 1284.50, status: 'Paid out', bookingsCount: 9),
    SettlementBatch(id: 'st-2244', date: DateTime.now().subtract(const Duration(days: 9)), amount: 963.20, status: 'Paid out', bookingsCount: 7),
    SettlementBatch(id: 'st-2299', date: DateTime.now().add(const Duration(days: 5)), amount: 742.00, status: 'Scheduled', bookingsCount: 5),
  ];

  static const pendingApprovals = <PendingApproval>[
    PendingApproval(title: 'Community Waterhole Night Passage', subtitle: 'New listing awaiting review · Zambezi Waters', icon: Icons.pending_actions_rounded),
    PendingApproval(title: 'Matobo Rangers', subtitle: 'Business verification documents submitted', icon: Icons.verified_user_outlined),
    PendingApproval(title: 'Payout dispute #4471', subtitle: 'Guest requesting refund review', icon: Icons.report_gmailerrorred_rounded),
  ];

  static const earningsSeries = <double>[420, 610, 380, 720, 900, 640, 980];
  static const analyticsWeeklyVisits = <double>[120, 180, 150, 240, 300, 260, 340];

  static final operators = <PlatformOperator>[
    PlatformOperator(id: 'op-01', businessName: 'Zambezi Waters', ownerName: 'Aaron Mashingaidze', email: 'aaron@zambeziwaters.co.zw', listingsCount: 4),
    PlatformOperator(id: 'op-02', businessName: 'Matobo Wildlife Safaris', ownerName: 'Nkosana Ndlovu', email: 'nkosana@matobosafaris.co.zw', listingsCount: 3),
    PlatformOperator(id: 'op-03', businessName: 'Eastern Highlands Eco-Tours', ownerName: 'Chipo Moyo', email: 'chipo@easternhighlands.co.zw', listingsCount: 2),
    PlatformOperator(id: 'op-04', businessName: 'Great Zimbabwe Heritage Guides', ownerName: 'Tendai Mutasa', email: 'tendai@greatzimbabwe.co.zw', listingsCount: 5, isPaused: true),
  ];

  static double get totalEarnings => 4680.00;
  static double get availableBalance => 1284.50;
  static double get pendingBalance => 742.00;
}
