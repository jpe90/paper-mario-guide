import 'package:flutter/material.dart';

class CardBottom extends StatelessWidget {
  const CardBottom({
    this.id,
    this.categoryName,
    this.padding,
    this.value,
    this.onChanged,
  });

  final int id;
  final String categoryName;
  final EdgeInsets padding;
  final bool value;
  final Function onChanged;

  void onCheckboxChanged(int id) {
    // setState(() {
    //   repository.setCompletionStatus(id);
    // });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onChanged(!value);
      },
      child: Padding(
        padding: padding,
        child: Container(
          height: 55,
          child: Row(
            children: <Widget>[
              Expanded(
                child: Text('$categoryName #$id'),
              ),
              Checkbox(
                value: value,
                onChanged: (bool newValue) {
                  onChanged(newValue);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
