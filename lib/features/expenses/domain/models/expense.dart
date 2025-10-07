import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

const _uuid = Uuid();

class Expense extends Equatable {
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final String categoryId;
  final String? note;
  final String? userId; // untuk multi-user (opsional)
  final bool shared; // shared expense (opsional)

  const Expense({
    required this.id,
    required this.title,
    required this.amount,
    required this.date,
    required this.categoryId,
    this.note,
    this.userId,
    this.shared = false,
  });

  factory Expense.create({
    required String title,
    required double amount,
    required DateTime date,
    required String categoryId,
    String? note,
    String? userId,
    bool shared = false,
  }) => Expense(
    id: _uuid.v4(),
    title: title,
    amount: amount,
    date: date,
    categoryId: categoryId,
    note: note,
    userId: userId,
    shared: shared,
  );

  Expense copyWith({
    String? id,
    String? title,
    double? amount,
    DateTime? date,
    String? categoryId,
    String? note,
    String? userId,
    bool? shared,
  }) => Expense(
    id: id ?? this.id,
    title: title ?? this.title,
    amount: amount ?? this.amount,
    date: date ?? this.date,
    categoryId: categoryId ?? this.categoryId,
    note: note ?? this.note,
    userId: userId ?? this.userId,
    shared: shared ?? this.shared,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'amount': amount,
    'date': date.toIso8601String(),
    'categoryId': categoryId,
    'note': note,
    'userId': userId,
    'shared': shared,
  };

  factory Expense.fromJson(Map<String, dynamic> json) => Expense(
    id: json['id'],
    title: json['title'],
    amount: (json['amount'] as num).toDouble(),
    date: DateTime.parse(json['date']),
    categoryId: json['categoryId'],
    note: json['note'],
    userId: json['userId'],
    shared: json['shared'] ?? false,
  );

  @override
  List<Object?> get props => [
    id,
    title,
    amount,
    date,
    categoryId,
    note,
    userId,
    shared,
  ];
}
