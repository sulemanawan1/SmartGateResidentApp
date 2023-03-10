import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as Http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:userapp/Module/Signup/Resident%20Address%20Detail/Model/Apartment.dart';
import 'package:userapp/Module/Signup/Resident%20Address%20Detail/Model/Phase.dart';
import 'package:userapp/Services/Shared%20Preferences/MySharedPreferences.dart';
import '../../../../Constants/api_routes.dart';
import '../../../../Routes/set_routes.dart';
import '../../../Login/Model/User.dart';
import '../Model/Building.dart';
import '../Model/Floor.dart';
import '../Model/HousesApartmentsModel.dart';
import '../Model/Society.dart';
import '../Model/Street.dart';
import '../Model/block.dart';
import '../Model/house.dart';

class ResidentAddressDetailController extends GetxController {
  User? user;
  var token;
  var isHidden = false;
  var isLoading = false;
  var isProperty = false;
  String address = '---';
  String country = '';
  String state = '';
  String city = '';
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController cnicController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController mobileNoController = TextEditingController();
  TextEditingController vehiclenoController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController ownernameController = TextEditingController();
  TextEditingController houseaddressdetailController = TextEditingController();
  TextEditingController ownerphonenumController = TextEditingController();
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  var imageFile;
  String societyorbuildingval = 'society';
  var propertytype = 'house';
  Society? societies;
  Phase? phases;
  Block? blocks;
  Street? streets;
  House? houses;
  Building? building;
  Floor? floor;
  Apartment? apartment;

  HousesApartmentsModel? housesApartmentsModel;

  String rentalorowner = 'Rental';
  var societyli = <Society>[];

  /*  for  houses */
  var phaseli = <Phase>[];
  var blockli = <Block>[];
  var streetli = <Street>[];
  var houseli = <House>[];
  var housesApartments = <HousesApartmentsModel>[];

  /* for apartments */
  var buildingli = <Building>[];
  var floorli = <Floor>[];
  var apartmentli = <Apartment>[];

