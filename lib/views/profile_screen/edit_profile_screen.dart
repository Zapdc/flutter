import 'dart:io';
import 'package:get/get.dart';
import 'package:goan_market/consts/consts.dart';
import 'package:goan_market/controllers/profile_controller.dart';
import 'package:goan_market/widgets_common/bg_widget.dart';
import 'package:goan_market/widgets_common/custom_textfield.dart';
import 'package:goan_market/widgets_common/our_button.dart';

class EditProfileScreen extends StatelessWidget{

  final dynamic data;


  const EditProfileScreen ({Key? key, this.data}) : super(key: key);

  @override
  Widget build (BuildContext context) {

    var controller = Get.find<ProfileController>();
    controller.nameController.text = data['name'];
    controller.passController.text = data['password'];
    return bgWidget(
      child: Scaffold(
        appBar: AppBar(),
        body: Obx(
          ()=> Column(
            mainAxisSize: MainAxisSize.min,
            children: [

              controller.profileImgPath.isEmpty ? Image.asset(imgProfile2, width: 100,fit: BoxFit.cover ).box.roundedFull.clip(Clip.antiAlias).make()
                  : Image.file(File(controller.profileImgPath.value),
                  width : 100,
                fit: BoxFit.cover,
    ).box.roundedFull.clip(Clip.antiAlias).make() ,




              10.heightBox,
              ourButton(color: blueColor,onPress: (){
                controller.changeImage(context);
              }, textColor: whiteColor,title: "Change"),
              const Divider(),
              10.heightBox,
              customTextField(
                 controller:controller.nameController, hint: nameHint, title: name, isPass: false),

              customTextField(controller:controller.passController,hint: passwordHint, title: password, isPass: true),

              10.heightBox,
              SizedBox(
                width: context.screenWidth - 50,
                  child: ourButton(color: blueColor,onPress: (){}, textColor: whiteColor, title: "Save"),
              )
                ],

          ).box.blue50.shadowSm.padding(const EdgeInsets.all(16)).margin(const EdgeInsets.only(top: 40, left: 12, right: 12)).roundedLg.make(),
        ),
      ));
  }
}