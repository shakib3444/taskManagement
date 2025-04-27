class Urls{
  static const String _baseUrl = "http://35.73.30.144:2005/api/v1";

  static const String registerUrl ='$_baseUrl/Registration'; //post
  static const String loginUrl = '$_baseUrl/Login'; //post
  static const String recoverResetPassword = '$_baseUrl/RecoverResetPassword'; //post
  static const String updateProfileUrl = '$_baseUrl/ProfileUpdate';
  static const String createTaskUrl = '$_baseUrl/createTask'; //post
  static const String taskStatusCountUrl = '$_baseUrl/taskStatusCount';
  static const String newTaskListUrl = '$_baseUrl/listTaskByStatus/New';
  static const String progressTaskListUrl =
      '$_baseUrl/listTaskByStatus/Progress';
  static const String completedTaskListUrl =
      '$_baseUrl/listTaskByStatus/Completed';
  static const String cancelledTaskListUrl =
      '$_baseUrl/listTaskByStatus/Cancelled';

  static String updateTaskStatusUrl(String taskId, String status) => '$_baseUrl/updateTaskStatus/$taskId/$status';
  static String recoverVerifyEmail(String email,) => '$_baseUrl/RecoverVerifyEmail/$email';
  static String recoverVerifyOtp(String email,String otp) => '$_baseUrl/RecoverVerifyOtp/$email/$otp';

  static String deleteTaskUrl(String taskId) => '$_baseUrl/deleteTask/$taskId';
}