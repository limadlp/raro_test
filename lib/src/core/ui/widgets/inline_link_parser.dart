import 'package:base_project/src/core/ui/tokens/app_colors.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class InlineLinkParser extends StatelessWidget {
  final String text;
  final void Function(String linkText)? onLinkTap;
  final TextStyle? style;
  final TextStyle? linkStyle;
  final String delimiter;
  final Color linkColor;
  final bool linkDisabled;
  final double fontSize;

  const InlineLinkParser({
    super.key,
    required this.text,
    this.onLinkTap,
    this.style,
    this.linkStyle,
    this.delimiter = '#',
    this.linkColor = AppColors.link,
    this.linkDisabled = false,
    this.fontSize = 16.0,
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
                  style:
                      linkStyle ??
                      TextStyle(
                        color:
                            !linkDisabled ? linkColor : AppColors.textDisabled,
                        fontSize: fontSize,
                      ),
                  recognizer:
                      !linkDisabled && onLinkTap != null
                          ? (TapGestureRecognizer()
                            ..onTap = () => onLinkTap!(part.text))
                          : null,
                );
              } else {
                return TextSpan(
                  text: part.text,
                  style:
                      style?.copyWith(fontSize: fontSize) ??
                      TextStyle(fontSize: fontSize),
                );
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
