import 'dart:convert';

class Idea {
  final String id;
  final String name;
  final String tagline;
  final String description;
  final int rating;
  final int votes;
  final bool hasVoted;

  const Idea({
    required this.id,
    required this.name,
    required this.tagline,
    required this.description,
    required this.rating,
    this.votes = 0,
    this.hasVoted = false,
  });

  Idea copyWith({int? votes, bool? hasVoted}) {
    return Idea(
      id: id,
      name: name,
      tagline: tagline,
      description: description,
      rating: rating,
      votes: votes ?? this.votes,
      hasVoted: hasVoted ?? this.hasVoted,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'tagline': tagline,
      'description': description,
      'rating': rating,
      'votes': votes,
      'hasVoted': hasVoted,
    };
  }

  factory Idea.fromMap(Map<String, dynamic> map) {
    return Idea(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      tagline: map['tagline'] ?? '',
      description: map['description'] ?? '',
      rating: map['rating']?.toInt() ?? 0,
      votes: map['votes']?.toInt() ?? 0,
      hasVoted: map['hasVoted'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory Idea.fromJson(String source) => Idea.fromMap(json.decode(source));
}
