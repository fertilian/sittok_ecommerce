import 'package:ecommerce_ui/Screen/Welcome/Components/login_register_btn.dart';
import 'package:flutter/material.dart';

import '../../components/background.dart';
import '../../responsive.dart';
import 'components/welcome_image.dart';

class WelcomeScreen extends StatelessWidget {
 const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Background(
      child: SingleChildScrollView(
        child: SafeArea(
          child: Responsive(
            desktop: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: WelcomeImage(

                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 450,
                        child: LoginAndRegisterBtn(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            mobile: WelcomeScreen(),
          ),
        ),
      ),
    );
  }
}


