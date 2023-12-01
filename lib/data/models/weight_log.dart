import 'package:cloud_firestore/cloud_firestore.dart';

class WeightLog {
  final String id;
  final double weight;
  final Timestamp dateTime;

  WeightLog({
    required this.id,
    required this.weight,
    required this.dateTime,
  });

  factory WeightLog.fromJson(Map<String, dynamic> json) {
    return WeightLog(
      id: json['id'],
      weight: json['weight'],
      dateTime: json['dateTime'],
    );
  }

  //copyWith method
  WeightLog copyWith({
    String? id,
    double? weight,
    Timestamp? dateTime,
  }) {
    return WeightLog(
      id: id ?? this.id,
      weight: weight ?? this.weight,
      dateTime: dateTime ?? this.dateTime,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'weight': weight,
      'dateTime': dateTime,
    };
  }
}
