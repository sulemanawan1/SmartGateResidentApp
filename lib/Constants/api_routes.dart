const String imageBaseUrl = 'http://192.168.100.7:80/smartgate/public/storage/';

// const String imageBaseUrl='https://www.smartgate.pk/storage/';
class Api {
  static const String baseUrl = 'http://192.168.100.7:8000/api/';
  // static const String baseUrl = 'https://www.smartgate.pk/api/';
  static const String login = baseUrl + "login";
  static const String logout = baseUrl + "logout";
  static const String report_to_admin = baseUrl + "reporttoadmin";
  static const String admin_reports = baseUrl + "adminreports";
  static const String updatereportstatus = baseUrl + "updatereportstatus";
  static const String historyreports = baseUrl + "historyreports";
  static const String viewallnoticesapi = baseUrl + "viewallnotices";
  static const String viewevent = baseUrl + "event/events";
  static const String getgatekeepers = baseUrl + "getgatekeepers";
  static const String getvisitorstypes = baseUrl + "getvisitorstypes";
  static const String addpreapproventry = baseUrl + "addpreapproventry";
  static const String viewpreapproveentryreports =
      baseUrl + "viewpreapproveentryreports";
  static const String fcmtokenrefresh = baseUrl + "fcmtokenrefresh";
  static const String preapproveentryhistories =
      baseUrl + "preapproveentryhistories";
  static const String view_all_societies = baseUrl + "society/viewsocietiesforresidents";
  static const String view_all_phases = baseUrl + "viewphasesforresidents";
  static const String view_all_blocks = baseUrl + "viewblocksforresidents";
  static const String view_all_streets = baseUrl + "viewstreetsforresidents";
  static const String view_properties_for_residents = baseUrl + "viewpropertiesforresidents";
  static const String registerresident = baseUrl + "registerresident";
  static const String signup = baseUrl + "registeruser";
  static const String loginresidentdetails = baseUrl + "loginresidentdetails";
  static const String loginbuildingresidentdetails =
      baseUrl + "loginbuildingresidentdetails";
  static const String loginresidentupdateaddress = baseUrl + "loginresidentupdateaddress";
  static const String view_all_floors = baseUrl + "viewfloorsforresidents";
  static const String view_all_apartments = baseUrl + "viewapartmentsforresidents";
  static const String registerbuildingresident = baseUrl + "registerbuildingresident";
  static const String addfamilymember = baseUrl + "addfamilymember";
  static const String viewfamilymember = baseUrl + "viewfamilymember";
  static const String chatgatekeepers = baseUrl + "chatgatekeepers";
  static const String chatneighbours = baseUrl + "chatneighbours";
  static const String viewconversationsneighbours =
      baseUrl + "viewconversationsneighbours";
  static const String conversations = baseUrl + "conversations";
  static const String createchatroom = baseUrl + "createchatroom";
  static const String fetchchatroomusers = baseUrl + "fetchchatroomusers";
  static const String housesapartmentmeasurements = baseUrl + "housesapartmentmeasurements";

  /* For Apartments */

  static const String societybuildings = baseUrl + "societybuildings";
  static const String viewsocietybuildingfloors = baseUrl + "viewsocietybuildingfloors";
  static const String viewsocietybuildingapartments = baseUrl + "viewsocietybuildingapartments";



}
