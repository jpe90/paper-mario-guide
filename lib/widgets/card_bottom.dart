import 'package:flutter/material.dart';

class CardBottom extends StatelessWidget {
  const CardBottom({
    @required this.id,
    @required this.categoryName,
    @required this.padding,
    @required this.value,
    @required this.onChanged,
    this.descr,
  });

  final int id;
  final String categoryName;
  final EdgeInsets padding;
  final bool value;
  final Function onChanged;
  final String descr;

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
          child: ListView(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text('$categoryName #$id'),
                  if (descr != null)
                    RaisedButton(onPressed: () {}, child: Text('Notes')),
                  Checkbox(
                    value: value,
                    onChanged: (bool newValue) {
                      onChanged(newValue);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
