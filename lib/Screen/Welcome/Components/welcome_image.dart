import 'package:flutter/material.dart';

import '../../../constants.dart';

class WelcomeImage extends StatelessWidget {
  const WelcomeImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Spacer(),
            Expanded(
              flex: 8,
              child: Container(
                width: 200,
                height: 200,
                child: Image.asset(
                  'assets/images/sittoklogo.png',
                ),
              ),
            ),
            const Spacer(),
          ],
        ),
      ],
    );
  }
}