import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:goan_market/consts/consts.dart';
import 'package:goan_market/services/firestore_services.dart';
import 'package:goan_market/widgets_common/loading_indicator.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: 'My Wishlist'.text.color(darkFontGrey).fontFamily(bold).make(),
      ),
      body: StreamBuilder(
        stream: FirestoreServices.getWishlists(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
          if(!snapshot.hasData){
            return Center(child: loadingIndicator(),);
          }else if(snapshot.data!.docs.isEmpty){
            return 'No orders yet!'.text.color(darkFontGrey).makeCentered();
          }else{
            var data = snapshot.data!.docs;
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                      itemCount: data.length,
                      itemBuilder: (BuildContext context, int index){
                        return ListTile(
                          leading: Image.network(
                            "${data[index]['p_imgs'][0]}",
                            width: 80,
                            fit: BoxFit.cover,
                          ),
                          title: "${data[index]['p_name']})"
                              .text.fontFamily(bold)
                              .size(16)
                              .make(),
                          subtitle: "${data[index]['p_price']}".numCurrency
                              .text
                              .color(Colors.red)
                              .fontFamily(bold)
                              .make(),

                          trailing: const Icon(Icons.favorite, color: Colors.red,).onTap(() async{
                            await firestore.
                            collection(productCollection).
                            doc(data[index].id).
                            set({
                              'p_wishlist': FieldValue.arrayRemove([currentUser!.uid])
                            },SetOptions(merge: true));
                          },
                          ),
                        );
                      },
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
