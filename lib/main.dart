import 'package:bolzplatzarena.blog.app/services/post_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:bolzplatzarena.blog.app/widgets/post_tile.dart';

import 'models/post_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: const MyHomePage(title: 'Bolzplatzarena'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: FutureBuilder<List<Post>>(
            future: getPosts(),
            builder: (context, snapshot) {
              if(snapshot.connectionState == ConnectionState.done) {
                if(snapshot.hasError){
                  return const Text("Error");
                }
                return Column(
                  children: snapshot.data != null
                      ? snapshot.data !.map((e) => PostTile(
                    userId: 'TR',
                    blogPostId: e.title,
                    blogPostContent: e.title,
                    blogPostTitle: e.title,
                    date: DateFormat("dd. MMM yyyy").format(e.date),
                  )).toList()
                      : [],
                );
              }
              else {
                return const CircularProgressIndicator();
              }
            }
            ),
      )
    );
  }
}
