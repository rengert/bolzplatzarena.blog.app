import 'package:bolzplatzarena.blog.app/models/navigation_item_model.dart';
import 'package:bolzplatzarena.blog.app/services/navigation_service.dart';
import 'package:bolzplatzarena.blog.app/widgets/app.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bolzplatzarena',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: const LoadingPage(title: 'Bolzplatzarena'),
    );
  }
}

class LoadingPage extends StatefulWidget {
  const LoadingPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<NavigationItem>>(
          future: getNavigation(),
          builder: (context, snapshot) {
              if(snapshot.connectionState == ConnectionState.done) {
                if(snapshot.hasError){
                  return Text(snapshot.error!.toString() + snapshot.stackTrace!.toString());
                }
                return App(title: widget.title, navigation: snapshot.data!);
              }
              else {
                return Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 150.0),
                    ),
                    Center(
                      child: Column(
                          children: [
                            const CircularProgressIndicator(),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 15.0),
                              child: const Text('Die Bolzplatzarena wird vorbereitet.'),
                            )
                          ],
                      )
                    )
                  ],
                );
              }
            }
      )
    );
  }
}


