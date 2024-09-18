class Routes{
  Routes._();
  static const String home = "/";
  static const String dashbaord = "$home/dashboard";
  static const String checkList = "/check_list";
  static const String createTask = "/task/create";
  static const String task = "/task/:taskId";
  static  String taskById(int? id) => "/task/$id";
}