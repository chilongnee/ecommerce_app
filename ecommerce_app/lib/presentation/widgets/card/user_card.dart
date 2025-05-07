import 'package:ecommerce_app/core/constants/colors.dart';
import 'package:flutter/material.dart';

class UserCard extends StatelessWidget {
  final String name;
  final String email;
  final String? imageUrl;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final bool isGridView;
  final bool isSelected;

  const UserCard({
    super.key,
    required this.name,
    required this.email,
    this.imageUrl,
    this.onTap,
    this.onLongPress,
    this.isGridView = false,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary.withOpacity(0.5) : AppColors.secondary,
          border: Border.all(
            color: isSelected ? AppColors.primary.withOpacity(0.5) : Colors.transparent,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadow.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child:
            isGridView
                ? Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child:
                            imageUrl != null && imageUrl!.isNotEmpty
                                ? Image.network(
                                  imageUrl!,
                                  width: 80,
                                  height: 80,
                                  fit: BoxFit.cover,
                                )
                                : const Icon(
                                  Icons.person,
                                  size: 80,
                                  color: Colors.grey,
                                ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        name,
                        style: const TextStyle(
                          fontSize: 14,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        email,
                        style: const TextStyle(
                          fontSize: 12,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                )
                : ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child:
                        imageUrl != null && imageUrl!.isNotEmpty
                            ? Image.network(
                              imageUrl!,
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            )
                            : const Icon(
                              Icons.person,
                              size: 50,
                              color: Colors.grey,
                            ),
                  ),
                  title: Text(
                    name,
                    style: const TextStyle(
                      fontSize: 14,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  subtitle: Text(
                    email,
                    style: const TextStyle(
                      fontSize: 12,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      color: Colors.grey,
                    ),
                  ),
                ),
      ),
    );
  }
}
