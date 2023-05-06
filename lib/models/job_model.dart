
import 'dart:convert';

import 'package:flutter/material.dart';

class JobModel{

  JobModel({
    required this.title,
    required this.description,
    required this.price,
    required this.date,
    required this.images,
    required this.lat,
    required this.long,
    required this.uid,
    required this.id,
    required this.category,
    this.status="pending",
  });

  String title;
  String description;
  double price;
  DateTime date;
  List<dynamic> images;
  String id;
  String uid;
  String lat;
  String long;
  String category;
  String status;

  factory JobModel.fromJson(Map<String, dynamic> json) {
    return JobModel(
      title: json["title"],
      description: json["description"],
      price:json["price"],
      date: DateTime.parse(json["date"]),
      images:  json['images'],
      uid: json["uid"],
      lat: json["lat"],
      long: json["long"],
      category: json["category"] ??"",
      status: json["status"]??"", id: json["id"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "description": description,
      "price": price,
      "date": this.date.toIso8601String(),
      "images": this.images,
      "uid": this.uid,
      "lat": this.lat,
      "long": this.long,
      "category": this.category,
      "status": this.status,
      "id": this.id,

    };
  }
//
}