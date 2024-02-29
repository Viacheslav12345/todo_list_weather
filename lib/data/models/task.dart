import 'dart:convert';

import 'package:equatable/equatable.dart';

class Task extends Equatable {
  final int id;
  final String title;
  final String description;
  final bool completed;
  final String category;

  const Task(
      {required this.id,
      required this.title,
      required this.description,
      required this.completed,
      required this.category});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'completed': completed,
      'category': category,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'] as int,
      title: map['title'] as String,
      description: map['description'] as String,
      completed: map['completed'] as bool,
      category: map['category'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Task.fromJson(String source) =>
      Task.fromMap(json.decode(source) as Map<String, dynamic>);

  Task copyWith({
    int? id,
    String? title,
    String? description,
    bool? completed,
    String? category,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      completed: completed ?? this.completed,
      category: category ?? this.category,
    );
  }

  @override
  List<Object?> get props {
    return [
      id,
      title,
      description,
      completed,
      category,
    ];
  }
}
