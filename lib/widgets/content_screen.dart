import 'package:bolzplatzarena.blog.app/models/post_model.dart';
import 'package:bolzplatzarena.blog.app/models/screen_arguments.dart';
import 'package:bolzplatzarena.blog.app/services/post_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class ContentScreen extends StatelessWidget {
  const ContentScreen({Key? key}) : super(key: key);

  static const routeName = '/content';

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute
        .of(context)!
        .settings
        .arguments as ScreenArguments;

    return Scaffold(
      appBar: AppBar(
        title: Text(args.title),
      ),
      body: SingleChildScrollView(
        child: FutureBuilder<Post>(
            future: getPost(args.id),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError || snapshot.data == null) {
                  return Text(snapshot.error!.toString() +
                      snapshot.stackTrace!.toString());
                }
                final Post post = snapshot.data !;
                return Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 10.0),
                    child: Column(
                      children: [
                        Text(post.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0)),
                        ...post.blocks.map((e) =>
                            Html(
                              data: e.body,
                              style: {
                                '*': Style(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 0, horizontal: 0),
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 0, horizontal: 0),
                                ),
                                'p': Style(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 0),
                                    textAlign: TextAlign.justify
                                ),
                                'pre': Style(
                                  textAlign: TextAlign.left,
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 10),
                                  border: const Border(left: BorderSide(
                                      color: Colors.grey,
                                      width: 5
                                  ))
                                ),
                              },
                            )
                        ).toList()
                      ],
                    )
                );
              } else {
                return Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 15.0),
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
    );
  }
}
