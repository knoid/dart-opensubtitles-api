part of opensubtitles_api;

Future<Map> ServerInfo() =>
    _call('ServerInfo');

Future<Map> LogIn(String user, String passwd, String lang, String ua) =>
    _call('LogIn', [user, passwd, lang, ua]);

Future<Map> CheckMovieHash(String token, List<String> moviesHashes) =>
    _call('CheckMovieHash', [token, moviesHashes]);

Future<Map> SearchSubtitles(String token, List<Map> searches) =>
    _call('SearchSubtitles', [token, searches]);

Future<Map> _call(String method, [List params]) {
  return post(_SERVER_URL,
      body: new RpcRequest(method, params).toString()
  ).then((res) {
    return new RpcResponse.fromXmlString(res.body).params[0];
  });
}
