class Notice {
  int?id;
  String? title;
  String? date;
  String? description;
  String? color;

  Notice({this.title="", this.date="", this.description="", this.color="",this.id=0});

  // Factory constructor to create a Notice instance from a map
  factory Notice.fromMap(Map<String, dynamic> map) {
    return Notice(
      id:map['id'],
      title: map['title'],
      date: map['date'],
      description: map['description'],
      color: map['color'],
    );
  }

  // Method to convert a Notice instance to a map
  Map<String, dynamic> toMap() {
    return {
      'id':id,
      'title': title,
      'date': date,
      'description': description,
      'color': color,
    };
  }

  @override
  String toString() {
    return 'Notice(title: $title, date: $date, description: $description, color: $color)';
  }
}
