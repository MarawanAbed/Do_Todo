class TodoModel {
  final int? id;
  final String title;
  final String description;
  final String date;
  final String? time;
  final int color;
  final double? amount;
  final bool isChild;

  TodoModel({
    required this.id,
    required this.title,
    required this.amount,
    required this.description,
    required this.date,
    required this.time,
    required this.color,
    required this.isChild,
  });

  factory TodoModel.fromMap(Map<String, dynamic> map) {
    return TodoModel(
      id: map['_id'] as int,
      title: map['title'] as String,
      description: map['description'] as String,
      date: map['date'] as String,
      time: map['time'] as String?, // Handle nullable time
      color: map['color'],
      amount: map['amount'] as double?,
      isChild: map['isChild'] == 1, // Convert integer to boolean
    );
  }

  Map<String, dynamic> toMap() {
    final map = {
      '_id': id,
      'title': title,
      'description': description,
      'date': date,
      'time': time,
      'color': color,
      'amount': amount,
      'isChild': isChild ? 1 : 0, // Convert boolean to integer
    };

    if (id != null) {
      map['_id'] = id;
    }
    return map;
  }
}