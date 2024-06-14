import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/device.model.dart';

class DatabaseProvider {
  Future<Database> deviceInfoDatabase() async {
    var databasesPath = (await getDatabasesPath());
    String databaseFile = 'device_info.db';
    String path = join(databasesPath, databaseFile);

    /// Only Debug Mode:
    /// This only runs on debug mode, delete database
    if (kDebugMode) {
      await deleteDatabase(path);
    }

    final database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
            'CREATE TABLE device(platform TEXT, serial TEXT, systemVersion TEXT, model TEXT, ppi REAL, ppm REAL, scaledPpm REAL, devicePixelRatio REAL)');
        await db.execute('CREATE TABLE physicalSize(height REAL, width REAL)');
        await db.execute('CREATE TABLE logicalSize(height REAL, width REAL)');
      },
    );

    return database;
  }

  Future<DeviceInfo?> readDeviceInfo() async {
    final database = await deviceInfoDatabase();

    final Map<String, Object?>? device =
        (await database.query('device')).firstOrNull;
    final Map<String, Object?>? physicalSize =
        (await database.query('physicalSize')).firstOrNull;
    final Map<String, Object?>? logicalSize =
        (await database.query('logicalSize')).firstOrNull;

    database.close();
    if (device == null || physicalSize == null || logicalSize == null) {
      return null;
    } else {
      return DeviceInfo(
        platform: device['platform'] as String,
        serial: device['serial'] as String,
        systemVersion: device['systemVersion'] as String,
        model: device['model'] as String,
        ppi: device['ppi'] as double,
        ppm: device['ppm'] as double,
        scaledPpm: device['scaledPpm'] as double,
        logicalSize: LogicalSize.fromJson(jsonDecode(jsonEncode(logicalSize))),
        physicalSize:
        PhysicalSize.fromJson(jsonDecode(jsonEncode(physicalSize))),
        devicePixelRatio: device['devicePixelRatio'] as double,
      );
    }
  }

  Future<void> writeDeviceInfo(DeviceInfo? deviceData) async {
    if (deviceData == null) {
      return;
    }

    final database = await deviceInfoDatabase();

    Map<String, dynamic> device = deviceData.toJson();
    Map<String, dynamic> physicalSize = device.remove('physicalSize');
    Map<String, dynamic> logicalSize = device.remove('logicalSize');

    await database.transaction((txn) async {
      await txn.insert('device', device);
      await txn.insert('physicalSize', physicalSize);
      await txn.insert('logicalSize', logicalSize);
    });

    database.close();
    return;
  }
}

final database = DatabaseProvider();
