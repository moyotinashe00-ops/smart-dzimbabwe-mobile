import 'package:flutter/material.dart';

enum UserRole { operator, admin }

class PlaceholderPhoto {
  final List<Color> gradient;
  final IconData icon;
  const PlaceholderPhoto(this.gradient, this.icon);

  Map<String, dynamic> toJson() => {
        'icon': icon.codePoint,
      };

  factory PlaceholderPhoto.fromJson(Map<String, dynamic> json) => const PlaceholderPhoto(
        [Color(0xFF1C4A63), Color(0xFF0E2A1E)],
        Icons.photo_library_rounded,
      );
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

  factory Listing.fromJson(Map<String, dynamic> json) {
    return Listing(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      location: json['location'] as String? ?? '',
      category: json['category'] as String? ?? 'Wildlife',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      status: ListingStatus.values.firstWhere(
        (s) => s.name == json['status'],
        orElse: () => ListingStatus.published,
      ),
      bookingsCount: json['bookingsCount'] as int? ?? 0,
      rating: (json['rating'] as num?)?.toDouble() ?? 5.0,
      photo: json['photo'] != null ? PlaceholderPhoto.fromJson(json['photo'] as Map<String, dynamic>) : const PlaceholderPhoto([Color(0xFF1C4A63), Color(0xFF0E2A1E)], Icons.photo_library_rounded),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'location': location,
        'category': category,
        'price': price,
        'status': status.name,
        'bookingsCount': bookingsCount,
        'rating': rating,
        'photo': photo.toJson(),
      };
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

  factory OperatorBooking.fromJson(Map<String, dynamic> json) {
    return OperatorBooking(
      id: json['id'] as String? ?? '',
      listingTitle: json['listingTitle'] as String? ?? '',
      guestName: json['guestName'] as String? ?? '',
      date: json['date'] != null ? DateTime.tryParse(json['date'] as String) ?? DateTime.now() : DateTime.now(),
      guests: json['guests'] as int? ?? 1,
      amount: (json['amount'] as num?)?.toDouble() ?? 0.0,
      status: BookingStatus.values.firstWhere(
        (s) => s.name == json['status'],
        orElse: () => BookingStatus.confirmed,
      ),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'listingTitle': listingTitle,
        'guestName': guestName,
        'date': date.toIso8601String(),
        'guests': guests,
        'amount': amount,
        'status': status.name,
      };
}

class SettlementBatch {
  final String id;
  final DateTime date;
  final double amount;
  final String status;
  final int bookingsCount;

  const SettlementBatch({
    required this.id,
    required this.date,
    required this.amount,
    required this.status,
    required this.bookingsCount,
  });

  factory SettlementBatch.fromJson(Map<String, dynamic> json) {
    return SettlementBatch(
      id: json['id'] as String? ?? '',
      date: json['date'] != null ? DateTime.tryParse(json['date'] as String) ?? DateTime.now() : DateTime.now(),
      amount: (json['amount'] as num?)?.toDouble() ?? 0.0,
      status: json['status'] as String? ?? 'Paid out',
      bookingsCount: json['bookingsCount'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'date': date.toIso8601String(),
        'amount': amount,
        'status': status,
        'bookingsCount': bookingsCount,
      };
}

class PendingApproval {
  final String title;
  final String subtitle;
  final IconData icon;
  const PendingApproval({required this.title, required this.subtitle, required this.icon});

  factory PendingApproval.fromJson(Map<String, dynamic> json) {
    return PendingApproval(
      title: json['title'] as String? ?? '',
      subtitle: json['subtitle'] as String? ?? '',
      icon: Icons.pending_actions_rounded,
    );
  }

  Map<String, dynamic> toJson() => {
        'title': title,
        'subtitle': subtitle,
      };
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

  factory PlatformOperator.fromJson(Map<String, dynamic> json) {
    return PlatformOperator(
      id: json['id'] as String? ?? '',
      businessName: json['businessName'] as String? ?? '',
      ownerName: json['ownerName'] as String? ?? '',
      email: json['email'] as String? ?? '',
      isPaused: json['isPaused'] as bool? ?? false,
      listingsCount: json['listingsCount'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'businessName': businessName,
        'ownerName': ownerName,
        'email': email,
        'isPaused': isPaused,
        'listingsCount': listingsCount,
      };
}
