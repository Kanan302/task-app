enum AppRoutes {
  splash(path: '/splash'),
  login(path: '/login'),
  register(path: '/register'),
  reset(path: '/reset'),
  home(path: '/homepage');

  const AppRoutes({required this.path});
  final String path;
}
