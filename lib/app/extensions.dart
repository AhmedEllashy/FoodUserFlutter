import 'constants.dart';

extension CheckNullString on String?{
  String checkNullString(){
    if(this == null){
      return AppConstants.empty;
    }else{
      return this!;
    }
  }
}
extension CheckNullInt on int?{
  int checkNullInt(){
    if(this == null){
      return AppConstants.zero;
    }else{
      return this!;
    }
  }
}