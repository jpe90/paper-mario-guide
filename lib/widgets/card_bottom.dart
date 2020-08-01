import 'package:flutter/material.dart';

class CardBottom extends StatelessWidget {
  const CardBottom({
    @required this.id,
    @required this.categoryName,
    @required this.padding,
    @required this.value,
    @required this.onChanged,
    this.descr,
    this.height = 55,
  })  : assert(id != null),
        assert(categoryName != null),
        assert(padding != null),
        assert(value != null),
        assert(onChanged != null);

  final int id;
  final String categoryName;
  final EdgeInsets padding;
  final bool value;
  final Function onChanged;
  final String descr;
  final int height;

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
                  Checkbox(
                    value: value,
                    onChanged: (bool newValue) {
                      onChanged(newValue);
                    },
                  ),
                ],
              ),
              if (descr != null) Text(descr)
            ],
          ),
        ),
      ),
    );
  }
}
