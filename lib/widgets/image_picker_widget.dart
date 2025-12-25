import 'dart:io';
import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class ImagePickerWidget extends StatelessWidget {
  final String? imagePath;
  final String name;
  final String email;
  final String phone;
  final VoidCallback onTap;

  static const String _defaultImagePath = 'assets/images/Photos_contact.png';

  const ImagePickerWidget({
    Key? key,
    required this.imagePath,
    required this.name,
    required this.email,
    required this.phone,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: 143,
            height: 146,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFFFF1D4)),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: imagePath != null
                  ? Image.file(
                      File(imagePath!),
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Image.asset(
                        _defaultImagePath,
                        fit: BoxFit.cover,
                      ),
                    )
                  : Image.asset(
                      _defaultImagePath,
                      fit: BoxFit.cover,
                    ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name.isNotEmpty ? name : 'User Name',
                style: const TextStyle(
                  color: AppColors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                email.isNotEmpty ? email : 'example@email.com',
                style: const TextStyle(color: AppColors.white70, fontSize: 14),
              ),
              const SizedBox(height: 2),
              Text(
                phone.isNotEmpty ? phone : '+200000000000',
                style: const TextStyle(color: AppColors.white70, fontSize: 14),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
