
import 'package:http/http.dart' as http;

class WebServiceTest {



  Future<int?> getResponsePostDataTest(String url) async {
    try {
      final response = await http.get(
          Uri.parse(url)
      );
      var statusCode = response.statusCode;
      if (statusCode < 200 || statusCode > 400 ){

        return 0;
      } else {
        return statusCode;
      }
    } catch (e) {
      return -1;
    }
  }





}