class Config {
  static const pageSize = 5;
  static const timeout = 20;
  static const debug = bool.fromEnvironment(
    'DEBUG',
    defaultValue: true,
  );
  static const server = String.fromEnvironment(
    'SERVER',
    defaultValue: 'mob-test.sancananavrat.sk',
  );
}
