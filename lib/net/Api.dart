import 'package:dio/dio.dart';
import 'package:flutter_app/data/node.dart';
import 'package:retrofit/http.dart';

part 'Api.g.dart';

@RestApi(baseUrl: "https://www.v2ex.com/api/")
abstract class Api {
  factory Api(Dio dio) = _Api;

  @GET("/nodes/all.json")
  Future<List<Node>> getNodes();

  @GET("/nodes/show.json")
  Future<Node> showNodeById(@Query("id") String id);
}

void main() {
  var dio = Dio();
  dio.interceptors.add(LogInterceptor(requestBody: true,responseBody: true));
  var api = Api(dio);
  api.showNodeById("1").then((value) => print(value));
}
