import 'package:flutter/material.dart';
import '../widgets/custom_widget.dart';

class Tab1Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('This is Tab 1'),
          SizedBox(height: 20),
          CustomWidget(),
        ],
      ),
    );
  }
}
