import 'package:get/get.dart';
import 'package:goan_market/consts/consts.dart';
import 'package:goan_market/consts/lists.dart';
import 'package:goan_market/controllers/product_controller.dart';
import 'package:goan_market/views/chat_screen/chat_screen.dart';
import 'package:goan_market/widgets_common/our_button.dart';


class ItemDetails extends StatelessWidget {
  final String? title;
  final dynamic data;
  const ItemDetails({Key? key, required this.title,this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProductController());
    
    return WillPopScope(
      onWillPop: () async{
        controller.resetValues();
        return true;
      },
      child: Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          leading: IconButton(onPressed: (){
            controller.resetValues();
            Get.back();
          },
            icon: const Icon(Icons.arrow_back),
          ),
          title: title!.text.color(darkFontGrey).fontFamily(bold).make(),
          actions: [
            IconButton(onPressed: (){}, icon: const Icon(Icons.share)),
            Obx(()=>IconButton(
                  onPressed: (){
                if(controller.isFav.value){
                  controller.removeFromWishList(data.id, context);
                  controller.isFav(false);
                }else{
                  controller.addToWishList(data.id, context);
                  controller.isFav(true);
                }

              },
                  icon: Icon(Icons.favorite,
                  color: controller.isFav.value ? Colors.red : darkFontGrey,
                  )),
            ),

          ],
        ),
        body: Column(
          children: [
            Expanded(child: Padding(
              padding: const EdgeInsets.all(8),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //swiper section
                    VxSwiper.builder(
                      autoPlay: true,
                        height: 350,
                        itemCount: data['p_imgs'].length,aspectRatio: 16/9,
                        viewportFraction: 1.0,
                        itemBuilder: (context,index){
                      return Image.network(data["p_imgs"][index],
                        width: double.infinity,
                        fit: BoxFit.cover,
                      );
                    }),

                    10.heightBox,
                    //title and details section
                    title!.text.size(18).color(darkFontGrey).fontFamily(bold).make(),
                    10.heightBox,
                    //ratings
                    VxRating(
                      isSelectable: false,
                      value: double.parse(data['p_rating']),
                        onRatingUpdate: (value){},
                      normalColor: textfieldGrey,
                      selectionColor: golden,
                      count: 5,
                        maxRating: 5,
                      size: 25),

                    10.heightBox,
                    "${data['p_price']}".numCurrency .text.color(Colors.red).fontFamily(bold).size(18).make(),


                    10.heightBox,
                    Row(
                      children: [
                        Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            "Seller".text.white.fontFamily(bold).make(),
                            5.heightBox,
                            "${data['p_seller']}".text.fontFamily(bold).color(darkFontGrey).size(16).make()
                          ],
                        )),
                        const CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Icon(Icons.message_rounded, color: darkFontGrey),
                        ).onTap(() {
                          Get.to(()=>const ChatScreen(),
                            arguments: [data['p_seller'], data['vendor_id']],
                          );
                        })
                      ],
                    ).box.height(60).padding(const EdgeInsets.symmetric(horizontal: 16)).color(textfieldGrey).make(),

                    //color section
                    20.heightBox,
                    Obx(()=> Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: 100,
                                child: "Color: ".text.color(textfieldGrey).make(),
                              ),
                              Row(
                                children: List.generate(
                                    data['p_colors'].length, (index) => Stack(
                                  alignment: Alignment.center,
                                      children: [
                                        VxBox()
                                        .size(40, 40)
                                        .roundedFull
                                        .color(Color(data['p_colors'][index]).withOpacity(1.0))
                                        .margin(const EdgeInsets.symmetric(horizontal: 4))
                                        .make().onTap(() {
                                          controller.changeColorIndex(index);
                                        }),
                                         Visibility(
                                          visible: index == controller.colorIndex.value,
                                            child: const Icon(Icons.done, color: Colors.white))
                                      ],
                                    )),
                              ),
                            ],
                          ).box.padding(const EdgeInsets.all(8)).make(),

                          //quantity row
                          Row(
                            children: [
                              SizedBox(
                                width: 100,
                                child: "Quantity: ".text.color(textfieldGrey).make(),
                              ),
                              Obx(()=> Row(
                                  children: [
                                    IconButton(onPressed: (){
                                      controller.decreaseQuantity();
                                      controller.calculateTotalPrice(int.parse(data['p_price']));
                                    }, icon: const Icon(Icons.remove)),
                                    controller.quantity.value.text.size(16).color(darkFontGrey).fontFamily(bold).make(),
                                    IconButton(onPressed: (){
                                      controller.increaseQuantity(int.parse(data['p_quantity']));
                                      controller.calculateTotalPrice(int.parse(data['p_price']));
                                    }, icon: const Icon(Icons.add)),
                                    10.widthBox,
                                    "(${data['p_quantity']} available)".text.color(textfieldGrey).make(),
                                  ],
                                ),
                              ),
                            ],
                          ).box.padding(const EdgeInsets.all(8)).make(),

                          //total row
                          Row(
                            children: [
                              SizedBox(
                                width: 100,
                                child: "Total: ".text.color(textfieldGrey).make(),
                              ),
                              "${controller.totalPrice.value}".numCurrency.text.color(Colors.red).size(16).fontFamily(bold).make(),
                            ],
                          ).box.padding(const EdgeInsets.all(8)).make(),
                        ],
                      ).box.white.shadowSm.make(),
                    ),

                    //description section
                    10.heightBox,
                    "Description".text.color(darkFontGrey).fontFamily(bold).make(),
                    10.heightBox,
                    "${data['p_desc']}".text.color(darkFontGrey).make(),

                    //buttons section
                    10.heightBox,
                    ListView(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      children: List.generate(itemDetailButtonsList.length, (index) => ListTile(
                        title: itemDetailButtonsList[index].text.fontFamily(bold).color(darkFontGrey).make(),
                        trailing: const Icon(Icons.arrow_forward),
                      ),),
                    ),

                    20.heightBox,
                    //product may like section
                    productsyoumaylike.text.fontFamily(bold).size(16).color(darkFontGrey).make(),
                    10.heightBox,
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(6, (index) => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(babyClothsListImages[index],height: 110, width: 150, fit: BoxFit.cover,),
                            10.heightBox,
                            babyClothstList[index].text.fontFamily(bold).color(darkFontGrey).align(TextAlign.center).make(),
                            10.heightBox,
                            babyClothsListPrice[index].text.fontFamily(bold).color(Colors.red).size(16).align(TextAlign.center).make()
                          ],
                        ).box.white.margin(const EdgeInsets.symmetric(horizontal: 4)).roundedSM.padding(const EdgeInsets.all(8)).make()),
                      ),
                    ),
                ],
                ),
              ),
            )),
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ourButton(
                color: Colors.redAccent,
                onPress: (){
                  if(controller.quantity.value > 0){
                    controller.addToCart(
                        color: data['p_colors'][controller.colorIndex.value],
                        context: context,
                        vendorID: data['vendor_id'],
                        img: data['p_imgs'][0],
                        qty: controller.quantity.value,
                        sellername: data['p_seller'],
                        title: data['p_name'],
                        tprice: controller.totalPrice.value);
                    VxToast.show(context, msg: "Added to cart");
                  }else{
                    VxToast.show(context, msg: "Quantity can't be zero");
                  }
                },
                textColor: whiteColor,
                title: "Add to Cart"
              ),
            ),
          ],
        ),
      ),
    );
  }
}
