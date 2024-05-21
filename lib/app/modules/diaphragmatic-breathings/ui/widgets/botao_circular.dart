import 'package:flutter/material.dart';

class BotaoCircular extends StatelessWidget {
  const BotaoCircular({
    Key? key,
    required this.metodo,
    required this.icon,
    required this.texto,
    required this.color,
  }) : super(key: key);

  final Function metodo;
  final Icon icon;
  final String texto;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => metodo(),
      child: Column(
        children: [
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100.0),
            ),
            color: color,
            child: Ink(
              child: Padding(padding: const EdgeInsets.all(16.0), child: icon),
            ),
          ),
          Text(
            texto,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}