import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:goan_market/consts/consts.dart';
import 'package:goan_market/services/firestore_services.dart';
import 'package:goan_market/views/chat_screen/chat_screen.dart';
import 'package:goan_market/widgets_common/loading_indicator.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: 'My Messages'.text.color(darkFontGrey).fontFamily(bold).make(),
      ),
      body: StreamBuilder(
        stream: FirestoreServices.getAllMessages(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
          if(!snapshot.hasData){
            return Center(child: loadingIndicator(),);
          }else if(snapshot.data!.docs.isEmpty){
            return 'No messages yet!'.text.color(darkFontGrey).makeCentered();
          }else{
            var data = snapshot.data!.docs;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Expanded(child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (BuildContext context, int index){
                        return Card(
                          child: ListTile(
                            onTap: (){
                              Get.to(()=> const ChatScreen(),arguments: [data[index]['friend_name'], data[index]['toId']]);
                            },
                            leading: const CircleAvatar(
                              backgroundColor: blueColor,
                              child: Icon(Icons.person, color: whiteColor,),
                            ),
                            title: '${data[index]['friend_name']}'.text.fontFamily(bold).color(darkFontGrey).make(),
                            subtitle: '${data[index]['last_msg']}'.text.make(),
                          ),
                        );
                      },
                  ),)
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
