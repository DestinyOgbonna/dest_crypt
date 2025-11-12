import 'package:dest_crypt/src/utils/styles/styles.dart';
import 'package:flutter/material.dart';

class NumericButton extends StatelessWidget {
  final String buttonText;
  final double buttonHeight;

  final Function buttonPressed;

  const NumericButton(
    this.buttonText,
    this.buttonHeight,
    this.buttonPressed, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.08 * buttonHeight,
      child: TextButton(
        style: TextButton.styleFrom(
          shape: const CircleBorder(),
          padding: const EdgeInsets.all(16.0),
        ),
        onPressed: () => buttonPressed(buttonText),
        child: Text(buttonText, style: AppStyles.blackBold24),
      ),
    );
  }
}
