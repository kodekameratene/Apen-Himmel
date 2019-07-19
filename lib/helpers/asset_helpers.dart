import 'package:apen_himmel/styles.dart';
import 'package:flutter/material.dart';

class AssetHelpers {
  static getAppBarImage() {
    return Image.asset(
      Styles.imgLogoMain,
      width: 180,
      semanticLabel: "SommerOase. 9. til 14. Juli i Fredrikstad",
      fit: BoxFit.scaleDown,
    );
  }

  static getMainSponsorImage() {
    return Image.asset(
      Styles.mainSponsor,
      height: 50,
      fit: BoxFit.fill,
      colorBlendMode: BlendMode.darken,
    );
  }
}
