import 'dart:convert';
import 'package:blogs_app/Services/api_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;

class AddpostService {
  final firestore = FirebaseFirestore.instance.collection("posts");

  Future<bool> addPost(String title, String body) async {
    final url = Uri.parse(ApiService.addPost);
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"userId": 1, "title": title, "body": body}),
    );

    // return true if success, false otherwise
    return response.statusCode == 200 || response.statusCode == 201;
  }

  Future<bool> addPostFirestore(String title, String body) async {
    try {
      String id = DateTime.now().millisecondsSinceEpoch.toString();
      await firestore.doc(id).set({"id": id, "title": title, "body": body});
      return true;
    } catch (e) {
      
      return false;
    }
  }
}
