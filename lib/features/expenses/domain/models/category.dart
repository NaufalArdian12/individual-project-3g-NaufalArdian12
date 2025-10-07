import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

const _uuid = Uuid();

class Category extends Equatable {
  final String id;
  final String name;
  final int color; // ARGB (Color.value)

  const Category({required this.id, required this.name, required this.color});

  factory Category.create({required String name, required int color}) =>
      Category(id: _uuid.v4(), name: name, color: color);

  Category copyWith({String? id, String? name, int? color}) => Category(
    id: id ?? this.id,
    name: name ?? this.name,
    color: color ?? this.color,
  );

  Map<String, dynamic> toJson() => {'id': id, 'name': name, 'color': color};
  factory Category.fromJson(Map<String, dynamic> json) =>
      Category(id: json['id'], name: json['name'], color: json['color']);

  @override
  List<Object?> get props => [id, name, color];
}
