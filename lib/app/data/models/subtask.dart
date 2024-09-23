class Subtask {
  bool? done;
  String? title;
  String? attachmentLink;

  Subtask({
    this.done,
    this.title,
    this.attachmentLink,
  });

  factory Subtask.fromJson(Map<String, dynamic> json) {
    return Subtask(
      done: json['done'],
      title: json['title'],
      attachmentLink: json['attachmentLink'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'done': done,
      'title': title,
      'attachmentLink': attachmentLink,
    };
  }
}