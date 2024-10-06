import 'package:flutter/material.dart';

// Axtarış fieldi
class SearchField extends StatelessWidget {
  final ValueChanged<String>? onChanged;
  final String text;
  const SearchField({
    super.key,
    this.onChanged, required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: text,
        prefixIcon: const Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}
