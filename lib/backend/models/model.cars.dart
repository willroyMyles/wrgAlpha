import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wrg2/backend/mixin/mixin.get.dart';
import 'package:wrg2/backend/mixin/mixin.text.dart';
import 'package:wrg2/backend/utils/Constants.dart';
import 'package:wrg2/frontend/pages/profile/state.profile.dart';

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
  }) {
    userEmail = GF<ProfileState>().userModel?.value.email ?? "";
    userName = GF<ProfileState>().userModel?.value.username ?? "";
  }

  String getId() {
    return "$userEmail$make-$model-$year";
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

  Widget tile() {
    return Container(
      padding: Constants.ePadding,
      margin: Constants.ePadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "$alias",
                    style: TS.h2,
                  ),
                  Text(
                    "$make $model $year",
                    style: TS.h2,
                  ),
                ],
              ),
              PopupMenuButton(
                child: const Icon(CupertinoIcons.ellipsis_vertical),
                itemBuilder: (context) {
                  return [
                    const PopupMenuItem(
                      value: "edit",
                      child: Text("Edit"),
                    ),
                    const PopupMenuItem(
                      value: "delete",
                      child: Text("Delete"),
                    ),
                  ];
                },
              ),
            ],
          ),
          Text(
            "${transmission?.name.capitalize}  ${type?.name.capitalize}  ${bodyType?.capitalize}",
            style: TS.h3,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    "Engine: ",
                    style: TS.h3,
                  ),
                  Text(
                    "$engineNo",
                    style: TS.h2,
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    "Chasis: ",
                    style: TS.h3,
                  ),
                  Text(
                    "$chasisNo",
                    style: TS.h2,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