  var societyorbuildinglist = ['society'];
  var propertytypelist = ['house', 'apartment'];
  var rentalorownerlist = ['Rental', 'Owner'];

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    GetSharedPrefrencesData();
  }

  GetSharedPrefrencesData() async {
    user = await MySharedPreferences.getUserData();
    token = user!.bearerToken;
  }

  getFromGallery(ImageSource source) async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );

    if (pickedFile != null) {
      print('file picked: $pickedFile');
      // img = pickedFile as Image?;

      print('Assigning Image file');
      imageFile = File(pickedFile.path);
      update();
    } else {}
  }

  getFromCamera(ImageSource source) async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      print('file picked: $pickedFile');
      // img = pickedFile as Image?;

      print('Assigning Image file');
      imageFile = File(pickedFile.path);
      update();
    } else {}
  }

  SocietyOrBuilding(val) async {
    print('society or building');




    societies = null;
    phases = null;
    blocks = null;
    streets = null;
    houses = null;

    societyli.clear();
    phaseli.clear();
    blockli.clear();
    streetli.clear();
    houseli.clear();
    houseaddressdetailController.clear();
    societyorbuildingval = val;

    update();
  }

  SelectedProperty(val) async {

    blocks = null;
    streets = null;
    apartment = null;
    floor = null;
    building = null;
    housesApartmentsModel = null;

    blockli.clear();
    streetli.clear();
    houseli.clear();
    buildingli.clear();
    apartmentli.clear();
    floorli.clear();
    housesApartments.clear();
    houseaddressdetailController.clear();
    propertytype = val;

    update();
  }

  SelectedSociety(val) async {


    phases = null;
    blocks = null;
    streets = null;
    houses = null;

    phaseli.clear();
    blockli.clear();
    streetli.clear();
    houseli.clear();
    houseaddressdetailController.clear();
    societies = val;

    update();
  }

  SelectedPhase(val) async {


    blocks = null;
    streets = null;
    houses = null;
    apartment = null;
    floor = null;
    building = null;
    housesApartmentsModel = null;

    blockli.clear();
    streetli.clear();
    floorli.clear();
    buildingli.clear();
    houseli.clear();
    apartmentli.clear();
    housesApartments.clear();
    houseaddressdetailController.clear();

    phases = val;

    update();
  }

  SelectedBlock(val) async {
    print('dropdown val $val');

    houses = null;
    streets = null;
    streetli.clear();
    houseli.clear();


    blocks = val;
    update();
  }

  SelectedStreet(val) async {
    print('dropdown val $val');
    houses = null;
    houseli.clear();

    houseaddressdetailController.clear();
    streets = val;

    update();
  }

  SelectedBuilding(val) async {
    apartmentli.clear();
    apartment = null;
    floor = null;
    floorli.clear();
    housesApartmentsModel = null;

    housesApartments.clear();
    houseaddressdetailController.clear();
    building = val;

    update();
  }

  SelectedFloor(val) async {
    apartmentli.clear();
    apartment = null;
    housesApartmentsModel = null;
    housesApartments.clear();
    houseaddressdetailController.clear();

    floor = val;

    update();
  }

  SelectedApartment(val) async {
    housesApartmentsModel = null;
    housesApartments.clear();

    apartment = val;

    houseaddressdetailController.text = apartment!.name!;

    update();
  }

  SelectedRentalOrOwner(val) {
    rentalorowner = val;
    update();
  }

  SelectedHousesApartments(val) {
    housesApartmentsModel = val;

    update();
  }

  void togglePasswordView() {
    isHidden = !isHidden;
    update();
  }

  Future addResidentApi({
    required int subadminid,
    required int residentid,
    required String country,
    required String state,
    required String city,
    int? societyid,
    int? phaseid,
    int? blockid,
    int? streetid,
    int? propertyid,
    int? buildingid,
    int? floorid,
    int? apartmentid,
    int? measurementid,
    required String houseaddress,
    required String residentalType,
    required String propertyType,
    required String vechileno,
    required String bearerToken,
    required String ownerName,
    required String ownerPhoneNo,
  }) async {
    print('Add Resident Api  Function Call');
    isLoading = true;
    update();

    Map<String, String> headers = {"Authorization": "Bearer $bearerToken"};
    var request =
        Http.MultipartRequest('POST', Uri.parse(Api.registerresident));
    request.headers.addAll(headers);

    if (residentalType.contains('Rental')) {
      print('iam inside rental');
      request.fields['residentid'] = residentid.toString();
      request.fields['state'] = state;
      request.fields['city'] = city;
      request.fields['societyid'] = societyid.toString();
      request.fields['pid'] = phaseid.toString();
      request.fields['bid'] = blockid.toString();
      request.fields['sid'] = streetid.toString();
      request.fields['buildingid'] = buildingid.toString();
      request.fields['societybuildingfloorid'] = floorid.toString();
      request.fields['societybuildingapartmentid'] = apartmentid.toString();
      request.fields['propertyid'] = propertyid.toString();
      request.fields['measurementid'] = measurementid.toString();
      request.fields['houseaddress'] = houseaddress;
      request.fields['country'] = country;
      request.fields['roleid'] = 3.toString();
      request.fields['rolename'] = 'resident';
      request.fields['vechileno'] = vechileno;
      request.fields['subadminid'] = subadminid.toString();
      request.fields['propertytype'] = propertyType;
      request.fields['residenttype'] = residentalType;
      request.fields['committeemember'] = "0";
      request.fields['status'] = "0";
      request.fields['ownername'] = ownerName;
      request.fields['ownermobileno'] = ownerPhoneNo;
      var responsed = await request.send();
      var response = await Http.Response.fromStream(responsed);
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        print(data);
        print(response.body);
        Get.snackbar("Resident Register Successfully", "");

        final User user = await MySharedPreferences.getUserData();
        final User user1 = User(
          userid: user.userid,
          firstName: user.firstName,
          lastName: user.lastName,
          cnic: user.cnic,
          roleId: user.roleId,
          roleName: user.roleName,
          address: address,
          bearerToken: user.bearerToken,
        );
        MySharedPreferences.setUserData(user: user1);
        await loginResidentUpdateAddressApi(
            address: address,
            residentid: user.userid!,
            bearerToken: user.bearerToken!);
        Get.offAndToNamed(homescreen, arguments: user1);
      } else if (response.statusCode == 403) {
        isLoading = false;
        update();

        var data = jsonDecode(response.body.toString());

        Get.snackbar(
          "Error",
          data.toString(),
        );
      } else {
        Get.snackbar("Failed to Register", "");
      }
    } else {
      print("ima in else");
      request.fields['residentid'] = residentid.toString();
      request.fields['state'] = state;
      request.fields['city'] = city;
      request.fields['societyid'] = societyid.toString();
      request.fields['pid'] = phaseid.toString();
      request.fields['bid'] = blockid.toString();
      request.fields['sid'] = streetid.toString();
      request.fields['buildingid'] = buildingid.toString();
      request.fields['societybuildingfloorid'] = floorid.toString();
      request.fields['societybuildingapartmentid'] = apartmentid.toString();
      request.fields['propertyid'] = propertyid.toString();
      request.fields['measurementid'] = measurementid.toString();
      request.fields['country'] = country;
      request.fields['houseaddress'] = houseaddress;
      request.fields['roleid'] = 3.toString();
      request.fields['rolename'] = 'resident';
      request.fields['vechileno'] = vechileno;
      request.fields['subadminid'] = subadminid.toString();
      request.fields['propertytype'] = propertyType;
      request.fields['residenttype'] = residentalType;
      request.fields['committeemember'] = "0";
      request.fields['status'] = "0";

      var responsed = await request.send();
      var response = await Http.Response.fromStream(responsed);
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        print(data);
        print(response.body);
        Get.snackbar("Resident Register Successfully", "");
        final User user = await MySharedPreferences.getUserData();
        final User user1 = User(
          userid: user.userid,
          firstName: user.firstName,
          lastName: user.lastName,
          cnic: user.cnic,
          roleId: user.roleId,
          roleName: user.roleName,
          address: address,
          bearerToken: user.bearerToken,
        );
        MySharedPreferences.setUserData(user: user1);
        await loginResidentUpdateAddressApi(
            address: address,
            residentid: user.userid!,
            bearerToken: user.bearerToken!);
        Get.offAndToNamed(homescreen, arguments: user1);
      } else if (response.statusCode == 403) {
        isLoading = false;
        update();

        var data = jsonDecode(response.body.toString());

        Get.snackbar(
          "Error",
          data.toString(),
        );
      } else {
        isLoading = false;
        update();

        Get.snackbar("Failed to Register", "");
      }
    }
  }

  Future loginResidentUpdateAddressApi({
    required String address,
    required int residentid,
    required String bearerToken,
  }) async {
    print(bearerToken.toString());

    final response = await Http.post(
      Uri.parse(Api.loginresidentupdateaddress),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer $bearerToken"
      },
      body: jsonEncode(<String, dynamic>{
        "residentid": residentid,
        "address": address,
      }),
    );

    print(response.body);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print("data 200 $data");
      print(response.statusCode);

      Get.snackbar("Address Updated Successfully", "");
    } else {
      Get.snackbar("Failed to Update Address", "");
    }
  }

  Future<List<Society>> viewAllSocietiesApi(String type, String token) async {
    societyli.clear();
    societies = null;

    var response = await Dio().get(
        Api.view_all_societies + '/' + type.toString(),
        options: Options(headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${token}"
        }));
    var data = response.data['data'];

    societyli = (data as List)
        .map((e) => Society(
              id: e['id'],
              name: e['name'],
              address: e['address'],
              country: e['country'],
              state: e['state'],
              city: e['city'],
              type: e['type'],
            ))
        .toList();

    return societyli;
  }

  Future<List<Phase>> viewAllPhasesApi(societyid) async {
    print('phases api');

    print(token);
    print(societyid);

    var response = await Dio().get(
        Api.view_all_phases + '/' + societyid.toString(),
        options: Options(headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${token}"
        }));
    var data = response.data['data'];

    phaseli = (data as List)
        .map((e) => Phase(
              id: e['id'],
              name: e['name'],
              subadminid: e['subadminid'],
              societyid: e['societyid'],
            ))
        .toList();

    return phaseli;
  }

  Future<List<Block>> viewAllBlocksApi(phaseid) async {
    print('Block aya');
    print(token);
    print(phaseid);

    var response = await Dio().get(
        Api.view_all_blocks + '/' + phaseid.toString(),
        options: Options(headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${token}"
        }));
    var data = response.data['data'];

    blockli = (data as List)
        .map((e) => Block(
              id: e['id'],
              name: e['name'],
              pid: e['pid'],
            ))
        .toList();

    return blockli;
  }

  Future<List<Street>> viewAllStreetsApi(blockid) async {
    print('Street aya');
    print(token);
    print(blockid);
    var response = await Dio().get(
        Api.view_all_streets + '/' + blockid.toString(),
        options: Options(headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${token}"
        }));
    var data = response.data['data'];

    streetli = (data as List)
        .map((e) => Street(
              id: e['id'],
              name: e['name'],
              bid: e['bid'],
            ))
        .toList();

    return streetli;
  }

  Future<List<Building>> viewAllBuildingApi({required phaseid}) async {
    print(token);
    print(phaseid);
    var response = await Dio().get(
        Api.societybuildings + '/' + phaseid.toString(),
        options: Options(headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${token}"
        }));
    var data = response.data['data'];

    buildingli = (data as List)
        .map((e) => Building(
              id: e['id'],
              pid: e['pid'],
              societybuildingname: e['societybuildingname'],
            ))
        .toList();

    return buildingli;
  }

  Future<List<Floor>> viewAllFloorApi({required buildingid}) async {
    print(token);
    print(buildingid);
    var response = await Dio().get(
        Api.viewsocietybuildingfloors + '/' + buildingid.toString(),
        options: Options(headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${token}"
        }));
    var data = response.data['data'];

    floorli = (data as List)
        .map((e) => Floor(
              id: e['id'],
              buildingid: e['pid'],
              name: e['name'],
            ))
        .toList();

    return floorli;
  }

  Future<List<Apartment>> viewAllApartmentApi({required floorid}) async {
    print(token);
    print(floorid);
    var response = await Dio().get(
        Api.viewsocietybuildingapartments + '/' + floorid.toString(),
        options: Options(headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${token}"
        }));
    var data = response.data['data'];

    apartmentli = (data as List)
        .map((e) => Apartment(
              id: e['id'],
              name: e['name'],
              societybuildingfloorid: e['societybuildingfloorid'],
            ))
        .toList();

    return apartmentli;
  }

  Future<List<House>> viewAllHousesApi(streetid) async {
    print('House aya');
    print(token);
    print(streetid);

    var response = await Dio().get(
        Api.view_properties_for_residents + '/' + streetid.toString(),
        options: Options(headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${token}"
        }));
    var data = response.data['data'];

    houseli = (data as List)
        .map((e) => House(
            id: e['id'],
            address: e['address'],
            sid: e['sid'],
            type: e['type'],
            typeid: e['typeid']))
        .toList();

    return houseli;
  }

  SelectedHouse(val) {
    houses = val;
    housesApartments.clear();
    housesApartmentsModel = null;
    update();
  }

  Future<List<HousesApartmentsModel>> housesApartmentsModelApi(
      {required int subadminid,
      required String token,
      required String type}) async {
    print(subadminid);
    print(token);
    print(type);

    var response = await Dio().get(
        Api.housesapartmentmeasurements +
            '/' +
            subadminid.toString() +
            '/' +
            type.toString(),
        options: Options(headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${token}"
        }));
    var data = response.data['data'];

    housesApartments = (data as List)
        .map((e) => HousesApartmentsModel(
            id: e['id'],
            subadminid: e['subadminid'],
            charges: e['charges'],
            area: e['area'],
            bedrooms: e['bedrooms'],
            status: e['status'],
            type: e['type'],
            unit: e['unit']))
        .toList();

    return housesApartments;
  }

  isPropertyHouseApartment() {
    isProperty = true;
    update();
  }
}
