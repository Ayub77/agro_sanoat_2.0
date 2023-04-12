// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:agro_sanoat/allpages/animation_loading/loading.dart';
import 'package:agro_sanoat/allpages/person_info/person_info_provider.dart';
import 'package:agro_sanoat/funcsions/main_colors.dart';
import 'package:agro_sanoat/http_service/http_constant.dart';
import 'package:agro_sanoat/object/type_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';

class PersonInfo extends StatefulWidget {
  const PersonInfo({Key? key}) : super(key: key);

  @override
  State<PersonInfo> createState() => _PersonInfoState();
}

class _PersonInfoState extends State<PersonInfo> with TickerProviderStateMixin {
  PersonInfoProvider provider = PersonInfoProvider();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    provider.onStart();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return ChangeNotifierProvider(
      create: (context) => provider,
      child: Consumer<PersonInfoProvider>(
        builder: (context, value, child) => Scaffold(
          appBar: AppBar(
            elevation: 0,
            title: Text(
              provider.textEnebled
                  ? "Ma'lumotlarni tahrirlash"
                  : "O'zim haqimda",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
            ),
            centerTitle: true,
            backgroundColor: MainColors.fromHex(MainColors.colorGreen),
            toolbarHeight: 40,
            actions: [
              Visibility(
                visible: !provider.textEnebled,
                child: PopupMenuButton(
                    icon: SvgPicture.asset("assets/images/menu.svg",
                        color: MainColors.fromHex(MainColors.colorWhite)),
                    onSelected: (value) {
                      provider.selectItem(value, context);
                    },
                    itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                          const PopupMenuItem(
                            value: 1,
                            child: Text("Tahrirlash"),
                          ),
                          const PopupMenuItem(
                            value: 3,
                            child: Text("Parolni o'zgartirish"),
                          ),
                          PopupMenuItem(
                            value: 2,
                            child: Text("Chiqish"),
                          ),
                        ]),

                // child: IconButton(
                //     onPressed: () {
                //       provider.textvisible();
                //     },
                //     icon: SvgPicture.asset(
                //       "assets/images/edit.svg",
                //       color: MainColors.fromHex(MainColors.colorWhite),
                //     )),
              ),
            ],
          ),
          body: provider.loading
              ? Loading()
              : Container(
                  height: size.height,
                  width: size.width,
                  padding: EdgeInsets.symmetric(vertical: 7, horizontal: 15),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 185,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color:
                                      MainColors.fromHex(MainColors.colorGreen),
                                  width: 1.5),
                              borderRadius: BorderRadius.circular(20),
                              color:
                                  MainColors.fromHex(MainColors.colorGreySoft)),
                          child: CachedNetworkImage(
                            imageUrl:
                                HttpConstant.mainImageUrl + provider.imageUrl,
                            imageBuilder: (context, imageProvider) => Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            placeholder: (context, url) => Center(
                                child: CircularProgressIndicator(
                              color: MainColors.fromHex(MainColors.colorGreen),
                            )),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                        ),
                        SizedBox(height: 15),
                        Text(
                          "  F.I.O",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              color: Colors.black),
                        ),
                        SizedBox(height: 3),
                        Container(
                            //height: 45,
                            width: size.width,
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: provider.errorName
                                        ? MainColors.fromHex(
                                            MainColors.colorRed)
                                        : MainColors.fromHex(
                                            MainColors.colorGreen),
                                    width: 1.5),
                                borderRadius: BorderRadius.circular(10)),
                            alignment: Alignment.centerLeft,
                            child: TextField(
                              controller: provider.nameController,
                              enabled: provider.textEnebled,
                              scrollPadding: EdgeInsets.all(0),
                              style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black),
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(0),
                                  border: InputBorder.none),
                            )),
                        SizedBox(height: 10),
                        Text(
                          "  Faoliyat turi",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              color: Colors.black),
                        ),
                        SizedBox(height: 3),
                        Container(
                          height: 45,
                          width: size.width,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color:
                                      MainColors.fromHex(MainColors.colorGreen),
                                  width: 1.5),
                              borderRadius: BorderRadius.circular(10)),
                          alignment: Alignment.centerLeft,
                          child: DropdownSearch<TypeModel>(
                            mode: Mode.MENU,
                            showSelectedItems: false,
                            enabled: provider.textEnebled,
                            items: provider.typeItems,
                            dropdownSearchDecoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 9, horizontal: 17),
                                hintText: "Faoliyat turini tanlang",
                                border: InputBorder.none),
                            selectedItem: provider.selctType,
                            itemAsString: (TypeModel? value) {
                              return value!.name.toString();
                            },
                            onChanged: (value) {
                              provider.selctType = value;
                            },
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "  Kamchiliklar",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              color: Colors.black),
                        ),
                        SizedBox(height: 3),
                        Container(
                            height: 45,
                            width: size.width,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: MainColors.fromHex(
                                        MainColors.colorGreen),
                                    width: 1.5),
                                borderRadius: BorderRadius.circular(10)),
                            alignment: Alignment.centerLeft,
                            child: DropdownSearch<TypeModel>(
                              mode: Mode.MENU,
                              dropdownSearchBaseStyle: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black),
                              showSelectedItems: false,
                              enabled: provider.textEnebled,
                              items: provider.typeNeeds,
                              dropdownSearchDecoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 9, horizontal: 17),
                                  hintText: "Mavjud emas",
                                  hintStyle: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black),
                                  border: InputBorder.none),
                              selectedItem: provider.selctNeeds,
                              itemAsString: (TypeModel? value) {
                                return value!.name.toString();
                              },
                              onChanged: (value) {
                                provider.selctNeeds = value;
                              },
                            )),
                        SizedBox(height: 10),
                        Text(
                          "  Tug'ilgan sana",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              color: Colors.black),
                        ),
                        SizedBox(height: 3),
                        Container(
                            height: 45,
                            width: size.width,
                            padding: EdgeInsets.only(left: 15),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: MainColors.fromHex(
                                        MainColors.colorGreen),
                                    width: 1.5),
                                borderRadius: BorderRadius.circular(10)),
                            alignment: Alignment.centerLeft,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(provider.birthDay,
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black)),
                                Visibility(
                                  visible: provider.textEnebled,
                                  child: IconButton(
                                      onPressed: () {
                                        selectDate(context);
                                      },
                                      padding: EdgeInsets.all(0),
                                      icon: SvgPicture.asset(
                                        "assets/images/calendar.svg",
                                        height: 23,
                                        color: Colors.black,
                                      )),
                                )
                              ],
                            )),
                        SizedBox(height: 10),
                        Text(
                          "  Joylashuv",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              color: Colors.black),
                        ),
                        SizedBox(height: 3),
                        Container(
                            height: 45,
                            width: size.width,
                            padding: EdgeInsets.only(left: 15),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: MainColors.fromHex(
                                        MainColors.colorGreen),
                                    width: 1.5),
                                borderRadius: BorderRadius.circular(10)),
                            alignment: Alignment.centerLeft,
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 6,
                                  child: Text(
                                    provider.lat,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Visibility(
                                    visible: provider.textEnebled,
                                    child: IconButton(
                                        onPressed: () {
                                          provider.setMarker(context);
                                        },
                                        padding: EdgeInsets.all(0),
                                        icon: SvgPicture.asset(
                                          "assets/images/location.svg",
                                          height: 21,
                                          color: MainColors.fromHex("#2755A5"),
                                        )),
                                  ),
                                )
                              ],
                            )),
                        SizedBox(height: 10),
                        Text(
                          "  Telefon raqam",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              color: Colors.black),
                        ),
                        SizedBox(height: 3),
                        Container(
                            height: 45,
                            width: size.width,
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: provider.errorPhone
                                        ? MainColors.fromHex(
                                            MainColors.colorRed)
                                        : MainColors.fromHex(
                                            MainColors.colorGreen),
                                    width: 1.5),
                                borderRadius: BorderRadius.circular(10)),
                            alignment: Alignment.center,
                            child: TextField(
                              controller: provider.phoneController,
                              enabled: provider.textEnebled,
                              keyboardType: TextInputType.phone,
                              inputFormatters: [
                                MaskTextInputFormatter(
                                    mask: '(##) ###-##-##',
                                    filter: {"#": RegExp(r'[0-9]')}),
                              ],
                              scrollPadding: EdgeInsets.all(0),
                              style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black),
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(0),
                                  border: InputBorder.none),
                            )),
                        SizedBox(height: 25),
                        Visibility(
                          visible: provider.textEnebled,
                          child: Row(
                            children: [
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    provider.textvisible();
                                  },
                                  child: Container(
                                    height: 40,
                                    //width: size.width,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: MainColors.fromHex(
                                            MainColors.colorRed),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Text(
                                      "BEKOK QILISH",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    provider.editProfil(context);
                                  },
                                  child: Container(
                                    height: 40,
                                    //width: size.width,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: MainColors.fromHex(
                                            MainColors.colorGreen),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Text(
                                      "SAQLASH",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        )
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: provider.selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != provider.selectedDate) {
      provider.setBirthday(picked);
    }
  }
}
