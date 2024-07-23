import 'package:hive/hive.dart';

part 'database_model.g.dart';

@HiveType(typeId: 0)
class ContactModel {
  @HiveField(0)
  late String name;

  @HiveField(1)
  late String number;

  @HiveField(2)
  late String email;

  @HiveField(3)
  late bool isFavorite;

  ContactModel(
      {required this.name,
      required this.number,
      required this.email,
      required this.isFavorite});
}
