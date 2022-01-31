import 'package:bolzplatzarena.blog.app/models/navigation_item_model.dart';
import 'package:bolzplatzarena.blog.app/models/post_model.dart';
import 'package:bolzplatzarena.blog.app/models/screen_arguments.dart';
import 'package:bolzplatzarena.blog.app/services/post_service.dart';
import 'package:bolzplatzarena.blog.app/widgets/content_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:bolzplatzarena.blog.app/widgets/post_tile.dart';

class App extends StatefulWidget {
  const App({ Key? key, required this.title, required this.navigation }) : super(key: key);

  final String title;
  final List<NavigationItem> navigation;

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
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
            padding: const EdgeInsets.only(top: 50.0),
            children:
              widget.navigation.map((entry) => ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
                  leading: const Icon(Icons.view_compact, color: Colors.black87),
                  title: Text(entry.title, style: const TextStyle(fontSize: 16.0, color: Colors.black87)),
                  onTap: () {
                    // todo: how the handle this fix string
                    if(entry.title != "Startseite") {
                      // close the drawer and go the bolzplatz arena content page
                      Navigator.pop(context);
                      Navigator.pushNamed(
                        context,
                        ContentScreen.routeName,
                        arguments: ScreenArguments(
                          entry.title,
                          entry.title
                        ),
                      );
                      return;
                    }
                    setState(() {});
                    Navigator.pop(context);
                  }
              )).toList()
          ),
        ),
      ),
    );
  }
}
