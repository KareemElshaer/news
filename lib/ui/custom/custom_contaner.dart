import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:news/utils/app_colors.dart';
import 'package:news/utils/app_styles.dart';
import 'package:provider/provider.dart';

import '../../providers/language_provider.dart';

class CustomContaner extends StatefulWidget {
  void Function(dynamic?) onChange;

  final dynamic textSelected;

  List<String> dropDown;

  CustomContaner(
      {super.key, required this.textSelected, required this.dropDown, required this.onChange});

  @override
  State<CustomContaner> createState() => _CustomContanerState();
}

class _CustomContanerState extends State<CustomContaner> {
  @override
  Widget build(BuildContext context) {
    var languageprov = Provider.of<LanguageProvider>(context);
    var height = MediaQuery
        .of(context)
        .size
        .height;
    var width = MediaQuery
        .of(context)
        .size
        .width;
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: width * 0.02,
          vertical: height * 0.01
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
              width: 2,
              color: AppColors.whiteColor
          )
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(widget.textSelected, style: AppStyles.bold16White,),
          /*DropdownButton<dynamic>(
            //padding: EdgeInsets.only(top: height*0.02),
          icon: Icon(Icons.arrow_drop_down,color: AppColors.whiteColor,),
          dropdownColor: AppColors.blackColor,underline: SizedBox(),
          items: widget.dropDown.map((text) => DropdownMenuItem(value:text  ,child:Text(text,style: AppStyles.bold16White,)),).toList(),
              onChanged:widget.onChange
            ),*/
          DropdownButton2<String>(
            items: widget.dropDown
                .map((text) =>
                DropdownMenuItem<String>(
                  value: text as String,
                  child: Text(text as String,
                    style: AppStyles.bold16White,
                    overflow: TextOverflow.ellipsis,
                  ),
                ))
                .toList(),
            onChanged: widget.onChange,
            underline: SizedBox(),
            buttonStyleData: const ButtonStyleData(
              overlayColor: WidgetStatePropertyAll(AppColors.transparentColor),
            ),

            /*buttonStyleData: ButtonStyleData(
          height: 50,
          width: 90,
          padding: const EdgeInsets.only(left: 14, right: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: Colors.black26,
            ),
            color: Colors.redAccent,
          ),
          elevation: 2,
        ),*/
            iconStyleData: const IconStyleData(
              icon: Icon(
                Icons.arrow_drop_down, color: AppColors.whiteColor,
              ),
            ),
            dropdownStyleData: DropdownStyleData(
              maxHeight: 200,
              width: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: AppColors.blackColor,
              ),
              offset: languageprov.appLanguage == 'en'
                  ? Offset(-100, -10)
                  : Offset(100, 10),
            ),
          ),

          /* DropdownButtonHideUnderline(child:DropdownButton2<String>(dropdownOffset: ,
              icon: Icon(Icons.arrow_drop_down,color: AppColors.whiteColor,),
              onChanged: (value) {
                widget.textSelected = value! ;
                setState(() {
                });
              },
              //dropdownOffset: const Offset(0, 20), // 👈 تحريك القائمة لأسفل 20 بكسل
              items: widget.dropDown.map((text) => DropdownMenuItem(value:text  ,child:Text(text,style: AppStyles.bold16White,)),).toList()
          ) ,)*/
          /* PopupMenuButton(
            icon: Icon(Icons.arrow_drop_down, color: AppColors.whiteColor),
            color: AppColors.blackColor, // لون القائمة المنبثقة
            onSelected: widget.onChange, // نفس الـ onChanged
            itemBuilder: (context) => widget.dropDown
                .map(
                  (text) => PopupMenuItem(
                value: text,
                child: Text(
                  text,
                  style: AppStyles.bold16White,
                ),
              ),
            )
                .toList(),
          )*/
        ],
      ),
    );
  }
}