class ApiErrorHandler {
  static String translateErrorMsg(String message) {
    switch (message) {
      //Login
      case 'Invalid login credentials':
        return 'Credenciales inválidas';
      //Reset Password
      case 'User not found':
        return 'Usuario no encontrado';
      case 'For security purposes, you can only request this once every 60 seconds':
        return 'Solo se puede solicitar este recurso una vez por minuto';
      default:
        return 'Error al realizar petición';
    }
  }
}
