import 'package:flutter/material.dart';

import '../components/header_footer.dart';

class MyHomeScreen extends StatefulWidget {
  const MyHomeScreen({super.key});

  @override
  State<MyHomeScreen> createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //Header de la pantalla principal
        const MyHeader(),
        //Body
        Container(
            // color: Colors.amber,
            // height: double.infinity,
            // width: double.infinity,
            ),
        //Footer
        const MyFooter(),
      ],
    );
  }
}
