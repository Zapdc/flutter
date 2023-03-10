import 'package:goan_market/consts/consts.dart';
import 'package:goan_market/widgets_common/bg_widget.dart';

class CategoryDetails extends StatelessWidget{
  final String? title;
  const CategoryDetails({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return bgWidget(
      child: Scaffold(
        appBar: AppBar(
          title: title!.text.fontFamily(bold).white.make(),
        ),
        body: Container(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(6,
                          (index) => "Baby Clothing"
                              .text
                              .size(12)
                              .fontFamily(bold)
                              .color(darkFontGrey)
                              .makeCentered()
                              .box
                              .white
                              .rounded
                              .size(120, 60)
                              .margin(const EdgeInsets.symmetric(horizontal: 4))
                              .make()),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}