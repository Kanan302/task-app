enum AppRoutes {
  splash(path: '/splash'),
  login(path: '/login'),
  register(path: '/register'),
  reset(path: '/reset'),
  navbar(path: '/navbar');

  const AppRoutes({required this.path});
  final String path;
}
