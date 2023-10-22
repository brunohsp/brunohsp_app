import 'package:brunohsp_app/models/dnd_class.dart';
import 'package:brunohsp_app/services/service.dart';

class DndClassService extends Service {
  Future<List<DndClass>> getAll() async {
    List<DndClass> classes = [];
    Map<String, dynamic> jsonMap = await super.get("classes");
    List<dynamic> jsonList = jsonMap['results'];

    for (var jsonItem in jsonList) {
      classes.add(DndClass.fromMap(jsonItem));
    }

    return classes;
  }

  Future<DndClass> getByIndex(String index) async {
    DndClass dndClass = DndClass();
    Map<String, dynamic> classMap = await super.get("classes/$index");
    List<dynamic> levelsMap = await super.getList("classes/$index/levels");

    dndClass.specificationsFromMap(classMap, levelsMap);

    return dndClass;
  }
}
