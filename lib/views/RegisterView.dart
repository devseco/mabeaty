import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:ui_ecommerce/controllers/RegisterController.dart';
class RegisterView extends StatelessWidget {
  RegisterView({super.key});
  final RegisterController controller = Get.put(RegisterController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          _space(Get.height * 0.05),
          _logo(),
          _space(Get.height * 0.03),
          _text("5" , Get.height * 0.03,Colors.black,FontWeight.w600),
          _space(Get.height * 0.01),
          _text("6" , Get.height * 0.015,Colors.black,FontWeight.w400),
          _space(Get.height * 0.02),
          _textme('56' , controller.name_ , false),
          _space(Get.height * 0.02),
          _textme('3' , controller.phone_ , false),
          _space(Get.height * 0.02),
          _textme('4' , controller.password_ , true),
          _space(Get.height * 0.02),
          _select(),
          _space(Get.height * 0.02),
          _textme("85" , controller.address_, false ),
          _space(Get.height * 0.02),
          GetBuilder<RegisterController>(builder: (builder){
            if(builder.loading){
              return loading_();
            }else{
              return _buttonRegister();
            }
          }),
          GetBuilder<RegisterController>(builder: (builder){
            if(builder.errorRegister){
              return isError(builder.errormsg);
            }else{
              return SizedBox();
            }
          }),
          _space(Get.height * 0.02),
         GestureDetector(
           onTap: (){
             Get.offNamed('/');
           },
           child:  _text('92', Get.height * 0.015, Colors.black, FontWeight.w300),
         ),
          _space(Get.height * 0.03),
        ],
      ),

    );
  }
  isError(error){
    return Padding(padding: EdgeInsets.only(top: Get.height * 0.01),
      child: Center(
        child: Text('${error}'.tr , style: TextStyle(
            color: Colors.redAccent,
            fontSize: Get.height * 0.015
        ),),
      ),
    );
  }
  loading_(){
    return Center(
      child: LoadingAnimationWidget.staggeredDotsWave(
        color: Colors.black,
        size: 50,
      ),);
  }
  _logo(){
    return Center(
      child: Image.asset("assets/images/logo.png",
        height: Get.height / 7,
      ),
    );
  }
  _text(String title , double size , Color color , FontWeight fontWeight){
    return Center(
      child: Text(title.tr,
        style: TextStyle(
            fontSize: size,
            fontWeight: fontWeight,
            color : color
        ),
      ),
    );
  }

  SizedBox _space(double size){
    return SizedBox(
      height: size,
    );
  }
  _select(){
    return Padding(padding: EdgeInsetsDirectional.only(start: Get.width * 0.1 , end: Get.width * 0.1),
        child : GetBuilder<RegisterController>(builder: (builder){
          return Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: Colors.black , width: 1)
            ),
            width: Get.width * 0.9,
            height: Get.width * 0.12,
            child: DropdownButtonHideUnderline(
              child: DropdownButton2<String>(
                dropdownStyleData: const DropdownStyleData(
                  maxHeight: 200,
                ),
                isExpanded: true,
                hint: Text(
                  '59'.tr,
                  style: TextStyle(
                    fontSize: Get.height * 0.014,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold
                  ),
                ),
                items: builder.gonvernorates
                    .map((String item) => DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    style:  TextStyle(
                        fontSize: Get.height * 0.014,
                        fontWeight: FontWeight.w500
                    ),
                  ),
                ))
                    .toList(),
                value: builder.selectedGovernorate,
                onChanged: (value) {
                  builder.changeSelect(value);
                },
                buttonStyleData: const ButtonStyleData(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  height: 40,
                  width: 140,
                ),
                menuItemStyleData: const MenuItemStyleData(
                  height: 40,
                ),
              ),
            ),
          );
        }));
  }
  Padding _textme(String title , TextEditingController textEditingController , bool ispassword){
    return Padding(padding: EdgeInsets.only(right: Get.width * 0.1 , left: Get.width * 0.1),
      child:   TextField(
        obscureText: ispassword,
        controller: textEditingController,
        decoration:   InputDecoration(
          focusedBorder:  OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(color: Colors.black, width: 1.0),
          ),
          enabledBorder:  OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(color: Colors.black, width: 1.0),
          ),
          hintText: title.tr,
        ),
      ),
    );
  }

  _buttonRegister(){
    return Center(
      child: Padding(padding: EdgeInsets.only(right: Get.height * 0.04 , left: Get.height * 0.04),
        child: GestureDetector(
          onTap: (){
            controller.register();
          },
          child: Container(
            width: Get.height * 0.30,
            height: Get.height * 0.055,
            color: Colors.black,
            child: Center(
              child: Text(
                "93".tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: Get.height * 0.02
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
