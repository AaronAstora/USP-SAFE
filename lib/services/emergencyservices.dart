class Emergency {
  final String Drill;
  final String Date;
  final String Time;
  final List<String> Participants;

  Emergency(
      {required this.Drill,
      required this.Date,
      required this.Time,
      required this.Participants});

  Map<String, dynamic> toJson() => {
        'Drill': Drill,
        'Date': Date,
        'Time': Time,
        'Participants': Participants
      };

  static Emergency fromJson(Map<String, dynamic> json) => Emergency(
        Drill: json['Drill'],
        Date: json['Date'],
        Time: json['Time'],
        Participants: List<String>.from(json['Participants']),
      );
}
