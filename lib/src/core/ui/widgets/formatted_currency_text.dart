import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FormattedCurrencyText extends StatelessWidget {
  final double value;
  final String fallback;

  const FormattedCurrencyText({
    super.key,
    required this.value,
    this.fallback = '--',
  });

  @override
  Widget build(BuildContext context) {
    if (value == 0.0) {
      return Text(fallback);
    }

    final formatter = NumberFormat.currency(
      locale: 'en_US',
      symbol: '',
      decimalDigits: 2,
    );

    final formattedValue = formatter.format(value);

    return RichText(
      text: TextSpan(
        style: DefaultTextStyle.of(
          context,
        ).style.copyWith(fontSize: 16, fontWeight: FontWeight.w500),
        children: [
          WidgetSpan(
            alignment: PlaceholderAlignment.top,
            child: Transform.translate(
              offset: const Offset(0, 0),
              child: Text('\$', style: const TextStyle(fontSize: 10)),
            ),
          ),
          TextSpan(text: formattedValue),
        ],
      ),
    );
  }
}
