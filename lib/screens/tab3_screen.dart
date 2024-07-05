import 'package:flutter/material.dart';
import '../widgets/custom_widget.dart';

class Tab3Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('This is Tab 3'),
          SizedBox(height: 20),
          CustomWidget(),
        ],
      ),
    );
  }
}
