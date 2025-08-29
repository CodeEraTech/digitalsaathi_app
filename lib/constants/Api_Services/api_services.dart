import 'dart:convert';
import 'package:digitalsaathi/constants/app_url.dart';
import 'package:http/http.dart' as http;

import '../../data/model/content_post_model.dart';

class ApiServices {
  Future<Map<String, dynamic>> signupUser(String mobile) async {
    final response = await http.post(
      Uri.parse(AppUrl.sendOtp),
      body: {
        'mobile': mobile,
      },
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to SignUp');
    }
  }

  Future<Map<String, dynamic>> verifyOtp(String mobile, String otp) async {
    final url = Uri.parse(AppUrl.verifyOtp);
    final response = await http.post(url, body: {"mobile": mobile, "mobile_otp": otp});
    if (response.statusCode == 200) {
      print(response.body);
      return json.decode(response.body);
    } else {
      throw Exception(
          "failed to resend OTP : Status Code ${response.statusCode}");
    }
  }

  Future<Map<String, dynamic>> loginUser(String mobile) async {
    print("login API Url: ${AppUrl.loginOtp}");
    print("login API Url: ${mobile.toString()}");
    final response = await http.post(
      Uri.parse(AppUrl.loginOtp),
      body: {
        'mobile': mobile,
      },
    );

    print("login API status code: ${response.statusCode.toString()}");
    print("login API Response: ${response.body.toString()}");


    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to Login');
    }
  }
  Future<dynamic> verifyLoginUser(String mobile, String otp) async {
    final response = await http.post(
      Uri.parse(AppUrl.loginUser),
      body: {
        "device_id":"${AppUrl.FCM_TOKEN}","mobile":mobile,"mobile_otp":otp
      },
    );
    if (response.statusCode == 200) {
      print(response.body);
      return response.body;
    } else {
      throw Exception('Failed to Login');
    }
  }

  Future<dynamic> getRoleList() async {
    // print("login API AppUrl : ${AppUrl.getRoleList.toString()}");
    // final response = await http.get(
    //   Uri.parse(AppUrl.getRoleList),
    // );
    // print("login API Response : ${response.toString()}");
    // if (response.statusCode == 200) {
    //   print(response.body);
    //   return response.body;
    // } else {
    //   throw Exception('Failed to Login');
    // }
    print("getRoleList API AppUrl : ${AppUrl.getRoleList.toString()}");
    // var request = http.Request('GET', Uri.parse('http://newdgs.mydigitalsaathi.com/api/v3/getallroles'));

    final response = await http.get(
      Uri.parse('https://newdgs.mydigitalsaathi.com/api/v3/getallroles'),
      // headers: {
      //   'Accept': 'application/json',
      //   'Content-Type': 'application/json',
      // },
    );

    print("login API Response : ${response.body.toString()}");
    // http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      // print(await response.stream.bytesToString());
    }
    else {
      print(response.reasonPhrase);
    }

  }





  Future<List<String>> fetchNewsLetter() async {
    try {
      final response = await http.post(
          Uri.parse(AppUrl.getNewsLetter),
          body: {
            "api_token":AppUrl.apiToken
          });

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> newsletterData = data['data'] as List;
        return newsletterData
            .map((item) => item['post_url'] as String)
            .toList();
      } else {
        throw Exception('Failed to load News Letter Pdf');
      }
    } catch (e) {
      print('Error fetching News Letter Pdf: $e');
      throw e; // Rethrow the exception
    }
  }

  Future<Map<String, dynamic>> profileUpdate() async {
    final response = await http.post(
      Uri.parse("https://newdgs.mydigitalsaathi.com/api/v3/profile"),
      body: {
        'api_token': AppUrl.apiToken,
      },
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      if (jsonResponse['status_code'] == 200) {
        return jsonResponse['data'];
      } else {
        throw Exception(jsonResponse['status_text'] ?? 'Unknown error');
      }
    } else {
      throw Exception('Failed to update profile: ${response.statusCode}');
    }
  }

  Future<ContentPostModel?> fetchContentPosts() async {
    try {
      final response = await http.post(
        Uri.parse(AppUrl.getContent),
        // headers: {
        //   'Content-Type': 'application/json',
        // },
        body:{
          "api_token":AppUrl.apiToken
        },
      );
      if (response.statusCode == 200) {
        return ContentPostModel.fromJson(jsonDecode(response.body));
      } else {
        print('Error: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error fetching data: $e');
      return null;
    }
  }

  Future<Map<String, dynamic>> shareContent(String id) async {
    final response = await http.post(
      Uri.parse(AppUrl.shareContent),
      body: {
        'api_token': AppUrl.apiToken,
        "post_id":"$id",
        "type":"share"
      },
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to share data!');
    }
  }

  Future<Map<String, dynamic>> downloadContent(String id) async {
    final response = await http.post(
      Uri.parse(AppUrl.shareContent),
      body: {
        'api_token': AppUrl.apiToken,
        "post_id":"$id",
        "type":"download"
      },
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to download data!');
    }
  }

  Future<void> updateProfile(Map<String, dynamic> data) async {
    final Uri apiUrl = Uri.parse(AppUrl.updateProfile);

    try {
      final response = await http.post(
        apiUrl,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(data),
      );

      if (response.statusCode == 200) {
        return; // or return response if needed
      } else {
        // Handle error response
        throw Exception('Failed to submit data: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error occurred: $e');
    }
  }



}

