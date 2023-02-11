import 'package:http/http.dart' as http;
import 'dart:convert';

const key = "ee117edac6e1c6598d83207ce3c9fd2b";
class NetworkHelper{
  NetworkHelper({required this.url});
  String url;
  Future getData() async{
    http.Response response = await http.get(Uri.parse(url));
    if(response.statusCode == 200) {
      print(response.body);
      return jsonDecode(response.body);
    }else{
      print(response.statusCode);
    }
  }
}