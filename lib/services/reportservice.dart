import 'package:cloud_firestore/cloud_firestore.dart';

class Report {
  final String Location;
  final String Id;
  final String Time;
  final String Type;

  Report({
    required this.Location,
    required this.Id,
    required this.Time,
    required this.Type,
  });

  Map<String, dynamic> toJson() => {
        'Location': Location,
        'Id': Id,
        'Time': Time,
        'Type': Type,
      };
}
