import 'package:flutter/material.dart';

class CardBottom extends StatelessWidget {
  //TODO: add numItems
  const CardBottom({
    @required this.order,
    @required this.categoryName,
    @required this.padding,
    @required this.value,
    @required this.onChanged,
    this.descr,
    this.height = 55,
  })  : assert(order != null),
        assert(categoryName != null),
        assert(padding != null),
        assert(value != null),
        assert(onChanged != null);

  //TODO: add numItems
  final int order;
  final String categoryName;
  final EdgeInsets padding;
  final bool value;
  final Function onChanged;
  final String descr;
  final int height;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onChanged(!value);
      },
      child: Padding(
        padding: padding,
        child: Column(
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                //TODO: if the numItems field of this item isn't 1, display a different text
                Flexible(child: Text('$categoryName #$order')),
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
    );
  }
}
