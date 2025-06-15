import 'package:flutter/material.dart';

class EmptyState extends StatelessWidget {
  const EmptyState({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.event_note_sharp,
            size: 62,
            color: Colors.white,
          ),
          Text(
            'No Notes',
            style: TextStyle(fontSize: 46, color: Colors.white),
          )
        ],
      ),
    );
  }
}
