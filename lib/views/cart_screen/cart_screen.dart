import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:goan_market/consts/consts.dart';
import 'package:goan_market/controllers/cart_controller.dart';
import 'package:goan_market/views/cart_screen/shipping_screen.dart';
import 'package:goan_market/widgets_common/loading_indicator.dart';
import 'package:goan_market/widgets_common/our_button.dart';
import 'package:goan_market/services/firestore_services.dart';

class CartScreen extends StatelessWidget{
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){

    var controller = Get.put(CartController());

    return Scaffold(
      backgroundColor: whiteColor,
      bottomNavigationBar: SizedBox(
        height: 60,
        child: ourButton(
          color: lightblue,
          onPress: (){
            Get.to(() => const ShippingDetails());
          },
          textColor: whiteColor,
          title: "Proceed to Shipping",
        ),
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: "Shopping cart"
            .text
            .color(darkFontGrey)
            .fontFamily(bold)
            .make(),
      ),

      body: StreamBuilder(
          stream: FirestoreServices.getCart(currentUser!.uid),
          builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){
            if(!snapshot.hasData){
              return Center(
              child: loadingIndicator(),
              );
    }else if(snapshot.data!.docs.isEmpty){
              return Center(
              child: "Cart is empty".text.color(darkFontGrey).make(),
              );
    }else{
              var data = snapshot.data!.docs;
              controller.calculate(data);
              controller.productSnapshot = data;

              return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
              children: [
              Expanded(

              child: ListView.builder(
                itemCount: data.length,
                itemBuilder: (BuildContext context, int index){
                return ListTile(
                leading: Image.network(
                    "${data[index]['img']}",
                    width: 80,
                    fit: BoxFit.cover,
                ),
                title: "${data[index]['title']} (x${data[index]['qty']})"
                        .text.fontFamily(bold)
                        .size(16)
                        .make(),
                        subtitle: "${data[index]['tprice']}".numCurrency
                        .text
                        .color(Colors.red)
                        .fontFamily(bold)
                        .make(),

                        trailing: const Icon(Icons.delete, color: Colors.red,).onTap(() {

                      FirestoreServices.deleteDocument(data[index].id);
    },),
                );
             },
    ),
            ),

              Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              "Total price"
                  .text
                  .fontFamily(bold)
                  .color(darkFontGrey)
                  .make(),
              Obx(() =>"${controller.totalP.value}"
                    .numCurrency
                    .text
                    .fontFamily(bold)
                    .color(Colors.red)
                    .make(),
            ),
              ],
              )
                  .box
                  .padding(const EdgeInsets.all(12))
        .color(lightGolden)
        .width(context.screenWidth-60)
        .roundedSM
        .make(),
    10.heightBox,

    // SizedBox(
    // width: context.screenWidth-60,
    // child: ourButton(
    // color: lightblue,
    // onPress: (){},
    // textColor: whiteColor,
    // title: "Proceed to Shipping",
    // ),
    // ),
    ],
    ),
    );
    }
    },
    ),
    );
  }
}