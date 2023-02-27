import 'package:csc_picker/csc_picker.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:userapp/Module/Signup/Resident%20Address%20Detail/Controller/resident_address_controller.dart';
import 'package:userapp/Module/Signup/Resident%20Address%20Detail/Model/HousesApartmentsModel.dart';
import 'package:userapp/Module/Signup/Resident%20Address%20Detail/Model/Phase.dart';
import 'package:userapp/Module/Signup/Resident%20Address%20Detail/Model/Street.dart';
import 'package:userapp/Module/Signup/Resident%20Address%20Detail/Model/block.dart';
import '../../../../Constants/constants.dart';
import '../../../../Routes/set_routes.dart';
import '../../../../Services/Shared Preferences/MySharedPreferences.dart';
import '../../../../Widgets/My Button/my_button.dart';
import '../../../../Widgets/My TextForm Field/my_textform_field.dart';
import '../Model/Apartment.dart';
import '../Model/Building.dart';
import '../Model/Floor.dart';
import '../Model/Society.dart';
import '../Model/house.dart';

class ResidentAddressDetail extends GetView {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: GetBuilder<ResidentAddressDetailController>(
            init: ResidentAddressDetailController(),
            builder: (controller) {
              return Form(
                key: controller.formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: IconButton(
                                onPressed: () {
                                  MySharedPreferences.deleteUserData();
                                  Get.offAllNamed(loginscreen);
                                },
                                icon: Icon(Icons.logout)),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left:
                                      MediaQuery.of(context).size.width * 0.022,
                                  right: MediaQuery.of(context).size.width *
                                      0.022),
                              child: Text(
                                'Address Details',
                                style: TextStyle(
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    color: primaryColor),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.85,
                        child: CSCPicker(
                          defaultCountry: CscCountry.Pakistan,
                          showStates: true,
                          showCities: true,
                          flagState: CountryFlag.ENABLE,
                          dropdownDecoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              color: Colors.white,
                              border: Border.all(
                                  color: Colors.grey.shade300, width: 1)),
                          disabledDropdownDecoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              color: Colors.grey.shade300,
                              border: Border.all(
                                  color: Colors.grey.shade300, width: 1)),
                          stateSearchPlaceholder: "State",
                          citySearchPlaceholder: "City",
                          stateDropdownLabel: "*State",
                          cityDropdownLabel: "*City",
                          selectedItemStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                          ),
                          dropdownHeadingStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.bold),
                          dropdownItemStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                          ),
                          dropdownDialogRadius: 10.0,
                          searchBarRadius: 10.0,
                          onCountryChanged: (val) {
                            controller.country = val.toString();
                          },
                          onStateChanged: (value) {
                            controller.state = value.toString();
                          },
                          onCityChanged: (value) {
                            controller.city = value.toString();
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: Text(
                                "Select Type",
                                style: GoogleFonts.ubuntu(
                                    fontStyle: FontStyle.normal,
                                    // color: secondaryColor,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                    color: HexColor('#4D4D4D')),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: DropdownButtonFormField(
                                isExpanded: true,
                                style: GoogleFonts.ubuntu(
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w300,
                                    fontSize: 14,
                                    color: HexColor('#4D4D4D')),
                                value: controller.societyorbuildingval,
                                icon: Icon(
                                  Icons.arrow_drop_down_sharp,
                                  color: primaryColor,
                                ),
                                validator: (value) => value == null
                                    ? 'Please Select Society'
                                    : null,
                                items: controller.societyorbuildinglist
                                    .map((String items) {
                                  return DropdownMenuItem(
                                    value: items,
                                    child: Text(items),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  controller.SocietyOrBuilding(newValue);
                                },
                              ),
                            ),
                            (controller.societyorbuildingval == 'society')
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8),
                                        child: Text(
                                          "Select Society",
                                          style: GoogleFonts.ubuntu(
                                              fontStyle: FontStyle.normal,

                                              fontWeight: FontWeight.w400,
                                              fontSize: 14,
                                              color: HexColor('#4D4D4D')),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: DropdownSearch<Society>(
                                          validator: (value) => value == null ? 'field required' : null,
                                          asyncItems: (String filter) async {
                                            print(filter);
                                            return controller.viewAllSocietiesApi(controller.societyorbuildingval,controller.token);
                                          },
                                          onChanged: (Society? data) {
                                            controller.SelectedSociety(data!);
                                          },
                                          selectedItem: controller.societies,
                                          itemAsString: (Society society) {
                                            return society.name.toString();
                                          },
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(8),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        8, 0, 0, 0),
                                                child: Text(
                                                  "Select Phase",
                                                  style: GoogleFonts.ubuntu(
                                                      fontStyle:
                                                          FontStyle.normal,
                                                      // color: secondaryColor,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 14,
                                                      color:
                                                          HexColor('#4D4D4D')),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: DropdownSearch<Phase>(
                                                  validator: (value) =>
                                                      value == null
                                                          ? 'field required'
                                                          : null,
                                                  asyncItems:
                                                      (String filter) async {
                                                    print(filter);
                                                    return controller
                                                        .viewAllPhasesApi(controller
                                                            .societies?.id);
                                                  },
                                                  onChanged: (Phase? data) {
                                                    controller.SelectedPhase(
                                                        data);
                                                  },
                                                  selectedItem: controller.phases,
                                                  itemAsString: (Phase p) {
                                                    return p.name.toString();
                                                  },
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(8),
                                                child: Text(
                                                  "Select Property Type",
                                                  style: GoogleFonts.ubuntu(
                                                      fontStyle: FontStyle.normal,
                                                      // color: secondaryColor,
                                                      fontWeight: FontWeight.w400,
                                                      fontSize: 14,
                                                      color: HexColor('#4D4D4D')),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: DropdownButtonFormField(
                                                  isExpanded: true,
                                                  style: GoogleFonts.ubuntu(
                                                      fontStyle: FontStyle.normal,
                                                      fontWeight: FontWeight.w300,
                                                      fontSize: 14,
                                                      color: HexColor('#4D4D4D')),
                                                  value: controller.propertytype,
                                                  icon: Icon(
                                                    Icons.arrow_drop_down_sharp,
                                                    color: primaryColor,
                                                  ),
                                                  validator: (value) => value == null
                                                      ? 'Please Select Property Type'
                                                      : null,
                                                  items: controller.propertytypelist
                                                      .map((String items) {
                                                    return DropdownMenuItem(
                                                      value: items,
                                                      child: Text(items),
                                                    );
                                                  }).toList(),
                                                  onChanged: (String? newValue) {
                                                    controller.SelectedProperty(newValue);
                                                  },
                                                ),
                                              ),

                                            ]),
                                      ),

                                      // In case of house
                                      controller.propertytype=='house'?
                                      Column(children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8),
                                          child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding:
                                                  const EdgeInsets.all(8),
                                                  child: Text(
                                                    "Select Block",
                                                    style: GoogleFonts.ubuntu(
                                                        fontStyle:
                                                        FontStyle.normal,
                                                        // color: secondaryColor,
                                                        fontWeight:
                                                        FontWeight.w400,
                                                        fontSize: 14,
                                                        color:
                                                        HexColor('#4D4D4D')),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                  const EdgeInsets.all(8.0),
                                                  child: DropdownSearch<Block>(
                                                    validator: (value) =>
                                                    value == null
                                                        ? 'field required'
                                                        : null,
                                                    asyncItems:
                                                        (String filter) async {
                                                      print(filter);
                                                      return controller
                                                          .viewAllBlocksApi(
                                                          controller
                                                              .phases?.id);
                                                    },
                                                    onChanged: (Block? data) {
                                                      controller.SelectedBlock(
                                                          data);
                                                    },
                                                    selectedItem:
                                                    controller.blocks,
                                                    itemAsString: (Block p) {
                                                      return p.name.toString();
                                                    },
                                                  ),
                                                ),
                                              ]),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8),
                                          child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding:
                                                  const EdgeInsets.fromLTRB(
                                                      8, 0, 0, 0),
                                                  child: Text(
                                                    "Select Street",
                                                    style: GoogleFonts.ubuntu(
                                                        fontStyle:
                                                        FontStyle.normal,
                                                        // color: secondaryColor,
                                                        fontWeight:
                                                        FontWeight.w400,
                                                        fontSize: 14,
                                                        color:
                                                        HexColor('#4D4D4D')),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                  const EdgeInsets.all(8.0),
                                                  child: DropdownSearch<Street>(
                                                    validator: (value) =>
                                                    value == null
                                                        ? 'field required'
                                                        : null,
                                                    asyncItems:
                                                        (String filter) async {
                                                      print(filter);
                                                      return controller
                                                          .viewAllStreetsApi(
                                                          controller
                                                              .blocks?.id);
                                                    },
                                                    onChanged: (Street? data) {
                                                      controller.SelectedStreet(
                                                          data);
                                                    },
                                                    selectedItem:
                                                    controller.streets,
                                                    itemAsString: (Street p) {
                                                      return p.name.toString();
                                                    },
                                                  ),
                                                ),
                                              ]),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8),
                                          child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding:
                                                  const EdgeInsets.fromLTRB(
                                                      8, 0, 0, 0),
                                                  child: Text(
                                                    "Select House",
                                                    style: GoogleFonts.ubuntu(
                                                        fontStyle:
                                                        FontStyle.normal,
                                                        // color: secondaryColor,
                                                        fontWeight:
                                                        FontWeight.w400,
                                                        fontSize: 14,
                                                        color:
                                                        HexColor('#4D4D4D')),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                  const EdgeInsets.all(8.0),
                                                  child: DropdownSearch<House>(
                                                    validator: (value) =>
                                                    value == null
                                                        ? 'field required'
                                                        : null,
                                                    asyncItems:
                                                        (String filter) async {
                                                      print(filter);
                                                      return controller
                                                          .viewAllHousesApi(
                                                          controller
                                                              .streets?.id);
                                                    },
                                                    onChanged: (House? data) {

                                                      controller.SelectedHouse(
                                                          data);



                                                      controller
                                                          .houseaddressdetailController
                                                          .text =
                                                          data!.address
                                                              .toString();
                                                      controller.isPropertyHouseApartment();
                                                    },
                                                    selectedItem:
                                                    controller.houses,
                                                    itemAsString: (House p) {
                                                      return p.address.toString();
                                                    },
                                                  ),
                                                ),
                                                controller.isProperty?Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                    padding:
                                                    const EdgeInsets.fromLTRB(
                                                        8, 0, 0, 0),
                                                    child: Text(
                                                      "Select Area Type",
                                                      style: GoogleFonts.ubuntu(
                                                          fontStyle:
                                                          FontStyle.normal,
                                                          // color: secondaryColor,
                                                          fontWeight:
                                                          FontWeight.w400,
                                                          fontSize: 14,
                                                          color:
                                                          HexColor('#4D4D4D')),
                                                    ),
                                                  ),
                                                    Padding(
                                                      padding:
                                                      const EdgeInsets.all(8.0),
                                                      child: DropdownSearch<HousesApartmentsModel>(
                                                        validator: (value) =>
                                                        value == null
                                                            ? 'field required'
                                                            : null,
                                                        asyncItems:
                                                            (String filter) async {
                                                          print(filter);
                                                          return controller.housesApartmentsModelApi(subadminid: controller.phases!.subadminid!, token: controller.user!.bearerToken!, type: 'house');
                                                        },
                                                        onChanged: (HousesApartmentsModel? data) {

                                                          controller. SelectedHousesApartments(data);

                                                        },
                                                        selectedItem: controller.housesApartmentsModel,
                                                        itemAsString: (HousesApartmentsModel p) {
                                                          return p.area.toString()+' '+p.unit.toString();
                                                        },
                                                      ),
                                                    )

                                                  ],)
                                                    :Container(),


                                              ]),
                                        ),

                                      ],):
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                        Padding(
                                          padding:
                                          const EdgeInsets.fromLTRB(
                                              8, 0, 0, 0),
                                          child: Text(
                                            "Select Building",
                                            style: GoogleFonts.ubuntu(
                                                fontStyle:
                                                FontStyle.normal,
                                                // color: secondaryColor,
                                                fontWeight:
                                                FontWeight.w400,
                                                fontSize: 14,
                                                color:
                                                HexColor('#4D4D4D')),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                          const EdgeInsets.all(8.0),
                                          child: DropdownSearch<Building>(
                                            validator: (value) =>
                                            value == null
                                                ? 'field required'
                                                : null,
                                            asyncItems:
                                                (String filter) async {
                                              print(filter);
                                              return controller.viewAllBuildingApi(phaseid: controller.phases?.id);
                                            },
                                            onChanged: (Building? data) {
                                              controller.SelectedBuilding(
                                                  data);
                                            },
                                            selectedItem:
                                            controller.building,
                                            itemAsString: (Building p) {
                                              return p.societybuildingname.toString();
                                            },
                                          ),
                                        ),

                                        Padding(
                                          padding:
                                          const EdgeInsets.fromLTRB(
                                              8, 0, 0, 0),
                                          child: Text(
                                            "Select Floor",
                                            style: GoogleFonts.ubuntu(
                                                fontStyle:
                                                FontStyle.normal,
                                                // color: secondaryColor,
                                                fontWeight:
                                                FontWeight.w400,
                                                fontSize: 14,
                                                color:
                                                HexColor('#4D4D4D')),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                          const EdgeInsets.all(8.0),
                                          child: DropdownSearch<Floor>(
                                            validator: (value) =>
                                            value == null
                                                ? 'field required'
                                                : null,
                                            asyncItems:
                                                (String filter) async {
                                              print(filter);
                                              return controller.viewAllFloorApi(buildingid: controller.building?.id);
                                            },
                                            onChanged: (Floor? data) {
                                              controller.SelectedFloor(
                                                  data);
                                            },
                                            selectedItem:
                                            controller.floor,
                                            itemAsString: (Floor p) {
                                              return p.name.toString();
                                            },
                                          ),
                                        ),



                                        Padding(
                                          padding:
                                          const EdgeInsets.fromLTRB(
                                              8, 0, 0, 0),
                                          child: Text(
                                            "Select Apartment",
                                            style: GoogleFonts.ubuntu(
                                                fontStyle:
                                                FontStyle.normal,
                                                // color: secondaryColor,
                                                fontWeight:
                                                FontWeight.w400,
                                                fontSize: 14,
                                                color:
                                                HexColor('#4D4D4D')),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                          const EdgeInsets.all(8.0),
                                          child: DropdownSearch<Apartment>(
                                            validator: (value) =>
                                            value == null
                                                ? 'field required'
                                                : null,
                                            asyncItems:
                                                (String filter) async {
                                              print(filter);
                                              return controller.viewAllApartmentApi(floorid: controller.floor?.id);
                                            },
                                            onChanged: (Apartment? data) {
                                              controller.SelectedApartment(
                                                  data);
                                            },
                                            selectedItem:
                                            controller.apartment,
                                            itemAsString: (Apartment p) {
                                              return p.name.toString();
                                            },
                                          ),
                                        ),
                                          Padding(
                                            padding:
                                            const EdgeInsets.fromLTRB(
                                                8, 0, 0, 0),
                                            child: Text(
                                              "Select Area Type",
                                              style: GoogleFonts.ubuntu(
                                                  fontStyle:
                                                  FontStyle.normal,
                                                  // color: secondaryColor,
                                                  fontWeight:
                                                  FontWeight.w400,
                                                  fontSize: 14,
                                                  color:
                                                  HexColor('#4D4D4D')),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                            const EdgeInsets.all(8.0),
                                            child: DropdownSearch<HousesApartmentsModel>(
                                              validator: (value) =>
                                              value == null
                                                  ? 'field required'
                                                  : null,
                                              asyncItems:
                                                  (String filter) async {
                                                print(filter);
                                                return controller.housesApartmentsModelApi(subadminid: controller.phases!.subadminid!, token: controller.user!.bearerToken!, type: 'apartment');
                                              },
                                              onChanged: (HousesApartmentsModel? data) {

                                                controller. SelectedHousesApartments(data);

                                              },
                                              selectedItem: controller.housesApartmentsModel,
                                              itemAsString: (HousesApartmentsModel p) {
                                                return p.area.toString()+' '+p.unit.toString();
                                              },
                                            ),
                                          )


                                      ],)



                                    ],
                                  )
                                : Container(),
                          ],
                        ),
                      ),
                      MyTextFormField(
                          validator: emptyStringValidator,
                          controller: controller.houseaddressdetailController,
                          hintText: 'House Address',
                          labelText: 'House Address Detail (optional)',
                          onFocusedBorderColor: primaryColor,
                          onEnabledBorderColor: primaryColor),
                      MyTextFormField(
                          controller: controller.vehiclenoController,
                          hintText: 'Vehicle No',
                          labelText: 'Vehicle No (optional)',
                          onFocusedBorderColor: primaryColor,
                          onEnabledBorderColor: primaryColor),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                                child: Text(
                                  "Select Resident Type",
                                  style: GoogleFonts.ubuntu(
                                      fontStyle: FontStyle.normal,
                                      // color: secondaryColor,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                      color: HexColor('#4D4D4D')),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: DropdownButton(
                                  isExpanded: true,
                                  style: GoogleFonts.ubuntu(
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w300,
                                      fontSize: 14,
                                      color: HexColor('#4D4D4D')),
                                  value: controller.rentalorowner,
                                  icon: Icon(
                                    Icons.arrow_drop_down_sharp,
                                    color: primaryColor,
                                  ),
                                  items: controller.rentalorownerlist
                                      .map((String items) {
                                    return DropdownMenuItem(
                                      value: items,
                                      child: Text(items),
                                    );
                                  }).toList(),
                                  onChanged: (String? newValue) {
                                    controller.SelectedRentalOrOwner(newValue);
                                  },
                                ),
                              ),
                            ]),
                      ),
                      controller.rentalorowner == 'Rental'
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(18.0),
                                  child: Text(
                                    'Enter Owner Details',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                MyTextFormField(
                                    controller: controller.ownernameController,
                                    validator: emptyStringValidator,
                                    hintText: 'Owner Name',
                                    labelText: 'Enter Owner Name',
                                    onFocusedBorderColor: primaryColor,
                                    onEnabledBorderColor: primaryColor),
                                MyTextFormField(
                                    controller:
                                        controller.ownerphonenumController,
                                    validator: emptyStringValidator,
                                    hintText: 'Owner Phone No',
                                    labelText: 'Enter Phone No',
                                    onFocusedBorderColor: primaryColor,
                                    onEnabledBorderColor: primaryColor),
                              ],
                            )
                          : Container(),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                      ),
                      MyButton(
                        onPressed: controller.isLoading
                            ? null
                            : () {
                                if (controller.formKey.currentState!
                                    .validate()) {
                                  if (controller.societyorbuildingval ==
                                      'society') {

                                    print(controller.phases!.id!);
                                    controller.addResidentApi(
                                      subadminid: controller.phases!.subadminid!,
                                      residentid: controller.user!.userid!,
                                      country: controller.country,
                                      state: controller.state,
                                      city: controller.city,
                                      societyid: controller.societies?.id,
                                      phaseid: controller.phases?.id,
                                      blockid: controller.blocks?.id,
                                      streetid:controller.streets?.id,
                                      propertyid: controller.houses?.id,
                                      houseaddress: controller.houseaddressdetailController.text,
                                      residentalType: controller.rentalorowner,
                                      propertyType: controller.propertytype,
                                      vechileno: controller.vehiclenoController.text,
                                      bearerToken: controller.user!.bearerToken!,
                                      ownerName: controller.ownernameController.text,
                                      ownerPhoneNo: controller.ownerphonenumController.text,
                                      measurementid: controller.housesApartmentsModel!.id!,
                                      apartmentid: controller.apartment?.id,
                                      buildingid: controller.building?.id,
                                      floorid: controller.floor?.id,
                                    );
                                  } else {

                                    print('local building');
                                  }
                                }
                              },
                        textColor: Colors.white,
                        color: primaryColor,
                        name: 'Save',
                        outlinedBorder: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
