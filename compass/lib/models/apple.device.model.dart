class AppleDeviceInfo {
  final String model;
  final String name;
  final double ppi;

  AppleDeviceInfo({
    required this.model,
    required this.name,
    required this.ppi,
  });

  AppleDeviceInfo.fromJson(Map<String, dynamic> json)
      : model = json["model"],
        name = json["name"],
        ppi = json["ppi"].toDouble();

  Map<String, dynamic> toJson() => {
    "model": model,
    "name": name,
    "ppi": ppi,
  };
}
