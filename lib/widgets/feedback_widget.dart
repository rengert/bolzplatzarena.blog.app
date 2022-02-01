import 'package:bolzplatzarena.blog.app/services/feedback_service.dart';
import 'package:flutter/material.dart';

class FeedbackWidget extends StatefulWidget {
  final String slug;

  const FeedbackWidget({
    Key? key,
    required this.slug,
  }) : super(key: key);

  @override
  _FeedbackWidgetState createState() => _FeedbackWidgetState();
}

class _FeedbackWidgetState extends State<FeedbackWidget> {
  final _formKey = GlobalKey<FormState>();

  String name = "";
  String comment = "";

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const Text(
              "Feedback",
              textAlign: TextAlign.left,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0)
          ),
          TextFormField(
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Dein Name',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Einen Namen, der wir gern anzeigen würden.';
              }
              return null;
            },
            onFieldSubmitted: (value) {
              setState(() {
                name = value;
              });
            },
          ),
          TextFormField(
            maxLines: 5,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Dein Kommentar',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Ohne Kommentar macht das hier keinen Sinn.';
              }
              return null;
            },
            onFieldSubmitted: (value) {
              setState(() {
                comment = value;
              });
            },
          ),
          ElevatedButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                if(await sendFeedback(widget.slug, name, comment)) {
                  _formKey.currentState?.reset();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Vielen Dank für Ihren Kommentar dieser wird geprüft und schnellstmöglich veröffentlicht')),
                  );
                  return;
                }
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Daten konnten nicht verschickt werden.')),
                );
                return;
              }
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Bitte Daten eingeben.')),
              );
            },
            child: const Text('Kommentar senden'),
          ),
        ],
      ),
    );
  }
}