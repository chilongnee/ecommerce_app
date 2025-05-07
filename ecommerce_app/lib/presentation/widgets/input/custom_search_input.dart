import 'package:ecommerce_app/core/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class CustomSearchInput extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData? icon;
  final Future<List<String>> Function(String) getSuggestions;

  const CustomSearchInput({
    required this.controller,
    required this.hintText,
    this.icon,
    required this.getSuggestions,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
      child: TypeAheadFormField<String>(
        textFieldConfiguration: TextFieldConfiguration(
          controller: controller,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: AppColors.secondary),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: AppColors.primary),
            ),
            hintText: hintText,
            fillColor: AppColors.secondary,
            filled: true,
            prefixIcon: Icon(icon),
          ),
        ),
        suggestionsCallback: getSuggestions,
        itemBuilder: (context, suggestion) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 4.0),
            child: ListTile(title: Text(suggestion)),
          );
        },
        suggestionsBoxDecoration: SuggestionsBoxDecoration(
          color: AppColors.secondary,
          borderRadius: BorderRadius.circular(12),
        ),
        suggestionsBoxVerticalOffset: 0,
        onSuggestionSelected: (suggestion) {
          controller.text = suggestion;
        },
        noItemsFoundBuilder:
            (context) => Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                'Không tìm thấy kết quả nào',
                style: TextStyle(color: Colors.grey),
              ),
            ),
      ),
    );
  }
}
