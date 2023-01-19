import '../../Widget/parameterString.dart';

class CityModel {
  String? id, name;

  CityModel({
    this.id,
    this.name,
  });

  factory CityModel.fromJson(Map<String, dynamic> json) {
    return CityModel(
      id: json[Id],
      name: json[Name],
    );
  }
}
