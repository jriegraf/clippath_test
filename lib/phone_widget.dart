import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:svg_path_parser/svg_path_parser.dart';

class PhoneWidget extends StatelessWidget {
  const PhoneWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Widget svgPhoneWidget = SvgPicture.asset('assets/phone_frame.svg');
    const originalSize = Size(329.555, 714.149);

    // Only looks good for Size = originalSize but if you simulate smaller screen
    // with a smaller SizedBox, the ClipPath does not scale down.
    Size phoneSize = originalSize * 0.9;

    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return Center(
          child: SizedBox.fromSize(
              size: phoneSize,
              child: Stack(alignment: Alignment.center, children: [
                svgPhoneWidget,
                ClipPath(
                  clipper: CustomClipPath(),
                  child: Container(color: Colors.red),
                )
              ])));
    });
  }
}

class CustomClipPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    const double factor = 0.86;
    const Offset offset = Offset(27.3, 58.7);
    Path path = parseSvgPath(
        'M 329.2 683.2 A 30.7 30.7 0 0 1 298.6 713.9 H 30.6 A 30.7 30.7 0 0 1 -0.1 683.2 V 30.7 A 30.7 30.7 0 0 1 30.6 0 H 70.5 V 8.4 A 17.4 17.4 0 0 0 87.8 25.7 H 241.4 A 17.4 17.4 0 0 0 258.6 8.4 V 0 H 298.4 A 30.7 30.7 0 0 1 329 30.7 V 683.2 M 329 683.2');
    final matrix = sizeToRect(size, offset * factor & size * factor);
    return path.transform(matrix.storage);
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;

  Matrix4 sizeToRect(Size src, Rect dst,
      {BoxFit fit = BoxFit.contain, Alignment alignment = Alignment.center}) {
    FittedSizes fs = applyBoxFit(fit, src, dst.size);
    double scaleX = fs.destination.width / fs.source.width;
    double scaleY = fs.destination.height / fs.source.height;
    Size fittedSrc = Size(src.width * scaleX, src.height * scaleY);
    Rect out = alignment.inscribe(fittedSrc, dst);

    return Matrix4.identity()
      ..translate(out.left, out.top)
      ..scale(scaleX, scaleY);
  }
}
