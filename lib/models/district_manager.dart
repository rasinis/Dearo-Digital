import 'package:dearo_app/models/data/district.dart';
 
class DistrictManager{
  static Map<int, String> districts = {
  1: 'Ampara',
  2: 'Anuradhapura',
  3: 'Badulla',
  4: 'Batticaloa',
  5: 'Colombo',
  6: 'Galle',
  7: 'Gampaha',
  8: 'Hambantota',
  9: 'Jaffna',
  10: 'Kalutara',
  11: 'Kandy',
  12: 'Kegalle',
  13: 'Kilinochchi',
  14: 'Kurunegala',
  15: 'Mannar',
  16: 'Matale',
  17: 'Matara',
  18: 'Moneragala',
  19: 'Mullaitivu',
  20: 'Nuwara Eliya',
  21: 'Polonnaruwa',
  22: 'Puttalam',
  23: 'Ratnapura',
  24: 'Trincomalee',
  25: 'Vavuniya',
  };

  static Map<int, String> getDistricts(){
    return districts;
  }

  static District? getDistrict(int id){
    String? districtName = districts[id];

    if(districtName != null){
      return District(id: id, districtName: districtName);
    }else {
      return null;
    }
  }

  static getDistrictId(String s) {}
}