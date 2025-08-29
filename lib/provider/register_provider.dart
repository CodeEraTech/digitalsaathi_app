import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:digitalsaathi/constants/app_url.dart';
import 'package:digitalsaathi/data/app_excaptions.dart';
import 'package:digitalsaathi/data/model/assembly_model.dart';
import 'package:digitalsaathi/data/model/category_and_mla_response.dart';
import 'package:digitalsaathi/data/model/complaint_list_response.dart';
import 'package:digitalsaathi/data/model/constituency_response.dart';
import 'package:digitalsaathi/data/model/district_response.dart';
import 'package:digitalsaathi/data/model/meeting_detail_response.dart';
import 'package:digitalsaathi/data/model/meeting_list_response.dart';
import 'package:digitalsaathi/data/model/meeting_report_response.dart';
import 'package:digitalsaathi/data/model/state_response.dart';
import 'package:digitalsaathi/model/feedmodel.dart';
import 'package:digitalsaathi/ui/authentication_screen/login_screen.dart';
import 'package:digitalsaathi/ui/botttom_bar/bottom_nav_bar.dart';
import 'package:digitalsaathi/ui/home/widgets/ReelModel.dart';
import 'package:digitalsaathi/utils/connection_util.dart';
import 'package:digitalsaathi/utils/prefrence/pref_utils.dart';
import 'package:digitalsaathi/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;

class RegisterProvider with ChangeNotifier {

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  resetData(){
    selectedCountry = null;
    selectedState = null;
    selectedDistrict = null;
    selectConstituency = null;
    selectedAssembly = null;
  }


  String? selectedCountry;
  onCountryChange(String value){
    selectedCountry = value;
    getState();
     notifyListeners();
  }

  List<StateData> _stateData = [];

  List<StateData> get stateData => _stateData;

  StateData? selectedState;
  onStateChange(StateData state){
    selectedState = state;
    getDistrict(selectedState!.id.toString());
    notifyListeners();
  }

  Future getState() async{
    _isLoading = true;
    notifyListeners();
    try {
      _stateData = [];
      _districtData = [];
      _constituencyData = [];
      _assemblyData = [];
      selectedState = null;
      selectedDistrict = null;
      selectedAssembly = null;
      selectConstituency = null;
      var data = {
        "CountryId": "101"
      };

      http.Response response = await http.post(
          Uri.parse(AppUrl.getState), body: data);

      Utils.printConsoleData(response.body);
      if (response.statusCode == 200) {
        if(jsonDecode(response.body)['status_code'] == 200) {
          StateResponse stateResponse = StateResponse
              .fromJson(jsonDecode(response.body));
         _stateData = stateResponse.data;
          _isLoading = false;
          notifyListeners();
        }else{
          EasyLoading.showError("${jsonDecode(response.body)['status_code']} - ${jsonDecode(response.body)['status_text']}");
          _isLoading = false;
          notifyListeners();
        }
      }else{
        EasyLoading.showError("${response.statusCode}");
        _isLoading = false;
        notifyListeners();
      }

      log(response.body);
    }on SocketException {
      _isLoading = false;
      notifyListeners();
      throw FetchDataException('No Internet Connection');
    }
    catch(e){
      EasyLoading.showError("Something went wrong. Please try again!!!");
      _isLoading = false;
      notifyListeners();
    }
  }


  List<DistrictData> _districtData = [];

  List<DistrictData> get districtData => _districtData;

  DistrictData? selectedDistrict;

  onDistrictChange(DistrictData d){
    selectedDistrict = d;
    getConstituency(d.id.toString(), selectedState!.id.toString());
    notifyListeners();
  }
  Future getDistrict(String id) async{
    _isLoading = true;
    notifyListeners();
    try {
      _districtData = [];
      _constituencyData = [];
      _assemblyData = [];
      selectedDistrict = null;
      selectedAssembly = null;
      selectConstituency = null;
      var data = {
        "state_id": id
      };

      http.Response response = await http.post(
          Uri.parse(AppUrl.getDistrict), body: data);

      Utils.printConsoleData(response.body);
      if (response.statusCode == 200) {
        if(jsonDecode(response.body)['status_code'] == 200) {
          DistrictResponse stateResponse = DistrictResponse
              .fromJson(jsonDecode(response.body));
         _districtData = stateResponse.data;
          _isLoading = false;
          notifyListeners();
        }else{
          EasyLoading.showError("${jsonDecode(response.body)['status_code']} - ${jsonDecode(response.body)['status_text']}");
          _isLoading = false;
          notifyListeners();
        }
      }else{
        EasyLoading.showError("${response.statusCode}");
        _isLoading = false;
        notifyListeners();
      }

      log(response.body);
    }on SocketException {
      _isLoading = false;
      notifyListeners();
      throw FetchDataException('No Internet Connection');
    }
    catch(e){
      EasyLoading.showError("Something went wrong. Please try again!!!");
      _isLoading = false;
      notifyListeners();
    }
  }

