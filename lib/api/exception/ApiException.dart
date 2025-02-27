

class ApiException implements Exception {

  int code = 0;

  String name;

  String message;

  int status = 0;

  String type;

  Exception innerException;

  StackTrace stackTrace;

  ApiException({this.code, this.name, this.message, this.status, this.type, this.innerException, this.stackTrace});

  factory ApiException.fromJson(dynamic json){
    if( json is List<dynamic>){
      return new ApiException(
        code: 500,
        name: 'Errores',
        message: json.join(" - "),
        status: 500,
        type: 'list',
      );
    }
    if( json is  Map<String, dynamic>){
      return new ApiException(
        code: json['code'] as num,
        name: json['name'] as String,
        message: json['message'] as String,
        status: json['status'] as num,
        type: json['type'] as String,
      );
    }
    return new ApiException(code: 500, name: 'Desconocido', message: '$json', status: -1);    
  }

  String toString() {
    if (message == null) return "Error inesperado";

    if (innerException == null) {
      print("ApiException $code:$name [$status:$type]: $message");
    }
    else{
      print("ApiException $code:$name [$status:$type]: $message");
      print(stackTrace);
    }
    return message;
  }

}