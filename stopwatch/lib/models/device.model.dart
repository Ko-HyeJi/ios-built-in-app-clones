class DeviceInfo {
  final String platform;
  final String serial;
  final String systemVersion;
  final String model;
  final double ppi;
  final double ppm;
  final double scaledPpm;
  final LogicalSize logicalSize;
  final PhysicalSize physicalSize;
  final double devicePixelRatio;

  DeviceInfo({
    required this.platform,
    required this.serial,
    required this.systemVersion,
    required this.model,
    required this.ppi,
    required this.ppm,
    required this.scaledPpm,
    required this.logicalSize,
    required this.physicalSize,
    required this.devicePixelRatio,
  });

  DeviceInfo.fromJson(Map<String, dynamic> json)
      : platform = json["platform"],
        serial = json["serial"],
        systemVersion = json["systemVersion"],
        model = json["model"],
        ppi = json["ppi"],
        ppm = json["ppm"],
        scaledPpm = json['scaledPpm'],
        logicalSize = LogicalSize.fromJson(json["logicalSize"]),
        physicalSize = PhysicalSize.fromJson(json["physicalSize"]),
        devicePixelRatio = json["devicePixelRatio"];

  Map<String, dynamic> toJson() => {
    "platform": platform,
    "serial": serial,
    "systemVersion": systemVersion,
    "model": model,
    "ppi": ppi,
    "ppm": ppm,
    'scaledPpm': scaledPpm,
    "logicalSize": logicalSize.toJson(),
    "physicalSize": physicalSize.toJson(),
    "devicePixelRatio": devicePixelRatio,
  };
}

class PhysicalSize {
  final double width;
  final double height;

  PhysicalSize({
    required this.width,
    required this.height,
  });

  PhysicalSize.fromJson(Map<String, dynamic> json)
      : width = json["width"] as double,
        height = json["height"] as double;

  Map<String, double> toJson() => {
    "width": width,
    "height": height,
  };
}

class LogicalSize {
  final double width;
  final double height;

  LogicalSize({
    required this.width,
    required this.height,
  });

  LogicalSize.fromJson(Map<String, dynamic> json)
      : width = json["width"] as double,
        height = json["height"] as double;

  Map<String, double> toJson() => {
    "width": width,
    "height": height,
  };
}
