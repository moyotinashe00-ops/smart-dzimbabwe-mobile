import 'package:flutter/material.dart';

class PlaceholderPhoto {
  final List<Color> gradient;
  final IconData icon;
  const PlaceholderPhoto(this.gradient, this.icon);

  Map<String, dynamic> toJson() => {'icon': icon.codePoint};

  factory PlaceholderPhoto.fromJson(Map<String, dynamic> json) => const PlaceholderPhoto(
        [Color(0xFF2E5E43), Color(0xFF0E2A1E)],
        Icons.explore_rounded,
      );
}

class Experience {
  final String id;
  final String title;
  final String location;
  final String category;
  final double pricePerPerson;
  final double rating;
  final int reviewCount;
  final String operatorName;
  final String description;
  final List<String> highlights;
  final PlaceholderPhoto photo;
  final int durationHours;

  const Experience({
    required this.id,
    required this.title,
    required this.location,
    required this.category,
    required this.pricePerPerson,
    required this.rating,
    required this.reviewCount,
    required this.operatorName,
    required this.description,
    required this.highlights,
    required this.photo,
    required this.durationHours,
  });

  factory Experience.fromJson(Map<String, dynamic> json) {
    return Experience(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      location: json['location'] as String? ?? '',
      category: json['category'] as String? ?? 'Wildlife',
      pricePerPerson: (json['pricePerPerson'] as num?)?.toDouble() ?? 0.0,
      rating: (json['rating'] as num?)?.toDouble() ?? 5.0,
      reviewCount: json['reviewCount'] as int? ?? 0,
      operatorName: json['operatorName'] as String? ?? 'Tour Operator',
      description: json['description'] as String? ?? '',
      highlights: (json['highlights'] as List?)?.map((e) => e.toString()).toList() ?? [],
      photo: json['photo'] != null ? PlaceholderPhoto.fromJson(json['photo'] as Map<String, dynamic>) : const PlaceholderPhoto([Color(0xFF2E5E43), Color(0xFF0E2A1E)], Icons.explore_rounded),
      durationHours: json['durationHours'] as int? ?? 2,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'location': location,
        'category': category,
        'pricePerPerson': pricePerPerson,
        'rating': rating,
        'reviewCount': reviewCount,
        'operatorName': operatorName,
        'description': description,
        'highlights': highlights,
        'photo': photo.toJson(),
        'durationHours': durationHours,
      };
}

enum BookingStatus { pending, confirmed, completed }

class Booking {
  final String id;
  final Experience experience;
  final DateTime date;
  final int guests;
  final BookingStatus status;
  final double totalPaid;
  final String reference;

  const Booking({
    required this.id,
    required this.experience,
    required this.date,
    required this.guests,
    required this.status,
    required this.totalPaid,
    required this.reference,
  });

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      id: json['id'] as String? ?? '',
      experience: Experience.fromJson(json['experience'] as Map<String, dynamic>? ?? {}),
      date: json['date'] != null ? DateTime.tryParse(json['date'] as String) ?? DateTime.now() : DateTime.now(),
      guests: json['guests'] as int? ?? 1,
      status: BookingStatus.values.firstWhere(
        (s) => s.name == json['status'],
        orElse: () => BookingStatus.confirmed,
      ),
      totalPaid: (json['totalPaid'] as num?)?.toDouble() ?? 0.0,
      reference: json['reference'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'experience': experience.toJson(),
        'date': date.toIso8601String(),
        'guests': guests,
        'status': status.name,
        'totalPaid': totalPaid,
        'reference': reference,
      };
}

class AppNotification {
  final String title;
  final String body;
  final String time;
  final IconData icon;
  final bool unread;

  const AppNotification({
    required this.title,
    required this.body,
    required this.time,
    required this.icon,
    this.unread = false,
  });

  factory AppNotification.fromJson(Map<String, dynamic> json) {
    return AppNotification(
      title: json['title'] as String? ?? '',
      body: json['body'] as String? ?? '',
      time: json['time'] as String? ?? '',
      icon: Icons.notifications_active_rounded,
      unread: json['unread'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
        'title': title,
        'body': body,
        'time': time,
        'unread': unread,
      };
}
