import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import '../widgets/custom_widget.dart';

class Tab2Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('This is Tab 2'),
          SizedBox(height: 20),
          CustomWidget(),
        ],
      ),
    );
  }
}
