import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          height: 40,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(8),
          ),
          child:  TextField(
            decoration: InputDecoration(
              hintText: 'search_hint'.tr(),
              prefixIcon: Icon(Icons.search),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(vertical: 8),
            ),
          ),
        ),
      ),
      body: GridView.builder(
        itemCount: 20, // Placeholder for demonstration
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 2,
          mainAxisSpacing: 2,
        ),
        itemBuilder: (context, index) {
          return Image.network(
            'https://via.placeholder.com/150',
            fit: BoxFit.cover,
          );
        },
      ),
    );
  }
}
