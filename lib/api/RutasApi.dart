import 'dart:convert';
import 'dart:io';

import '../constants.dart';
import 'exception/ApiException.dart';

class RutasApi {
  final HttpClient _httpClient = HttpClient();
  final String URL = BASE_API_URL + '/rutas';

  // TODO: Aqui reemplazar por el objeto adecuado
  Future<List<dynamic>> getRutas() async {
    List<dynamic> retValue = new List<dynamic>();

    String url = URL + "?pagination=false&sort=-fecha_publicacion";
    Uri uri = Uri.parse(Uri.encodeFull(url));

    HttpClientRequest httpRequest = await _httpClient.getUrl(uri);
    httpRequest.headers.add("Content-Type", "application/json");

    HttpClientResponse httpResponse = await httpRequest.close();

    if (httpResponse.statusCode < HttpStatus.badRequest) {
      /*
      await httpResponse.transform(utf8.decoder).join()
          .then(json.decode)
          .then(
              (noticias) =>
              noticias.forEach( (noticia) => retValue.add( Noticia.fromJson(noticia) ) )
      );
      */
    } else {
      await httpResponse
          .transform(utf8.decoder)
          .join()
          .then(json.decode)
          .then((exception) => (throw new ApiException.fromJson(exception)));
    }
    //
    return retValue;
  }
}
