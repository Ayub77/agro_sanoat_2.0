// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:agro_sanoat/allpages/header_page/bottom_sheet_provider.dart';
import 'package:agro_sanoat/funcsions/main_colors.dart';
import 'package:agro_sanoat/object/universal.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future bottomsheetMap(BuildContext context, List<UniversalModel> regions,
    UniversalModel? selecprovins, UniversalModel? selectregion) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (BuildContext context) {
      return ChangeNotifierProvider<BottomSheetProvider>(
        create: (context) => BottomSheetProvider(selecprovins, selectregion),
        child: Consumer<BottomSheetProvider>(
            builder: (context, provider, child) => Container(
                height: 450,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.only(left: 15, right: 15, bottom: 20),
                decoration: BoxDecoration(
                    color: MainColors.fromHex(MainColors.colorWhite),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(7),
                        topRight: Radius.circular(7))),
                child: provider.loading
                    ? Center(child: CircularProgressIndicator())
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 7),
                                height: 5,
                                width: 120,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(7),
                                    color: MainColors.fromHex(
                                        MainColors.colorBlack)),
                              ),
                              Text("Saralash",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: MainColors.fromHex(
                                          MainColors.colorBlack),
                                      fontSize: 22)),
                              SizedBox(height: 20),
                              DropdownSearch<UniversalModel>(
                                mode: Mode.MENU,
                                showSelectedItems: false,
                                items: regions,
                                dropdownSearchDecoration: InputDecoration(
                                    labelText: "Viloyatlar",
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 0, horizontal: 17),
                                    hintText: "Vilotyatni tanlang",
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                        borderSide: BorderSide(
                                          color: MainColors.fromHex("#E0E0E0"),
                                        )),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                        borderSide: BorderSide(
                                          color: MainColors.fromHex("#E0E0E0"),
                                        ))),
                                selectedItem: provider.selectRegion,
                                itemAsString: (UniversalModel? value) {
                                  return value!.name.toString();
                                },
                                onChanged: (value) {
                                  provider.selectRegion = value;
                                  provider.getProvince(
                                      value!.id.toString(), true);
                                },
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              DropdownSearch<UniversalModel>(
                                mode: Mode.MENU,
                                showSelectedItems: false,
                                items: provider.provins,
                                dropdownSearchDecoration: InputDecoration(
                                    labelText: "Tumanlar",
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 0, horizontal: 17),
                                    hintText: "Tumanni tanlang",
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                        borderSide: BorderSide(
                                          color: MainColors.fromHex("#E0E0E0"),
                                        )),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                        borderSide: BorderSide(
                                          color: MainColors.fromHex("#E0E0E0"),
                                        ))),
                                selectedItem: provider.selectProvins,
                                itemAsString: (UniversalModel? value) {
                                  return value!.name.toString();
                                },
                                onChanged: (value) {
                                  provider.selectProvins = value;
                                },
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                  child: InkWell(
                                onTap: () {
                                  provider.close(context);
                                },
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 50,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          color: MainColors.fromHex(
                                              MainColors.colorRed),
                                          width: 1.5)),
                                  child: Text(
                                    "Bekor qilish",
                                    style: TextStyle(
                                        color: MainColors.fromHex(
                                            MainColors.colorRed),
                                        fontSize: 18),
                                  ),
                                ),
                              )),
                              SizedBox(
                                width: 15,
                              ),
                              Expanded(
                                  child: InkWell(
                                onTap: () {
                                  provider.closePage(context);
                                },
                                borderRadius: BorderRadius.circular(10),
                                splashColor: Colors.grey,
                                child: Container(
                                  height: 50,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          color: MainColors.fromHex(
                                              MainColors.colorGreen),
                                          width: 1.5)),
                                  child: InkWell(
                                    child: Text(
                                      "Qidirish",
                                      style: TextStyle(
                                          color: MainColors.fromHex(
                                              MainColors.colorGreen),
                                          fontSize: 18),
                                    ),
                                  ),
                                ),
                              ))
                            ],
                          )
                        ],
                      ))),
      );
    },
  );
}