  List<ConstituencyData> _constituencyData = [];

  List<ConstituencyData> get constituencyData => _constituencyData;

  ConstituencyData? selectConstituency;

  onConstituencyChange(ConstituencyData c){
    selectConstituency = c;
    getAssembly(selectedDistrict!.id.toString(), selectedState!.id.toString(), c.id.toString());
    notifyListeners();

  }

  Future getConstituency(String district,String stateId,) async{
    _isLoading = true;
    notifyListeners();
    try {
      _constituencyData = [];
      _assemblyData = [];
      selectedAssembly = null;
      selectConstituency = null;
      var data = {"district_id": district, "state_id": stateId};

      http.Response response = await http.post(
          Uri.parse(AppUrl.getConstituency), body: data);

      Utils.printConsoleData(response.body);
      if (response.statusCode == 200) {
        if(jsonDecode(response.body)['status_code'] == 200) {
          ConstituencyResponse stateResponse = ConstituencyResponse
              .fromJson(jsonDecode(response.body));
         _constituencyData = stateResponse.data;
          _isLoading = false;
          notifyListeners();
        }else{
          EasyLoading.showError("${jsonDecode(response.body)['status_code']} - ${jsonDecode(response.body)['status_text']}");
          _isLoading = false;
          notifyListeners();
        }
      }else{
        EasyLoading.showError("${response.statusCode}");
        _isLoading = false;
        notifyListeners();
      }

      log(response.body);
    }on SocketException {
      _isLoading = false;
      notifyListeners();
      throw FetchDataException('No Internet Connection');
    }
    catch(e){
      EasyLoading.showError("Something went wrong. Please try again!!!");
      _isLoading = false;
      notifyListeners();
    }
  }

  List<AssemblyData> _assemblyData = [];

  List<AssemblyData> get assemblyData => _assemblyData;

  AssemblyData? selectedAssembly;
  onAssemblyChange(AssemblyData a){
    selectedAssembly = a;
    notifyListeners();

  }

  Future getAssembly(String district,String stateId,String cId) async{
    _isLoading = true;
    notifyListeners();
    try {
      _assemblyData = [];
      selectedAssembly = null;
      var data = { "district_id": district,
        "mp_constituency_id": cId,
        "state_id": stateId};

      http.Response response = await http.post(
          Uri.parse(AppUrl.getAssembly), body: data);

      Utils.printConsoleData(response.body);
      if (response.statusCode == 200) {
        if(jsonDecode(response.body)['status_code'] == 200) {
          AssemblyResponse stateResponse = AssemblyResponse
              .fromJson(jsonDecode(response.body));
         _assemblyData = stateResponse.data;
          _isLoading = false;
          notifyListeners();
        }else{
          EasyLoading.showError("${jsonDecode(response.body)['status_code']} - ${jsonDecode(response.body)['status_text']}");
          _isLoading = false;
          notifyListeners();
        }
      }else{
        EasyLoading.showError("${response.statusCode}");
        _isLoading = false;
        notifyListeners();
      }

      log(response.body);
    }on SocketException {
      _isLoading = false;
      notifyListeners();
      throw FetchDataException('No Internet Connection');
    }
    catch(e){
      EasyLoading.showError("Something went wrong. Please try again!!!");
      _isLoading = false;
      notifyListeners();
    }
  }


  Future registerUser(context,var body) async{
    _isLoading = true;
    notifyListeners();
  //  try {


      http.Response response = await http.post(
          Uri.parse(AppUrl.registerUser), body: body);

      print(AppUrl.registerUser);
      print(response.body);
      Utils.printConsoleData(response.body);
      if (response.statusCode == 200) {
        if(jsonDecode(response.body)['status_code'] == 200 || jsonDecode(response.body)['status_code'] == 403) {
          AppUrl.apiToken = jsonDecode(response.body)['authkey'];
          PrefUtils.setToken(jsonDecode(response.body)['authkey']);
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => LoginScreen(),
            ),
                (Route<dynamic> route) => false,
          );
         // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => BottomNavBar(),));
          _isLoading = false;
          notifyListeners();
        }else{
          EasyLoading.showError("${jsonDecode(response.body)['status_code']} - ${jsonDecode(response.body)['message']}");
          _isLoading = false;
          notifyListeners();
        }
      }else{
        EasyLoading.showError("${response.statusCode}");
        _isLoading = false;
        notifyListeners();
      }

      log(response.body);
    // }on SocketException {
    //   _isLoading = false;
    //   notifyListeners();
    //   throw FetchDataException('No Internet Connection');
    // }
    // catch(e){
    //   EasyLoading.showError("Something went wrong. Please try again!!!");
    //   _isLoading = false;
    //   notifyListeners();
    // }
  }






}