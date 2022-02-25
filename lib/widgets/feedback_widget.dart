import 'package:bolzplatzarena.blog.app/models/feedback_model.dart' as feedback_model;
import 'package:bolzplatzarena.blog.app/services/feedback_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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

  final name = TextEditingController();
  final comment = TextEditingController();

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
          FutureBuilder<List<feedback_model.Feedback>>(
              future: getFeedbacks(),
              builder: (context, snapshot) {
                if(snapshot.connectionState == ConnectionState.done) {
                  if(snapshot.hasError){
                    return Text(snapshot.error!.toString() + snapshot.stackTrace!.toString());
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: snapshot.data !.map((feedback) =>
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                              '${feedback.author} (${DateFormat("dd. MMM yyyy").format(feedback.created)})',
                              textAlign: TextAlign.left,
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12.0)
                          ),
                          Text(
                              feedback.comment,
                              textAlign: TextAlign.left,
                              style: const TextStyle(fontSize: 12.0)
                          ),
                        ],
                      ),
                    ).toList(),
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
          const Text(
              "Feedback geben",
              textAlign: TextAlign.left,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0)
          ),
          TextFormField(
            controller: name,
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
          ),
          TextFormField(
            controller: comment,
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
          ),
          ElevatedButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                if(await sendFeedback(widget.slug, name.value.text, comment.value.text)) {
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