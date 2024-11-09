
import 'package:uuid/uuid.dart';

class GenerateId{
  String generateProductId(){
    String formatedProductId;
    String uuid = const Uuid().v4();

    formatedProductId = "biswas-shopping-${uuid.substring(0,5)}";

    return formatedProductId;
  }

}