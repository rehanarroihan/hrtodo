import 'package:flutter/material.dart';

class EmptyState extends StatelessWidget {
  final String imagePath;
  final String title;
  final String description;

  const EmptyState({
    super.key,
    required this.imagePath,
    required this.title,
    required this.description
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: MediaQuery.of(context).size.height * 0.06),

        Image(
          height: MediaQuery.of(context).size.height * 0.3,
          image: AssetImage(imagePath),
        ),

        const SizedBox(height: 24),

        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500
          ),
        ),
        Text(description,),
      ],
    );
  }
}
