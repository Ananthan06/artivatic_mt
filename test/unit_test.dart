// This is a basic Flutter unit test.
// In terminal type: flutter test test/unit_test.dart.

import 'package:flutter_test/flutter_test.dart';

import 'response_test.dart';

void main() {
  String url = "https://run.mocky.io/v3/c4ab4c1c-9a55-4174-9ed2-cbbe0738eedf";
  String url2 = "https://run.mocky.io/v3/c4ab4c1c-9a55-4174-9ed2-cb";
  String url3 = "httpsmm://run.mocky.io/v3/c4ab4c1c-9a55-4174-9ed2-cb";

  group('Api response', () {
    test('response code should be 200', () async{
      expect( await WebServiceTest().getResponsePostDataTest(url), 200);
    });

    test('response != 200, so returns 0', () async{
      expect( await WebServiceTest().getResponsePostDataTest(url2), 0);
    });

    test('try catch error, so returns -1', () async{
      expect( await WebServiceTest().getResponsePostDataTest(url3), -1);
    });

  });
}