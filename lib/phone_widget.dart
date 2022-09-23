import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:svg_path_parser/svg_path_parser.dart';

class PhoneWidget extends StatelessWidget {
  const PhoneWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const String assetName = 'assets/phone_frame.svg';
    final Widget svgPhoneWidget = SvgPicture.asset(assetName);

    return Scaffold(body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return Center(
          child: SizedBox(
              // height: 800,
              // width: 400,
              child: Stack(children: [
        svgPhoneWidget,
        SizedBox(
          width: 380,
          child: ClipPath(
            clipper: CustomClipPath(),
            child: Container(
              color: Colors.red,
            ),
          ),
        )
      ])));
    }));
  }
}

class CustomClipPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = parseSvgPath(
        'M 329.22 683.218 a 30.686 30.686 0 0 1 -30.645 30.672 h -268 a 30.686 30.686 0 0 1 -30.645 -30.672 V 30.682 a 30.69 30.69 0 0 1 30.645 -30.676 h 39.93 v 8.367 a 17.369 17.369 0 0 0 17.273 17.289 H 241.372 a 17.369 17.369 0 0 0 17.273 -17.289 V 0.007 H 298.391 a 30.692 30.692 0 0 1 30.645 30.676 V 683.218 m 0 0');
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
