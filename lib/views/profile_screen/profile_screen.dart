import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:goan_market/consts/consts.dart';
import 'package:goan_market/consts/lists.dart';
import 'package:goan_market/controllers/auth_controller.dart';
import 'package:goan_market/controllers/profile_controller.dart';
import 'package:goan_market/services/firestore_services.dart';
import 'package:goan_market/views/auth_screen/login_screen.dart';
import 'package:goan_market/views/chat_screen/messaging_screen.dart';
import 'package:goan_market/views/orders_screen/orders_screen.dart';
import 'package:goan_market/views/profile_screen/components/details_card.dart';
import 'package:goan_market/views/wishlist_screen/wishlist_screen.dart';
import 'package:goan_market/widgets_common/bg_widget.dart';
import 'package:goan_market/widgets_common/loading_indicator.dart';

import 'edit_profile_screen.dart';

class ProfileScreen extends StatelessWidget{
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){

    var controller = Get.put(ProfileController());

    return bgWidget(
      child: Scaffold(
          body: StreamBuilder(
              stream: FirestoreServices.getUser(currentUser!.uid),

              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){

                if(!snapshot.hasData){
                  return const Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(blueColor),
                    ),);
                }else {

                  var data = snapshot.data!.docs[0];

                  return SafeArea(child: Column(
                    children: [

                      //edit profile button

                      const Align(
                          alignment: Alignment.topRight,
                          child: Icon(Icons.edit,color: whiteColor)).onTap(() {
                        controller.nameController.text = data['name'];

                        Get.to(() => EditProfileScreen(data: data));
                      }),
                      //user details section
                      Row(
                        children: [

                          data['imageUrl'] == '' ?

                          Image.asset(imgProfile2, width: 100,fit: BoxFit.cover).box.roundedFull.clip(Clip.antiAlias).make()
                              :
                          Image.network(data['imageUrl'], width: 100,fit: BoxFit.cover).box.roundedFull.clip(Clip.antiAlias).make(),
                          10.widthBox,
                          Expanded(child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              "${data['name']}".text.fontFamily(bold).white.make(),
                              5.heightBox,
                              "${data['email']}".text.size(12).white.make(),
                            ],
                          )),
                          OutlinedButton(
                            style: OutlinedButton.styleFrom(
                                side: const BorderSide(
                                  color: whiteColor,
                                )
                            ),
                            onPressed: () async{
                              await Get.put(AuthController()).signoutMethod(context);
                              Get.offAll(() => const LoginScreen());
                            },
                            child: "Log out".text.fontFamily(bold).white.make(),)
                        ],
                      ),

                      20.heightBox,
                      
                      FutureBuilder(
                          future: FirestoreServices.getCounts(),
                          builder: (BuildContext context, AsyncSnapshot snapshot){
                            if(!snapshot.hasData){
                              return Center(child: loadingIndicator());
                            }else{
                              var countData = snapshot.data;
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  detailsCard(count: countData[0].toString(),title: "In your cart",width: context.screenWidth/3.3),
                                  detailsCard(count: countData[1].toString(),title: "In your wishlist",width: context.screenWidth/3.3),
                                  detailsCard(count: countData[2].toString(),title: "Your orders",width: context.screenWidth/3.3),
                                ],
                              );
                            }
                          },),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //   children: [
                      //     detailsCard(count: data['cart_count'],title: "In your cart",width: context.screenWidth/3.3),
                      //     detailsCard(count: data['wishlist_count'],title: "In your wishlist",width: context.screenWidth/3.3),
                      //     detailsCard(count: data['order_count'],title: "Your orders",width: context.screenWidth/3.3),
                      //   ],
                      // ),

                      //buttons section
                      ListView.separated(
                          shrinkWrap: true,
                          separatorBuilder: (context,index){
                            return const Divider(
                              color: lightGrey,
                            );
                          },
                          itemCount: profileButtonsList.length,
                          itemBuilder: (BuildContext context,int index){
                            return ListTile(
                              onTap: (){
                                switch(index){
                                  case 0:
                                    Get.to(()=> OrdersScreen());
                                    break;
                                  case 1:
                                    Get.to(()=> WishlistScreen());
                                    break;
                                  case 2:
                                    Get.to(()=> MessageScreen());
                                    break;
                                }
                              },
                              leading: Image.asset(profileButtonsIcons[index],width: 22,),
                              title: profileButtonsList[index].text.fontFamily(bold).color(darkFontGrey).make(),
                            );
                          }).box.white.rounded.margin(const EdgeInsets.all(12)).padding(const EdgeInsets.symmetric(horizontal: 16)).shadowSm.make().box.color(lightblue).make(),
                    ],
                  ));
                }
              }
          )
      ),
    );
  }
}