import 'package:ecommerce_app/core/constants/colors.dart';
import 'package:flutter/material.dart';

class SortButton extends StatefulWidget {
  const SortButton({super.key});

  @override
  State<SortButton> createState() => _SortButtonState();
}

class _SortButtonState extends State<SortButton> {
  String selectedSort = 'A-Z';
  final List<String> sortOptions = ['A-Z', 'Z-A', 'Mới nhất', 'Cũ nhất'];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 30,
          margin: EdgeInsets.only(left: 20),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.borderGrey),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                alignment: Alignment.center,
                child: Text(
                  "Sắp xếp",
                  style: TextStyle(
                    fontSize: 10,
                    color: AppColors.textGrey,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Container(
                height: double.infinity,
                decoration: BoxDecoration(
                  border: Border(left: BorderSide(color: AppColors.borderGrey)),
                ),
                padding: EdgeInsets.symmetric(horizontal: 5),
                alignment: Alignment.center,
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: selectedSort,
                    isDense: true,
                    icon: Icon(Icons.arrow_drop_down, size: 14),
                    alignment: Alignment.center,
                    style: TextStyle(
                      fontSize: 10,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                    items:
                        sortOptions.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: TextStyle(
                                fontSize: 10,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          );
                        }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        selectedSort = newValue!;
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
