import 'package:goan_market/consts/consts.dart';
import 'package:goan_market/views/chat_screen/components/sender_bubble.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "Title".text.fontFamily(bold).color(darkFontGrey).make(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(child: Container(
              color: Colors.teal,
              child: ListView(
                children: [
                  senderBubble(),
                  senderBubble(),
                ],
              ),
            ),
            ),

            10.heightBox,

            Row(
              children: [
                Expanded(child: TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: textfieldGrey,
                      )
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: textfieldGrey,
                        )
                    ),
                    hintText: "Type a message...",
                  ),
                )),
                IconButton(onPressed: (){}, icon: const Icon(Icons.send,color: Colors.red)),
              ],
            ).box.height(80).padding(const EdgeInsets.all(12)).margin(const EdgeInsets.only(bottom: 8)).make(),
          ],
        ),
      ),

    );
  }
}
