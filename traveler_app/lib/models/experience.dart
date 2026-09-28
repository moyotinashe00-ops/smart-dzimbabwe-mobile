import 'package:flutter/material.dart';

/// Placeholder "photo" — since real photography isn't wired up yet, each
/// experience gets a deterministic gradient + icon so cards still read as
/// distinct imagery. Swap [PlaceholderPhoto] for a real Image widget once
/// the backend/asset pipeline is in.
class PlaceholderPhoto {
  final List<Color> gradient;
  final IconData icon;
  const PlaceholderPhoto(this.gradient, this.icon);
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
}
