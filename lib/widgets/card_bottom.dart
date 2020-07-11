import 'package:flutter/material.dart';

class CardBottom extends StatelessWidget {
  const CardBottom({
    this.id,
    this.padding,
    this.value,
    this.onChanged,
  });

  final int id;
  final EdgeInsets padding;
  final bool value;
  final Function onChanged;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onChanged(!value);
      },
      child: Padding(
        padding: padding,
        child: Row(
          children: <Widget>[
            Icon(
              Icons.home,
              color: Theme.of(context).primaryColor,
            ),
            Expanded(child: Text(id.toString())),
            Checkbox(
              value: value,
              onChanged: (bool newValue) {
                onChanged(newValue);
              },
            ),
          ],
        ),
      ),
    );
  }
}
