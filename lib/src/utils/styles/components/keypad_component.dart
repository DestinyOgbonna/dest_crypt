import 'package:dest_crypt/src/utils/styles/components/numeric_button.dart';
import 'package:flutter/material.dart';

class NumericKeypad extends StatelessWidget {
  final Function(String) onPressed;
  final bool isHome;

  const NumericKeypad({super.key, required this.onPressed, this.isHome = false});

  Widget setButton(String buttonText, double buttonHeight, Color buttonColor) {
    return NumericButton(buttonText, buttonHeight, onPressed);
  }

  TableRow generateTableRow(List<String> buttonTexts) {
    return TableRow(
      children: buttonTexts
          .map((text) => setButton(text, 1, Colors.black54))
          .toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 401,
      height: isHome ? 330 : 610,
      padding: const EdgeInsets.symmetric(),
      child: Table(
        defaultVerticalAlignment: TableCellVerticalAlignment.bottom,
        children: [
          generateTableRow(["1", "2", "3"]),
          generateTableRow(["4", "5", "6"]),
          generateTableRow(["7", "8", "9"]),
          TableRow(
            children: [
              setButton(".", 1, Colors.black54),
              setButton("0", 1, Colors.black54),
              Padding(
                padding: const EdgeInsets.only(
                  left: 15.0,
                  bottom: 10,
                  right: 13,
                ),
                child: IconButton(
                  onPressed: () {
                    onPressed("");
                  },
                  icon: const Icon(
                    Icons.backspace_outlined,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
