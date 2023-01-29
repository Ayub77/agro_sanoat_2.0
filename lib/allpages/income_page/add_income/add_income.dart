// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:agro_sanoat/allpages/animation_loading/loading.dart';
import 'package:agro_sanoat/allpages/income_page/add_income/add_income_provider.dart';
import 'package:agro_sanoat/funcsions/main_colors.dart';
import 'package:agro_sanoat/object/type_model.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';

class AddIncome extends StatefulWidget {
  const AddIncome({Key? key, required this.type}) : super(key: key);
  final String type;
  @override
  State<AddIncome> createState() => _AddIncomeState();
}

class _AddIncomeState extends State<AddIncome> {
  AddIncomeProvider provider = AddIncomeProvider();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    provider.onStart();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => provider,
      child: Consumer<AddIncomeProvider>(
        builder: (context, value, child) => Scaffold(
          backgroundColor: MainColors.fromHex(MainColors.colorBack),
          appBar: AppBar(
            backgroundColor: MainColors.fromHex(MainColors.colorGreen),
            elevation: 0,
            centerTitle: true,
            toolbarHeight: 50,
            title: Text(
              "Daromad yaratish",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: MainColors.fromHex(MainColors.colorWhite)),
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    provider.saveInfo(context);
                  },
                  icon: Icon(Icons.done))
            ],
          ),
          body: provider.loading
              ? Loading()
              : Container(
                  height: double.infinity,
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "  Maxsulot nomi",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black),
                            ),
                            SizedBox(height: 3),
                            Container(
                                height: 45,
                                width: double.infinity,
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
                                  items: provider.items,
                                  dropdownSearchDecoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 9, horizontal: 17),
                                      hintText: "Maxsulot nomini tanlang",
                                      hintStyle: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.grey),
                                      border: InputBorder.none),
                                  selectedItem: provider.select,
                                  itemAsString: (TypeModel? value) {
                                    return value!.name.toString();
                                  },
                                  onChanged: (value) {
                                    provider.select = value;
                                  },
                                )),
                            SizedBox(height: 20),
                            Text(
                              "  Foyda summasi",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black),
                            ),
                            SizedBox(height: 3),
                            Container(
                                //height: 45,
                                width: double.infinity,
                                padding: EdgeInsets.only(left: 15),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: MainColors.fromHex(
                                            MainColors.colorGreen),
                                        width: 1.5),
                                    borderRadius: BorderRadius.circular(10)),
                                alignment: Alignment.centerLeft,
                                child: TextField(
                                  controller: provider.priceController,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    MaskTextInputFormatter(
                                        mask: '####################',
                                        filter: {"#": RegExp(r'[0-9]')}),
                                  ],
                                  scrollPadding: EdgeInsets.all(0),
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black),
                                  decoration: InputDecoration(
                                      suffixIcon: Container(
                                        alignment: Alignment.center,
                                        width: 50,
                                        child: Text(
                                          "So'm",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      contentPadding: EdgeInsets.only(top: 13),
                                      border: InputBorder.none),
                                )),
                            SizedBox(height: 20),
                            Text(
                              "  Mahsulot miqdori",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black),
                            ),
                            SizedBox(height: 3),
                            Container(
                                //height: 45,
                                width: double.infinity,
                                padding: EdgeInsets.only(left: 15),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: MainColors.fromHex(
                                            MainColors.colorGreen),
                                        width: 1.5),
                                    borderRadius: BorderRadius.circular(10)),
                                alignment: Alignment.centerLeft,
                                child: TextField(
                                  controller: provider.amountController,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    MaskTextInputFormatter(
                                        mask: '####################',
                                        filter: {"#": RegExp(r'[0-9]')}),
                                  ],
                                  scrollPadding: EdgeInsets.all(0),
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black),
                                  decoration: InputDecoration(
                                      suffixIcon: Container(
                                        alignment: Alignment.center,
                                        width: 50,
                                        child: Text(
                                          "Kg",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      contentPadding: EdgeInsets.only(top: 13),
                                      border: InputBorder.none),
                                )),
                            SizedBox(height: 20),
                            Text(
                              "  Yaratilgan sana",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black),
                            ),
                            SizedBox(height: 3),
                            Container(
                                height: 45,
                                width: double.infinity,
                                padding: EdgeInsets.only(left: 15),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: MainColors.fromHex(
                                            MainColors.colorGreen),
                                        width: 1.5),
                                    borderRadius: BorderRadius.circular(10)),
                                alignment: Alignment.centerLeft,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(provider.birthDay,
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black)),
                                    IconButton(
                                        onPressed: () {
                                          selectDate(context);
                                        },
                                        padding: EdgeInsets.all(0),
                                        icon: SvgPicture.asset(
                                          "assets/images/calendar.svg",
                                          height: 23,
                                          color: Colors.black,
                                        ))
                                  ],
                                )),
                          ],
                        ),
                        // SizedBox(height: 200),
                        // InkWell(
                        //   onTap: () {

                        //   },
                        //   child: Container(
                        //     height: 45,
                        //     //width: size.width,
                        //     alignment: Alignment.center,
                        //     decoration: BoxDecoration(
                        //         color:
                        //             MainColors.fromHex(MainColors.colorGreen),
                        //         borderRadius: BorderRadius.circular(10)),
                        //     child: Text(
                        //       "SAQLASH",
                        //       style: TextStyle(
                        //           fontSize: 18,
                        //           fontWeight: FontWeight.w600,
                        //           color: Colors.white),
                        //     ),
                        //   ),
                        // ),
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
