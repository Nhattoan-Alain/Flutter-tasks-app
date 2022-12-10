import 'package:equatable/equatable.dart';

import 'package:flutter/material.dart';

class Task extends Equatable {
  final String title;
  final String description;
  final String id;
  final String date;
  Color? bgColor;
  bool? isDone;
  bool? isDeleted;
  bool? isFavorite;
  Task({
    required this.title,
    required this.description,
    required this.id,
    required this.date,
    required this.bgColor,
    this.isDone,
    this.isDeleted,
    this.isFavorite,
  }) {
    bgColor = bgColor ?? Colors.white;
    isDone = isDone ?? false;
    isDeleted = isDeleted ?? false;
    isFavorite = isFavorite ?? false;
  }

  Task copyWith({
    String? title,
    String? description,
    String? id,
    String? date,
    Color? bgColor,
    bool? isDone,
    bool? isDeleted,
    bool? isFavorite,
  }) {
    return Task(
      title: title ?? this.title,
      description: description ?? this.description,
      id: id ?? this.id,
      date: date ?? this.date,
      bgColor: bgColor ?? this.bgColor,
      isDone: isDone ?? this.isDone,
      isDeleted: isDeleted ?? this.isDeleted,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'id': id,
      'date': date,
      'bgColor': bgColor.toString(),
      'isDone': isDone,
      'isDeleted': isDeleted,
      'isFavorite': isFavorite,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    String valueString = map['bgColor'].split('(0x')[1].split(')')[0];
    int value = int.parse(valueString, radix: 16);
    Color bgColor = Color(value);
    return Task(
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      id: map['id'] ?? '',
      date: map['date'] ?? '',
      bgColor: bgColor,
      isDone: map['isDone'],
      isDeleted: map['isDeleted'],
      isFavorite: map['isFavorite'],
    );
  }

  @override
  List<Object?> get props => [
        title,
        description,
        id,
        date,
        bgColor,
        isDone,
        isDeleted,
        isFavorite,
      ];
}
