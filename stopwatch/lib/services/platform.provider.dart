import 'dart:async';
import 'dart:convert';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:unique_identifier/unique_identifier.dart';

import 'package:stopwatch/models/apple.device.model.dart';
import 'package:stopwatch/models/device.model.dart';
import 'package:stopwatch/services/platform.db.provider.dart';

class PlatformProvider {
  late DeviceInfo? _deviceData;

  DeviceInfo? get deviceData => _deviceData;

  /// 플랫폼 초기화
  /// 플랫폼의 종류, 버전, 모델, ppi, ppm, logicalSize, physicalSize 를 반환한다.
  Future<bool> initPlatform() async {
    DeviceInfo? dbData = await database.readDeviceInfo();

    if (dbData != null) {
      _deviceData = dbData;
      return true;
    }

    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    _deviceData = switch (defaultTargetPlatform) {
      TargetPlatform.android => await _calculateAndroidMatrix(deviceInfo),
      TargetPlatform.iOS => await _calculateIosMatrix(deviceInfo),
      TargetPlatform.linux => null,
      TargetPlatform.windows => null,
      TargetPlatform.macOS => null,
      TargetPlatform.fuchsia => null,
    };

    /// `_deviceData` shall have date. If `_deviceData` is null, it means that either the platform is not mobile
    /// or necessary data has not been obtained.
    if (_deviceData == null) {
      return false;
    }

    debugPrint(_deviceData!.toJson().toString());
    await database.writeDeviceInfo(_deviceData!);
    return true;
  }

  Future<DeviceInfo> _calculateAndroidMatrix(
      DeviceInfoPlugin deviceInfo) async {
    const channel = MethodChannel('com.hicardi');
    var result = await channel.invokeMethod('getDisplayMetrics');

    Map<String, dynamic> deviceData =
    _readAndroidBuildData(await deviceInfo.androidInfo);

    String? identifier = await UniqueIdentifier.serial;
    double ppm = result['xdpi'] / 25.4;

    return DeviceInfo(
      platform: 'android',
      serial: identifier ?? deviceData['id'].toString(),
      systemVersion: deviceData['version.sdkInt'].toString(),
      model: deviceData['model'],
      ppi: result['xdpi'],
      ppm: ppm,
      scaledPpm: ppm /
          WidgetsBinding
              .instance.platformDispatcher.views.first.devicePixelRatio,
      logicalSize: LogicalSize.fromJson({
        "width": WidgetsBinding
            .instance.platformDispatcher.views.first.physicalSize.width /
            WidgetsBinding
                .instance.platformDispatcher.views.first.devicePixelRatio,
        "height": WidgetsBinding
            .instance.platformDispatcher.views.first.physicalSize.height /
            WidgetsBinding
                .instance.platformDispatcher.views.first.devicePixelRatio,
      }),
      physicalSize: PhysicalSize.fromJson({
        "width": WidgetsBinding
            .instance.platformDispatcher.views.first.physicalSize.width /
            ppm,
        "height": WidgetsBinding
            .instance.platformDispatcher.views.first.physicalSize.height /
            ppm,
      }),
      devicePixelRatio: WidgetsBinding
          .instance.platformDispatcher.views.first.devicePixelRatio,
    );
  }

  Future<DeviceInfo?> _calculateIosMatrix(DeviceInfoPlugin deviceInfo) async {
    Map<String, dynamic> deviceData =
    _readIosDeviceInfo(await deviceInfo.iosInfo);

    AppleDeviceInfo? device =
    await loadAppleDeviceInfo(deviceData['utsname.machine:']);

    if (device == null) {
      return null;
    }

    /// ppm => pixcels per millimeter
    /// Convert inches -> millimeters
    double ppm = device.ppi.toDouble() / 25.4;

    return DeviceInfo(
      platform: 'ios',
      serial: deviceData['identifierForVendor'].toString(),
      systemVersion: deviceData['systemVersion'].toString(),
      model: deviceData['utsname.machine:'],
      ppi: device.ppi.toDouble(),
      ppm: ppm,
      scaledPpm: ppm /
          WidgetsBinding
              .instance.platformDispatcher.views.first.devicePixelRatio,
      logicalSize: LogicalSize.fromJson({
        "width": WidgetsBinding
            .instance.platformDispatcher.views.first.physicalSize.width /
            WidgetsBinding
                .instance.platformDispatcher.views.first.devicePixelRatio,
        "height": WidgetsBinding
            .instance.platformDispatcher.views.first.physicalSize.height /
            WidgetsBinding
                .instance.platformDispatcher.views.first.devicePixelRatio,
      }),
      physicalSize: PhysicalSize.fromJson({
        "width": WidgetsBinding
            .instance.platformDispatcher.views.first.physicalSize.width /
            ppm,
        "height": WidgetsBinding
            .instance.platformDispatcher.views.first.physicalSize.height /
            ppm,
      }),
      devicePixelRatio: WidgetsBinding
          .instance.platformDispatcher.views.first.devicePixelRatio,
    );
  }

  /// 애플 기기 정보 확인
  /// 애플은 ppi 값을 api 형태로 제공하지 않는다. 신규 기기 출시 시점에 기기의 정보를 업데이트 시켜줘야 한다.
  /// Mobile device code type https://gist.github.com/adamawolf/3048717
  /// ios=resolution https://www.ios-resolution.com/
  Future<AppleDeviceInfo?> loadAppleDeviceInfo(String model) async {
    AppleDeviceInfo? device;
    String jsonStr = await rootBundle.loadString('assets/apple/apple.json');
    List<dynamic> devices = jsonDecode(jsonStr);

    for (var element in devices) {
      if (element['model'] == model) {
        device = AppleDeviceInfo.fromJson(element);
        return device;
      }
    }

    return device;
  }

  Map<String, dynamic> _readAndroidBuildData(AndroidDeviceInfo build) {
    return <String, dynamic>{
      'version.securityPatch': build.version.securityPatch,
      'version.sdkInt': build.version.sdkInt,
      'version.release': build.version.release,
      'version.previewSdkInt': build.version.previewSdkInt,
      'version.incremental': build.version.incremental,
      'version.codename': build.version.codename,
      'version.baseOS': build.version.baseOS,
      'board': build.board,
      'bootloader': build.bootloader,
      'brand': build.brand,
      'device': build.device,
      'display': build.display,
      'fingerprint': build.fingerprint,
      'hardware': build.hardware,
      'host': build.host,
      'id': build.id,
      'manufacturer': build.manufacturer,
      'model': build.model,
      'product': build.product,
      'supported32BitAbis': build.supported32BitAbis,
      'supported64BitAbis': build.supported64BitAbis,
      'supportedAbis': build.supportedAbis,
      'tags': build.tags,
      'type': build.type,
      'isPhysicalDevice': build.isPhysicalDevice,
      'systemFeatures': build.systemFeatures,
      'serialNumber': build.serialNumber,
    };
  }

  Map<String, dynamic> _readIosDeviceInfo(IosDeviceInfo data) {
    return <String, dynamic>{
      'name': data.name,
      'systemName': data.systemName,
      'systemVersion': data.systemVersion,
      'model': data.model,
      'localizedModel': data.localizedModel,
      'identifierForVendor': data.identifierForVendor,
      'isPhysicalDevice': data.isPhysicalDevice,
      'utsname.sysname:': data.utsname.sysname,
      'utsname.nodename:': data.utsname.nodename,
      'utsname.release:': data.utsname.release,
      'utsname.version:': data.utsname.version,
      'utsname.machine:': data.utsname.machine,
    };
  }
}

final platformProvider = PlatformProvider();
