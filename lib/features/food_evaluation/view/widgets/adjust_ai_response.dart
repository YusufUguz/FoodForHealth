import 'package:flutter/material.dart';

class AdjustAIResponse extends StatelessWidget {
  final String text;

  const AdjustAIResponse({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: TextStyle(color: Colors.black, fontSize: 15),
        children: parseBoldText(text),
      ),
    );
  }

  List<TextSpan> parseBoldText(String text) {
    final regex = RegExp(r"\*\*(.*?)\*\*");
    final matches = regex.allMatches(text);

    int lastMatchEnd = 0;
    List<TextSpan> spans = [];

    for (final match in matches) {
      if (lastMatchEnd < match.start) {
        spans.add(TextSpan(text: text.substring(lastMatchEnd, match.start)));
      }

      spans.add(TextSpan(
        text: match.group(1),
        style: TextStyle(fontWeight: FontWeight.bold),
      ));

      lastMatchEnd = match.end;
    }

    if (lastMatchEnd < text.length) {
      spans.add(TextSpan(text: text.substring(lastMatchEnd)));
    }

    return spans;
  }
}
