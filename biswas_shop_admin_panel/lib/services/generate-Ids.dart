
import 'package:uuid/uuid.dart';

class GenerateIds{
  String generateProductId(){
    String formatedProductId;
    String uuid = const Uuid().v4();

    formatedProductId = "biswas-shopping-${uuid.substring(0,5)}";

    return formatedProductId;
  }

}