class TodoModel
{
  final int? id;
  final String title;
  final String description;
  final String date;
  final String startTime;
  final String endTime;
  final int reminder;
  final String repeat;
  final int color;
  final int isCompleted;

  TodoModel({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.reminder,
    required this.repeat,
    required this.color,
    required this.isCompleted,
  });


factory TodoModel.fromMap(Map<String, dynamic> map) {
    return TodoModel(
      id: map['_id'],
      title: map['title'],
      description: map['description'],
      date: map['date'],
      startTime: map['start_time'],
      endTime: map['end_time'],
      reminder: map['reminder'],
      repeat: map['repeat'],
      color: map['color'],
      isCompleted: map['is_completed'],
    );
  }
Map<String, dynamic> toMap() {
    final map= {
      '_id': id,
      'title': title,
      'description': description,
      'date': date,
      'start_time': startTime,
      'end_time': endTime,
      'reminder': reminder,
      'repeat': repeat,
      'color': color,
      'is_completed': isCompleted,
    };

    if (id != null) {
      map['_id'] = id;
    }
    return map;
  }
}