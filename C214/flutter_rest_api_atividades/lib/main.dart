import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<Comments> fetchComments() async {
  final response = await http
      .get(Uri.parse('https://jsonplaceholder.typicode.com/comments/4'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Comments.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

class Comments {
  final int postId;
  final int id;
  final String name;
  final String email;
  final String body;

  const Comments({
    required this.postId,
    required this.id,
    required this.name,
    required this.email,
    required this.body,
  });

  factory Comments.fromJson(Map<String, dynamic> json) {
    return Comments(
      postId: json['postId'],
      id: json['id'],
      name: json['name'],
      email: json['email'],
      body: json['body'],
    );
  }
}

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<Comments> futureComments;

  @override
  void initState() {
    super.initState();
    futureComments = fetchComments();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Fetch Data Example'),
        ),
        body: Center(
          child: Column(
            children: [
              Row(
                children: [
                   Container(
                    child: const Text(
                      "Name: ",
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 20, color: Colors.blue),
                      softWrap: false,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                  FutureBuilder<Comments>(
                    future: futureComments,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Text(
                          snapshot.data!.name,
                          style: const TextStyle(fontSize: 12),
                          softWrap: false,
                          overflow: TextOverflow.fade,
                        );
                      } else if (snapshot.hasError) {
                        return Text('${snapshot.error}');
                      }

                      // By default, show a loading spinner.
                      return const CircularProgressIndicator();
                    },
                  ),
                ]
              ),
              Row(
                children: [
                   Container(
                    child: const Text(
                      "Email: ",
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 20, color: Colors.blue),
                      softWrap: false,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                  FutureBuilder<Comments>(
                    future: futureComments,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Text(
                          snapshot.data!.email,
                          style: const TextStyle(fontSize: 12),
                          softWrap: false,
                          overflow: TextOverflow.fade,
                        );
                      } else if (snapshot.hasError) {
                        return Text('${snapshot.error}');
                      }

                      // By default, show a loading spinner.
                      return const CircularProgressIndicator();
                    },
                  ),
                ]
              ),
              Row(
                children: [
                   Container(
                    child: const Text(
                      "Body: ",
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 20, color: Colors.blue),
                      softWrap: false,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                  FutureBuilder<Comments>(
                    future: futureComments,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Text(
                          snapshot.data!.body,
                          style: const TextStyle(fontSize: 12),
                          softWrap: false,
                          overflow: TextOverflow.fade,
                        );
                      } else if (snapshot.hasError) {
                        return Text('${snapshot.error}');
                      }

                      // By default, show a loading spinner.
                      return const CircularProgressIndicator();
                    },
                  ),
                ]
              ),
            ]            
          ),
        ),
      ),
    );
  }
}
