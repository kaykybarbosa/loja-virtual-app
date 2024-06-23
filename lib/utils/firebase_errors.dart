abstract class FirebaseErrors {
  static String getError(String error, [String? errorDefault]) => switch (error) {
        'email-already-in-use' => 'E-mail já está em uso.',
        'invalid-email' => 'E-mail inválido.',
        'weak-password' => 'Senha muito fraca.',
        'user-not-found' => 'E-mail ou senha inválidos.',
        _ => errorDefault ?? 'Erro ao realizar sua solicitação.',
      };
}
