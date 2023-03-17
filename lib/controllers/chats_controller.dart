import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:goan_market/consts/consts.dart';
import 'package:goan_market/controllers/home_controller.dart';

class ChatsController extends GetxController{

  var chats = firestore.collection(chatsCollection);

  var friendName = Get.arguments[0];
  var friendId = Get.arguments[1];

  var senderName = Get.find<HomeController>().username;
  var currentId = currentUser!.uid;

  var msgController = TextEditingController();

  dynamic chatDocId;

  getChatId() async{

    await chats.where('users', isEqualTo: {
      friendId: null,
      currentId: null
    }
    ).limit(1).get().then((QuerySnapshot snapshot){
      if(snapshot.docs.isNotEmpty){
        chatDocId = snapshot.docs.single.id;
      }else{
        chats.add({
          'created_on': null,
          'last_msg': '',
          'users': {friendId: null,currentId: null},
          'told': '',
          'fromId': '',
          'friend_name': friendName,
          'sender_name': senderName

        }).then((value){
          {
            chatDocId = value.id;
          }
        });
      }
    });


  }

}