// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:agro_sanoat/allpages/add_page/add_page_provider.dart';
import 'package:agro_sanoat/funcsions/main_colors.dart';
import 'package:agro_sanoat/object/universal.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';

import 'widgets/text_widget.dart';

class AddPage extends StatefulWidget {
  const AddPage({Key? key}) : super(key: key);

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  AddPageProvider provider = AddPageProvider();

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
      child: Consumer<AddPageProvider>(
        builder: (context, value, child) => Scaffold(
          backgroundColor: MainColors.fromHex(MainColors.colorBack),
          appBar: AppBar(
            backgroundColor: Colors.white,
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: MainColors.fromHex(MainColors.colorGreen),
                )),
            toolbarHeight: 40,
            elevation: 0,
            centerTitle: true,
            title: Text(
              "Murojaat yo'llash",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.green),
            ),
          ),
          body: Container(
            height: size.height,
            width: size.width,
            padding: EdgeInsets.only(left: 15, right: 15, bottom: 25, top: 30),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      TextWidget(
                          controller: provider.nameController,
                          wrong: provider.wrongname,
                          focusNode: provider.nameFocus,
                          label: "F.I.O ni kiriting",
                          maxlines: 1,
                          name: "F.I.O"),
                      SizedBox(height: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 55,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: !provider.wrongRegion
                                      ? MainColors.fromHex(MainColors.mainColor)
                                      : MainColors.fromHex(
                                          MainColors.colorRed)),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: DropdownSearch<UniversalModel>(
                              mode: Mode.MENU,
                              showSelectedItems: false,
                              items: provider.regions,
                              dropdownSearchDecoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 15, horizontal: 17),
                                  hintText: "Vilotyatni tanlang",
                                  border: InputBorder.none),
                              selectedItem: provider.selectRegion,
                              itemAsString: (UniversalModel? value) {
                                return value!.name.toString();
                              },
                              onChanged: (value) {
                                provider.selectRegion = value;
                                provider.getProvince(value!.id.toString());
                              },
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Visibility(
                            visible: provider.wrongRegion,
                            child: Text(
                              "   Iltimos viloyatni tanlang!",
                              style: TextStyle(
                                  color: provider.wrongRegion
                                      ? MainColors.fromHex(MainColors.colorRed)
                                      : MainColors.fromHex("#54BF14"),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            height: 55,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: !provider.wrongProvince
                                      ? MainColors.fromHex(MainColors.mainColor)
                                      : MainColors.fromHex(
                                          MainColors.colorRed)),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: DropdownSearch<UniversalModel>(
                              mode: Mode.MENU,
                              showSelectedItems: false,
                              items: provider.provins,
                              dropdownSearchDecoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 15, horizontal: 17),
                                  hintText: "Tumanni tanlang",
                                  border: InputBorder.none),
                              selectedItem: provider.selectProvins,
                              itemAsString: (UniversalModel? value) {
                                return value!.name.toString();
                              },
                              onChanged: (value) {
                                provider.selectProvins = value;
                              },
                            ),
                          ),
                          SizedBox(height: 5),
                          Visibility(
                            visible: provider.wrongProvince,
                            child: Text(
                              "   Iltimos tumanni tanlang!",
                              style: TextStyle(
                                  color: provider.wrongProvince
                                      ? MainColors.fromHex(MainColors.colorRed)
                                      : MainColors.fromHex("#54BF14"),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          SizedBox(height: 20),
                          Container(
                            height: 55,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: !provider.wrongType
                                      ? MainColors.fromHex(MainColors.mainColor)
                                      : MainColors.fromHex(
                                          MainColors.colorRed)),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: DropdownSearch<String>(
                              mode: Mode.MENU,
                              showSelectedItems: false,
                              items: provider.type,
                              dropdownSearchDecoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 15, horizontal: 17),
                                  hintText: "Typeni tanlang",
                                  border: InputBorder.none),
                              selectedItem: provider.selectType,
                              onChanged: (value) {
                                provider.selectType = value;
                              },
                            ),
                          ),
                          SizedBox(height: 5),
                          Visibility(
                            visible: provider.wrongType,
                            child: Text(
                              "   Iltimos typeni tanlang!",
                              style: TextStyle(
                                  color: provider.wrongType
                                      ? MainColors.fromHex(MainColors.colorRed)
                                      : MainColors.fromHex("#54BF14"),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "   Telefon raqam",
                            style: TextStyle(
                                color: provider.wrongphone
                                    ? MainColors.fromHex(MainColors.colorRed)
                                    : MainColors.fromHex("#54BF14"),
                                fontSize: 14,
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            height: 55,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: !provider.wrongphone
                                      ? MainColors.fromHex(MainColors.mainColor)
                                      : MainColors.fromHex(
                                          MainColors.colorRed)),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: TextField(
                              controller: provider.phoneController,
                              keyboardType: TextInputType.phone,
                              inputFormatters: [
                                MaskTextInputFormatter(
                                    mask: '(##) ###-##-##',
                                    filter: {"#": RegExp(r'[0-9]')}),
                              ],
                              cursorColor: MainColors.fromHex("#54BF14"),
                              maxLines: 1,
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                              ),
                              focusNode: provider.phoneFocus,
                              autofocus: false,
                              decoration: InputDecoration(
                                errorMaxLines: 3,
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 12, horizontal: 15),
                                hintText: "(xx) xxx-xx-xx",
                                hintStyle:
                                    TextStyle(color: Colors.grey, fontSize: 14),
                                prefixIcon: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Text(
                                      "   +998 ",
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 18),
                                    ),
                                  ],
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  gapPadding: 0,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Visibility(
                            visible: provider.wrongphone,
                            child: Text(
                              "   Iltimos telefon raqamni to'liq kiritng!",
                              style: TextStyle(
                                  color: provider.wrongphone
                                      ? MainColors.fromHex(MainColors.colorRed)
                                      : MainColors.fromHex("#54BF14"),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 25),
                      TextWidget(
                          controller: provider.infoController,
                          wrong: provider.wronginfo,
                          focusNode: provider.infoFocus,
                          label: "Ma'lumotni kiriting",
                          maxlines: 6,
                          name: "Ma'lumot"),
                    ],
                  ),
                  SizedBox(
                    height: 170,
                  ),
                  InkWell(
                    onTap: () {
                      provider.sendInfo(context);
                    },
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      height: 55,
                      width: size.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                              color: MainColors.fromHex("#54BF14"),
                              width: 1.2)),
                      alignment: Alignment.center,
                      child: Text(
                        "YUBORISH",
                        style: TextStyle(
                            color: MainColors.fromHex("#54BF14"), fontSize: 20),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
