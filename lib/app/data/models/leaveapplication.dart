class Leaveapplication {
  String title;
  String description;
  String date;
  String? attachment;

  Leaveapplication({
    required this.title,
    required this.description,
    required this.date,
    this.attachment,
  });

  // factory method to create a Leaveapplication instance from a map
  factory Leaveapplication.fromMap(Map<String, dynamic> map) {
    return Leaveapplication(
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      date: map['date'] ?? '',
      attachment: map['attachment'],
    );
  }

  // method to convert a Leaveapplication instance to a map 
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'date': date,
      'attachment': attachment,
    };
  }
}
