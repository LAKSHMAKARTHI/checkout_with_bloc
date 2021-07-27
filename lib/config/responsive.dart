import 'package:flutter/material.dart';

class Responsive extends StatelessWidget {
  final Widget mobile;

  const Responsive({
    Key? key,
    required this.mobile
  }) : super(key: key);

  static bool isMobile(BuildContext context) => MediaQuery.of(context).size.width < 567;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints){
        if (constraints.maxWidth < 576){
          return mobile;
        } else {
          return mobile;
        }
      },
    );
  }
}

// xs < 576px => Small to large phone
// sm => 576px => Small to medium tablet
// md => 768px => Large tablet to laptop
// lg => 992px => Desktop
// xl => 1200px => 4k and ultra-wide
// xxl => 1400px or 1600 ultra-wide