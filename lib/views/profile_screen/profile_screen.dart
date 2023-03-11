import 'package:goan_market/consts/consts.dart';
import 'package:goan_market/consts/lists.dart';
import 'package:goan_market/views/profile_screen/components/details_card.dart';
import 'package:goan_market/widgets_common/bg_widget.dart';

class ProfileScreen extends StatelessWidget{
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return bgWidget(
      child: Scaffold(
        body: SafeArea(child: Column(
          children: [

            //edit profile button

            const Align(
                alignment: Alignment.topRight,
                child: Icon(Icons.edit,color: whiteColor)).onTap(() { }),
            //user details section
            Row(
              children: [
                Image.asset(imgProfile2, width: 100,fit: BoxFit.cover).box.roundedFull.clip(Clip.antiAlias).make(),
                10.widthBox,
                Expanded(child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    "Dummy User".text.fontFamily(bold).white.make(),
                    5.heightBox,
                    "customer@example.com".text.size(12).white.make(),
                  ],
                )),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(
                      color: whiteColor,
                    )
                  ),
                  onPressed: (){},
                  child: "Log out".text.fontFamily(bold).white.make(),)
              ],
            ),

            20.heightBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                detailsCard(count: "00",title: "In your cart",width: context.screenWidth/3.4),
                detailsCard(count: "32",title: "In your wishlist",width: context.screenWidth/3.4),
                detailsCard(count: "25",title: "Your orders",width: context.screenWidth/3.4),
              ],
            ),

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
                  leading: Image.asset(profileButtonsIcons[index],width: 22,),
                  title: profileButtonsList[index].text.fontFamily(bold).color(darkFontGrey).make(),
                );
                }).box.white.rounded.margin(const EdgeInsets.all(12)).padding(const EdgeInsets.symmetric(horizontal: 16)).shadowSm.make().box.color(lightblue).make(),
          ],
        )),
      ),
    );
  }
}