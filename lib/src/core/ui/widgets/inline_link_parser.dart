import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class InlineLinkParser extends StatelessWidget {
  final String text;
  final void Function(String linkText)? onLinkTap;
  final TextStyle? style;
  final TextStyle? linkStyle;
  final String delimiter; // Ex: # or any other
  final Color linkColor;

  const InlineLinkParser({
    super.key,
    required this.text,
    this.onLinkTap,
    this.style,
    this.linkStyle,
    this.delimiter = '#',
    this.linkColor = Colors.green,
  });

  @override
  Widget build(BuildContext context) {
    final parts = _parseDelimitedText(text, delimiter);
    return Text.rich(
      TextSpan(
        children:
            parts.map((part) {
              if (part.isLink) {
                return TextSpan(
                  text: part.text,
                  style: linkStyle ?? TextStyle(color: linkColor),
                  recognizer:
                      TapGestureRecognizer()
                        ..onTap = () {
                          onLinkTap?.call(part.text);
                        },
                );
              } else {
                return TextSpan(text: part.text, style: style);
              }
            }).toList(),
      ),
    );
  }
}

class _LinkPart {
  final String text;
  final bool isLink;

  _LinkPart(this.text, this.isLink);
}

List<_LinkPart> _parseDelimitedText(String input, String delimiter) {
  final parts = <_LinkPart>[];
  final split = input.split(delimiter);
  for (int i = 0; i < split.length; i++) {
    parts.add(_LinkPart(split[i], i.isOdd));
  }
  return parts;
}
