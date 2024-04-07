import 'package:flutter/material.dart';

class CustomKeyboard extends StatelessWidget {
  final Function(String) onSymbolPressed;

  CustomKeyboard({super.key, required this.onSymbolPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SymbolButton(symbol: "{", onTap: onSymbolPressed),
              SymbolButton(symbol: "}", onTap: onSymbolPressed),
              SymbolButton(symbol: "[", onTap: onSymbolPressed),
              SymbolButton(symbol: "]", onTap: onSymbolPressed),
              SymbolButton(symbol: "(", onTap: onSymbolPressed),
              SymbolButton(symbol: ")", onTap: onSymbolPressed),
            ],
          ),
          // Add more rows for other symbols or keys
        ],
      ),
    );
  }
}

class SymbolButton extends StatelessWidget {
  final String symbol;
  final Function(String) onTap;

  SymbolButton({required this.symbol, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.grey,
      child: InkWell(
        onTap: () => onTap(symbol),
        child: Container(
          padding: EdgeInsets.all(12.0),
          child: Text(
            symbol,
            style: TextStyle(fontSize: 18.0),
          ),
        ),
      ),
    );
  }
}
