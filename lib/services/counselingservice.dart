class Counseling {
  final String Counsellor;
  final String Reason;
  final String Time;

  Counseling(
      {required this.Counsellor, required this.Reason, required this.Time});

  Map<String, dynamic> toJson() =>
      {'Counsellor': Counsellor, 'Reason': Reason, 'Time': Time};

  static Counseling fromJson(Map<String, dynamic> json) => Counseling(
        Counsellor: json['Counsellor'],
        Reason: json['Reason'],
        Time: json['Time'],
      );
}
