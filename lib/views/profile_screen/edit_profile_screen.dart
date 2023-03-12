import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
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
    return bgWidget(
      child: Scaffold(
          resizeToAvoidBottomInset: false,
        appBar: AppBar(),
        body: Obx(
          ()=> Column(
            mainAxisSize: MainAxisSize.min,
            children: [

            data['imageUrl'] == "" && controller.profileImgPath.isEmpty ? Image.asset(imgProfile2, width: 100,fit: BoxFit.cover ).box.roundedFull.clip(Clip.antiAlias).make()
                  :
                data['imageUrl'] != '' && controller.profileImgPath.isEmpty?
                 Image.network(data['imageUrl'],
                   width : 100,
                   fit: BoxFit.cover,)
                         .box.roundedFull.clip(Clip.antiAlias).make()
                :
            Image.file(File(controller.profileImgPath.value),
              width : 100,
              fit: BoxFit.cover,
            ).box.roundedFull.clip(Clip.antiAlias).make() ,
              10.heightBox,
              ourButton(color: blueColor,onPress: (){
                controller.changeImage(context);
              }, textColor: whiteColor,title: "Change"),
              const Divider(),
              10.heightBox,
              customTextField(controller:controller.nameController, hint: nameHint, title: name, isPass: false,),
              10.heightBox,
              customTextField(controller:controller.oldpassController,hint: passwordHint, title: oldpass, isPass: true,),
              10.heightBox,
              customTextField(controller:controller.newpassController,hint: passwordHint, title: newpass, isPass: true,),

              10.heightBox,
              controller.isLoading.value ? const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(blueColor),
              ): SizedBox(
                width: context.screenWidth - 50,
                  child: ourButton(color: blueColor,onPress: ()async{

                    controller.isLoading(true);

                    if(controller.profileImgPath.value.isNotEmpty){
                      await controller.uploadProfileImage();
                    }else{
                      controller.profileImageLink = data['imageUrl'];
                    }

                    if(data['password'] == controller.oldpassController.text) {
                      await controller.changeAuthPassword(
                        email: data['email'],
                        password: controller.oldpassController.text,
                        newpassword: controller.newpassController.text
                      );
                      await controller.uploadProfileImage();
                      await controller.updateProfile(
                          name: controller.nameController.text,
                          password: controller.newpassController.text,
                          imgUrl: controller.profileImageLink);

                      VxToast.show(context, msg: "Updated");
                    }else {
                      VxToast.show(context, msg: "Wrong Old Password!");
                      controller.isLoading(false);
                    }


                  }, textColor: whiteColor, title: "Save"),
              )
                ],

          ).box.blue50.shadowSm.padding(const EdgeInsets.all(16)).margin(const EdgeInsets.only(top: 40, left: 12, right: 12)).roundedLg.make(),
        ),
      ));
  }
}