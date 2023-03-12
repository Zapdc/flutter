import 'package:goan_market/consts/consts.dart';

Widget detailsCard({height,width, String? count, String? title}){
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      count!.text.fontFamily(bold).color(darkFontGrey).size(16).make(),
      2.heightBox,
      title!.text.color(darkFontGrey).make(),
    ],
  ).box.white.rounded.width(width).height(height).padding(const EdgeInsets.all(4)).shadowSm.make();
}