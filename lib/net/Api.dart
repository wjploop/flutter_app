import 'package:dio/dio.dart';
import 'package:flutter_app/data/node.dart';
import 'package:retrofit/http.dart';

part 'Api.g.dart';

@RestApi(baseUrl: "https://www.v2ex.com/api/")
abstract class Api {
  factory Api(Dio dio) = _Api;

  @GET("/nodes/all.json")
  Future<List<TopicNode>> getNodes();

  @GET("/nodes/show.json")
  Future<TopicNode> showNodeById(@Query("id") String id);

  @GET("/nodes/show.json")
  Future<TopicNode> showNodeByName(@Query("name") String name);
}

void main() async {
  // print(api()==api());
  // print(api());



  api.showNodeById("1").then((value) => print(value));

  var m1 = Net();
  var m2 = Net();
  print(m1);
  print(m1.dio == m2.dio);
}


// Api api() => Net().api;

// class Net {
//   Api api;
//   Dio dio;
//
//   static final Net _net = new Net._internal();
//
//   factory Net() {
//     return _net;
//   }
//
//   Net._internal() {
//     _net.dio = createDio();
//     _net.api = Api(_net.dio);
//   }
// }

Api get api => Net().api;


class Net {
  Dio dio;
  Api api;

  static final Net _singleton =  Net._internal();

  factory Net() {
    return _singleton;
  }

  Net._internal() {
    dio = createDio();
    api = Api(dio);
    
  }
}

Api createApi() {}

Dio createDio() {
  var dio = Dio();
  dio.interceptors.add(LogInterceptor(requestBody: false, responseBody: true,requestHeader:false,responseHeader: false));
  return dio;
}
