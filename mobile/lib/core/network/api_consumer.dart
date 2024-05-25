abstract class ApiConsumer{

    Future<dynamic> get(String path,
      {Map<String, dynamic>? queryParameters, String? token});

  Future<dynamic> post(String path,
      {Map<String, dynamic>? body,
      Map<String, dynamic>? queryParameters,
      String? token,
      bool? formDataIsEnabled});

     Future<dynamic> delete(String path,
      {Map<String, dynamic>? body,
      Map<String, dynamic>? queryParameters,
      String? token,
      bool? formDataIsEnabled});


    Future<dynamic> put(String path,
        {Map<String, dynamic>? body,
          Map<String, dynamic>? queryParameters,
          String? token,
          bool? formDataIsEnabled});

    Future<dynamic> postFile(
        String path, {
          bool? isFormData,
          Map<String, dynamic>? queryParameters,
          String? token,
          Map<String,dynamic>? formData
        });

}