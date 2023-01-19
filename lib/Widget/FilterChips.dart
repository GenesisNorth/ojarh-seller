import 'package:flutter/material.dart';
import '../Helper/Color.dart';
import '../Model/Attribute Models/AttributeValueModel/AttributeValue.dart';

class filterChipWidget extends StatefulWidget {
  final AttributeValueModel? chipName;
  final List<AttributeValueModel>? selectedList;
  final Function? update;

  const filterChipWidget(
      {Key? key, this.chipName, this.selectedList, this.update})
      : super(key: key);

  @override
  _filterChipWidgetState createState() => _filterChipWidgetState();
}

class _filterChipWidgetState extends State<filterChipWidget> {
  bool _isSelected = false;

  @override
  void initState() {
    for (var element in widget.selectedList!) {
      if (element.status == "1" && element == widget.chipName) {
        _isSelected = true;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(
        widget.chipName!.value.toString(),
      ),
      labelStyle: const TextStyle(
        color: white,
        fontSize: 16.0,
        fontWeight: FontWeight.bold,
      ),
      selected: _isSelected,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      backgroundColor: primary,
      onSelected: (isSelected) {
        setState(
          () {
            _isSelected = isSelected;
            if (_isSelected) {
              widget.selectedList!.add(widget.chipName!);
            } else {
              widget.selectedList!.removeWhere(
                (element) => element == widget.chipName!,
              );
            }
            widget.update!((){});
          },
        );
      },
      selectedColor: secondary,
    );
  }
}
