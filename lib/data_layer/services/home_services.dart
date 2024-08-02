import 'package:race_app/data_layer/api_helper.dart';
import 'package:race_app/data_layer/models/response_wrapper_model.dart';

class HomeService {
  final ApiHelper _apiHelper = ApiHelper();

  Future<ResponseWrapperModel?> getList() async {
    ResponseWrapperModel? response = await _apiHelper.getRequest();
    return response;
  }
}
