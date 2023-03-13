import 'package:get/get.dart';
import 'package:goan_market/consts/consts.dart';
import 'package:goan_market/consts/lists.dart';
import 'package:goan_market/controllers/product_controller.dart';
import 'package:goan_market/views/category_screen/item_details.dart';
import 'package:goan_market/widgets_common/bg_widget.dart';

class CategoryDetails extends StatelessWidget{
  final String? title;
  const CategoryDetails({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context){

    var controller = Get.find<ProductController>();

    return bgWidget(
      child: Scaffold(
        appBar: AppBar(
          title: title!.text.fontFamily(bold).white.make(),
        ),
        body: Container(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start ,
            children: [
              SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(controller.subcat.length,
                          (index) => "${controller.subcat[index]}"
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

              //items container

              20.heightBox,

              Expanded(child: GridView.builder(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                  itemCount: 6,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisExtent: 250,mainAxisSpacing: 8, crossAxisSpacing: 8),
                  itemBuilder: (context,index){
                    return Column(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(babyProductListImages[index],height: 150, width: 200, fit: BoxFit.fitHeight),
                        10.heightBox,
                        babyProductList[index].text.fontFamily(bold).color(darkFontGrey).make(),
                        10.heightBox,
                        babyProductListPrice[index].text.fontFamily(bold).color(Colors.red).size(16).make(),

                      ],
                    ).box.white.margin(const EdgeInsets.symmetric(horizontal: 4)).roundedSM.outerShadowSm.padding(const EdgeInsets.all(12)).make().onTap(() {
                      Get.to(()=>const ItemDetails(title: "Boys Festive & Party Dhoti & Kurta Set  (White Pack of 1)"));
                    });
              }))
            ],
          ),
        ),
      ),
    );
  }
}