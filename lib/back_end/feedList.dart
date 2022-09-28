import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FeedList {
  final String content;
  final String poster_name;

  const FeedList({required this.content, required this.poster_name});

  static FeedList fromJson(json) => FeedList(
        content: json['content'],
        poster_name: json['name'],
      );
}
