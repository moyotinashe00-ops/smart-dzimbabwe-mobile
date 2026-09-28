import 'package:flutter/material.dart';

enum UserRole { operator, admin }

class PlaceholderPhoto {
  final List<Color> gradient;
  final IconData icon;
  const PlaceholderPhoto(this.gradient, this.icon);
}

enum ListingStatus { published, draft, pending }

class Listing {
  final String id;
  final String title;
  final String location;
  final String category;
  final double price;
  final ListingStatus status;
  final int bookingsCount;
  final double rating;
  final PlaceholderPhoto photo;

  const Listing({
    required this.id,
    required this.title,
    required this.location,
    required this.category,
    required this.price,
    required this.status,
    required this.bookingsCount,
    required this.rating,
    required this.photo,
  });
}

enum BookingStatus { pending, confirmed, completed, cancelled }

class OperatorBooking {
  final String id;
  final String listingTitle;
  final String guestName;
  final DateTime date;
  final int guests;
  final double amount;
  final BookingStatus status;

  const OperatorBooking({
    required this.id,
    required this.listingTitle,
    required this.guestName,
    required this.date,
    required this.guests,
    required this.amount,
    required this.status,
  });
}

class SettlementBatch {
  final String id;
  final DateTime date;
  final double amount;
  final String status; // Paid out / Processing / Scheduled
  final int bookingsCount;

  const SettlementBatch({
    required this.id,
    required this.date,
    required this.amount,
    required this.status,
    required this.bookingsCount,
  });
}

class PendingApproval {
  final String title;
  final String subtitle;
  final IconData icon;
  const PendingApproval({required this.title, required this.subtitle, required this.icon});
}

class PlatformOperator {
  final String id;
  final String businessName;
  final String ownerName;
  final String email;
  bool isPaused;
  final int listingsCount;

  PlatformOperator({
    required this.id,
    required this.businessName,
    required this.ownerName,
    required this.email,
    this.isPaused = false,
    required this.listingsCount,
  });
}
