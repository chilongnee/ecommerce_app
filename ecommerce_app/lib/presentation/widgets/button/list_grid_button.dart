import 'package:ecommerce_app/core/constants/colors.dart';
import 'package:flutter/material.dart';

class ListGridButton extends StatefulWidget {
  final bool isGridView;
  final Function(bool) onToggleView;

  const ListGridButton({
    super.key,
    required this.isGridView,
    required this.onToggleView,
  });

  @override
  State<ListGridButton> createState() => _ListGridButtonState();
}

class _ListGridButtonState extends State<ListGridButton> {
  late bool _isGridView;

  @override
  void initState() {
    super.initState();
    _isGridView = widget.isGridView;
  }

  void _toggleView(bool gridView) {
    setState(() {
      _isGridView = gridView;
    });
    widget.onToggleView(_isGridView);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: Container(
        height: 30,
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.borderGrey),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            GestureDetector(
              onTap: () => _toggleView(false),
              child: Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                  border: Border(right: BorderSide(color: AppColors.borderGrey)),
                ),
                alignment: Alignment.center,
                child: Icon(
                  Icons.list,
                  size: 20,
                  color: !_isGridView ? AppColors.primary : AppColors.textGrey,
                ),
              ),
            ),
            GestureDetector(
              onTap: () => _toggleView(true),
              child: Container(
                height: 30,
                width: 30,
                alignment: Alignment.center,
                child: Icon(
                  Icons.grid_view,
                  size: 20,
                  color: _isGridView ? AppColors.primary : AppColors.textGrey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
