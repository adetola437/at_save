import 'package:isar/isar.dart';

class LocalDatabase {
  static final LocalDatabase _instance = LocalDatabase._internal();

  factory LocalDatabase() {
    return _instance;
  }

  LocalDatabase._internal();

  static Isar? _isar;

  //   static openIsar() async {
  //   //var currentUser = await SessionManager().loggedIn();
  //   _isar = await Isar.open(
  //       [CategorySchema, CourseSchema, TopicSchema, LessonSchema, UserSchema],
  //       // name: currentUser.toString(),
  //       directory: (await getApplicationSupportDirectory()).path);
  // }
}
