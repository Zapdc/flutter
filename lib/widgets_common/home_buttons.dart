import 'package:goan_market/consts/consts.dart';

Widget homeButtons({width,height,icon,String? title,onPress}){
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Image.asset(icon, width: 26),
      10.heightBox,
      title!.text.fontFamily(bold).color(darkFontGrey).make()
    ],
  ).box.rounded.white.size(width, height).make();
}