// event_model.dart

// 🎯 Dart imports:
import 'dart:convert';

EventResult eventResultFromJson(String str) =>
    EventResult.fromJson(json.decode(str));

String eventResultToJson(EventResult data) => json.encode(data.toJson());

class EventResult {
  EventResult({
    required this.events,
  });

  List<Events> events = [];

  EventResult.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      json['items'].forEach((v) {
        events.add(Events.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() => {
        'items': List<dynamic>.from(events.map((x) => x.toJson())),
      };
}

class Events {
  Events({
    required this.id,
    required this.status,
    required this.htmlLink,
    required this.created,
    required this.updated,
    this.summary,
    this.description,
    this.location,
    required this.creator,
    required this.organizer,
    required this.start,
    required this.end,
  });

  String id;
  String status;
  String htmlLink;
  DateTime created;
  DateTime updated;
  String? summary;
  String? description;
  String? location;
  Creator creator;
  Creator organizer;
  End start;
  End end;

  factory Events.fromJson(Map<String, dynamic> json) => Events(
        id: json['id'],
        status: json['status'],
        htmlLink: json['htmlLink'],
        created: DateTime.parse(json['created']),
        updated: DateTime.parse(json['updated']),
        summary: json['summary'],
        description: json['description'],
        location: json['location'],
        creator: Creator.fromJson(json['creator']),
        organizer: Creator.fromJson(json['organizer']),
        start: End.fromJson(json['start']),
        end: End.fromJson(json['end']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'status': status,
        'htmlLink': htmlLink,
        'created': created.toIso8601String(),
        'updated': updated.toIso8601String(),
        'summary': summary,
        'description': description,
        'location': location,
        'creator': creator.toJson(),
        'organizer': organizer.toJson(),
        'start': start.toString(),
        'end': end.toString(),
      };
}

class Creator {
  Creator({
    required this.email,
  });

  String email;

  factory Creator.fromJson(Map<String, dynamic> json) => Creator(
        email: json['email'],
      );

  Map<String, dynamic> toJson() => {
        'email': email,
      };
}

class End {
  End({
    required this.dateTime,
  });

  DateTime dateTime;

  factory End.fromJson(Map<String, dynamic> json) {
    if (json.containsKey('dateTime')) {
      return End(dateTime: DateTime.parse(json['dateTime']));
    } else if (json.containsKey('date')) {
      // Handle date only fields as whole-day events
      return End(dateTime: DateTime.parse(json['date']));
    } else {
      throw Exception('Invalid date format');
    }
  }
}
