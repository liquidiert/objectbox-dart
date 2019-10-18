import "package:objectbox/objectbox.dart";
import "entity.dart";

class TestEnv {
  final Directory dir;
  Store store;
  Box<TestEntity> box;

  TestEnv._(this.dir, this.store, this.box) {}

  static Future<TestEnv> create(String name) async {
    var dir = Directory("testdata-" + name);
    if (dir.existsSync()) dir.deleteSync(recursive: true);

    var store = await Store.create([TestEntity_OBXDefs], directory: dir.path);
    var box = await Box.create<TestEntity>(store);
    return TestEnv._(dir, store, box);
  }

  close() {
    store.close();
    if (dir.existsSync()) dir.deleteSync(recursive: true);
  }
}
