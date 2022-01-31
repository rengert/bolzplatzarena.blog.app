import 'package:flutter/material.dart';

class CodeBlock extends StatefulWidget {
  final String rawCode;
  final String fileName;
  final String language;

  const CodeBlock({Key? key,
    required this.rawCode,
    required this.fileName,
    required this.language,
  }) : super(key: key);

  @override
  _CodeBlockState createState() => _CodeBlockState();
}

class _CodeBlockState extends State<CodeBlock> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
        child: Text(widget.rawCode),
        decoration: const BoxDecoration(
          border: Border(
            left: BorderSide(width: 5, color: Colors.grey)
          )
        ),
    );
  }
}