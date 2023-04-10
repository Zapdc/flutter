import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:goan_market/consts/consts.dart';
import 'package:goan_market/services/firestore_services.dart';
import 'package:goan_market/views/orders_screen/orders_details.dart';
import 'package:goan_market/widgets_common/loading_indicator.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: 'My Orders'.text.color(darkFontGrey).fontFamily(bold).make(),
      ),
      body: StreamBuilder(
          stream: FirestoreServices.getAllOrders(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
            if(!snapshot.hasData){
              return Center(child: loadingIndicator(),);
            }else if(snapshot.data!.docs.isEmpty){
              return 'No orders yet!'.text.color(darkFontGrey).makeCentered();
            }else{

              var data = snapshot.data!.docs;

              return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (BuildContext context, int index){
                    return ListTile(
                      leading: '${index + 1}'.text.fontFamily(bold).color(darkFontGrey).xl.make(),
                      title: data[index]['order_code'].toString().text.color(Colors.red).fontFamily(bold).make(),
                      subtitle: data[index]['total_amount'].toString().numCurrency.text.fontFamily(bold).make(),
                      trailing: IconButton(
                          onPressed: (){
                            Get.to(()=>OrdersDetails(data:data[index]));

                          },
                          icon: const Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: darkFontGrey,
                          )
                      ),
                    );
                  },
              );
            }
          },
      ),
    );
  }
}
