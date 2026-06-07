import 'browser_url_service_stub.dart'
    if (dart.library.html) 'browser_url_service_web.dart' as platform;

const List<String> _screenKeys = [
  'timer',
  'tasks',
  'stats',
  'settings',
  'account',
];

void setAppScreenInUrl(String screen) {
  if (!_screenKeys.contains(screen)) {
    return;
  }

  final query = Map<String, String>.from(Uri.base.queryParameters);

  query['screen'] = screen;

  // Aktions-Parameter entfernen, damit sie nach Reload nicht erneut ausgeführt werden.
  query.remove('reset_token');
  query.remove('set_token');
  query.remove('email_verified');

  // OAuth-Parameter entfernen
  query.remove('oauth_provider');
  query.remove('code');
  query.remove('state');
  query.remove('error');
  query.remove('error_description');

  _replaceQuery(query);
}

void clearLoginActionQueryParameters() {
  final query = Map<String, String>.from(Uri.base.queryParameters);

  query['screen'] = 'account';
  query.remove('reset_token');
  query.remove('set_token');
  query.remove('email_verified');

  query.remove('oauth_provider');
  query.remove('code');
  query.remove('state');
  query.remove('error');
  query.remove('error_description');

  _replaceQuery(query);
}

void _replaceQuery(Map<String, String> query) {
  final uri = Uri.base;

  final updatedUri = query.isEmpty
      ? uri.replace(query: '')
      : uri.replace(queryParameters: query);

  platform.replaceUrl(updatedUri.toString());
}
