import 'package:aker_foods_retail/common/utils/database_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

abstract class HiveDataSource<TableType, ModelType> {
  String _boxName;
  Future<Box<TableType>> boxInstance;

  HiveDataSource({
    @required String boxName,
  }) {
    _boxName = boxName;
  }

  Future<Box<TableType>> _openBox() async {
    Box<TableType> box = await boxInstance;
    if (box == null || !box.isOpen) {
      boxInstance = DatabaseUtil.getBox<TableType>(boxName: _boxName);
      box = await boxInstance;
    }
    return box;
  }

  Future<Box<TableType>> get getBoxInstance async => _openBox();

  Future<List<String>> get keys async {
    final Box<TableType> box = await _openBox();
    final List<String> result = box.keys.map((k) => k.toString()).toList();
    return result;
  }

  Future<TableType> get(String key) async {
    final Box<TableType> box = await _openBox();
    return box.get(key);
  }

  Future<List<TableType>> getAll() async {
    final Box<TableType> box = await _openBox();
    return box.toMap().values.toList();
  }

  Future<void> put(String key, TableType value) async {
    final Box<TableType> box = await _openBox();
    await box.put(key, value);
  }

  Future<void> putAll(Map<String, TableType> items) async {
    final Box<TableType> box = await _openBox();
    await box.putAll(items);
  }

  Future<void> delete(String key) async {
    final Box<TableType> box = await _openBox();
    await box.delete(key);
  }

  Future<void> deleteAll() async {
    final Box<TableType> box = await _openBox();
    final List<String> boxKeys = await keys;
    await box.deleteAll(boxKeys);
  }

  Future<ModelType> getModelTypeData();

  Future<List<ModelType>> getModelTypeList();

  Future<void> insertOrUpdateData(ModelType model);

  Future<void> insertOrUpdateList(List<ModelType> models);
}
