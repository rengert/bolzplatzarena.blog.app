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
                  return Text(snapshot.error!.toString() + snapshot.stackTrace!.toString());
                }
                return Column(
                  children: snapshot.data != null
                      ? snapshot.data !.map((e) => PostTile(
                    userId: 'TR',
                    blogPostId: e.id,
                    blogPostContent: e.text,
                    blogPostTitle: e.title,
                    tags: e.tags,
                    date: DateFormat("dd. MMM yyyy").format(e.date),
                  )).toList()
                      : [],
                );
              }
              else {
                return Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
                    ),
                    const Center(
                      child: CircularProgressIndicator(),
                    )
                  ],
                );
              }
            }
            ),
      ),
      drawer: Drawer(
        child: Container(
          color: Theme.of(context).primaryColor,
          child: ListView(
            padding: EdgeInsets.only(top: 50.0),
            children: <Widget>[
              ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                leading: const Icon(Icons.home, color: Colors.black87),
                title: const Text('Home', style: TextStyle(fontSize: 16.0, color: Colors.black87)),
                onTap: () {
                  setState(() {});
                  Navigator.pop(context);
                }
              ),
            ],
          ),
        ),
      ),
    );
  }
}
