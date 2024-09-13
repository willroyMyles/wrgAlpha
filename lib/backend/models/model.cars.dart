import 'dart:convert';

enum Transmission {
  Automatic,
  Manual,
  Tiptronic;

  static Transmission fromName(String name) {
    switch (name) {
      case "Automatic":
        return Transmission.Automatic;
      case "Manual":
        return Transmission.Manual;
      case "Tiptronic":
        return Transmission.Tiptronic;
      default:
        return Transmission.Automatic;
    }
  }
}

enum CarType {
  Ninty("90"),
  EightySeven("87"),
  Diesl("Diesel"),
  Electric("Electric"),
  Hybrid("Hybrid");

  final String name;

  static CarType fromName(String name) {
    switch (name) {
      case "90":
        return CarType.Ninty;
      case "87":
        return CarType.EightySeven;
      case "Diesel":
        return CarType.Diesl;
      case "Electric":
        return CarType.Electric;
      case "Hybrid":
        return CarType.Hybrid;
      default:
        return CarType.Ninty;
    }
  }

  const CarType(this.name);
}

class CarModel {
  String make;
  String model;
  String year;
  String? alias;
  String? engineNo;
  String? chasisNo;
  String? color;
  //enum
  Transmission? transmission;
  //enum
  CarType? type;
  String? bodyType;
  String? description;
  String userEmail;
  String userName;
  CarModel({
    this.make = '',
    this.model = '',
    this.year = '',
    this.alias,
    this.engineNo,
    this.chasisNo,
    this.color,
    this.transmission,
    this.type,
    this.bodyType,
    this.description,
    this.userEmail = '',
    this.userName = '',
  });

  String getId() {
    return "$make-$model-$year-$userEmail";
  }

  Map<String, dynamic> toMap() {
    return {
      'make': make,
      'model': model,
      'year': year,
      'alias': alias,
      'engineNo': engineNo,
      'chasisNo': chasisNo,
      'color': color,
      'transmission': transmission?.index,
      'type': type?.index,
      'bodyType': bodyType,
      'description': description,
      'userEmail': userEmail,
      'userName': userName,
    };
  }

  factory CarModel.fromMap(Map<String, dynamic> map) {
    return CarModel(
      make: map['make'] ?? '',
      model: map['model'] ?? '',
      year: map['year'] ?? '',
      alias: map['alias'],
      engineNo: map['engineNo'],
      chasisNo: map['chasisNo'],
      color: map['color'],
      transmission: map['transmission'] != null
          ? Transmission.values[map['transmission'] ?? 0]
          : null,
      type: map['type'] != null ? CarType.values[map['type'] ?? 0] : null,
      bodyType: map['bodyType'],
      description: map['description'],
      userEmail: map['userEmail'] ?? '',
      userName: map['userName'] ?? '',
    );
  }

  factory CarModel.fromJson(String source) =>
      CarModel.fromMap(json.decode(source));
}
