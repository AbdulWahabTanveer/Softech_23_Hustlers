
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
    required this.lng,
    required this.uid,
    required this.id,
    required this.category,
    this.status="pending",
    this.handymanId,
  });

  String title;
  String description;
  double price;
  DateTime date;
  List<dynamic> images;
  String id;
  String uid;
  double lat;
  double lng;
  String category;
  String status;
  String? handymanId;

  factory JobModel.fromJson(Map<String, dynamic> json) {
    return JobModel(
      title: json["title"],
      description: json["description"],
      price:json["price"],
      date: DateTime.parse(json["date"]),
      images:  json['images'],
      uid: json["uid"],
      lat: json["lat"],
      lng: json["lng"],
      category: json["category"] ??"",
      status: json["status"]??"", id: json["id"],
      handymanId: json["handymanId"],
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
      "lng": this.lng,
      "category": this.category,
      "status": this.status,
      "id": this.id,
      "handymanId": this.handymanId,

    };
  }
//
}