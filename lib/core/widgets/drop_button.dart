import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class DropButton extends StatefulWidget {
  const DropButton(
      {super.key,
        required this.lists,
        required this.selected,
        required this.hint,
        required this.onSelected});

  final List<String> lists;
  final String selected;
  final String hint;
  final ValueChanged<String> onSelected;

  @override
  State<DropButton> createState() => _DropButtonState();
}

class _DropButtonState extends State<DropButton> {
  String selectedValue = '';

  @override
  void initState() {
    selectedValue = widget.selected;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField2<String>(
      isExpanded: true,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      hint: Text(
        widget.hint,
        style: const TextStyle(fontSize: 14),
      ),
      items: widget.lists
          .map((item) => DropdownMenuItem<String>(
        value: item,
        child: Text(
          item,
          style: const TextStyle(
            fontSize: 14,
          ),
        ),
      ))
          .toList(),
      validator: (value) {
        if (value == null) {
          return 'Please select repeat.';
        }
        return null;
      },
      onChanged: (value) {
        setState(() {
          selectedValue = value!;
        });
        widget.onSelected(value!);
      },
      onSaved: (value) {
        selectedValue = value.toString();
      },
      buttonStyleData: const ButtonStyleData(
        padding: EdgeInsets.only(right: 8),
      ),
      iconStyleData: const IconStyleData(
        icon: Icon(
          Icons.arrow_drop_down,
          color: Colors.black45,
        ),
        iconSize: 24,
      ),
      dropdownStyleData: DropdownStyleData(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      menuItemStyleData: const MenuItemStyleData(
        padding: EdgeInsets.symmetric(horizontal: 16),
      ),
    );
  }
}