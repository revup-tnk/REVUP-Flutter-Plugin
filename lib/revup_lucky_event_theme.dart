/// 복권(LuckyEvent) 화면의 테마.
///
/// 웹 콘텐츠가 아니라 **네이티브 영역**에 적용됩니다.
/// - Android: 윈도우/웹뷰 배경, 상태바·내비게이션바 아이콘 대비, SDK 안내 다이얼로그
/// - iOS: 뷰컨트롤러 배경, 상태바 아이콘, SDK 안내 팝업
///
/// 설정하지 않으면 [RevupLuckyEventTheme.system] - 단말의 다크모드 설정을 따릅니다.
enum RevupLuckyEventTheme {
  /// 단말 설정과 무관하게 항상 라이트.
  light('light'),

  /// 단말 설정과 무관하게 항상 다크.
  dark('dark'),

  /// 단말의 시스템 다크모드 설정을 따릅니다. 기본값입니다.
  system('system');

  const RevupLuckyEventTheme(this.value);

  /// 네이티브로 전달되는 문자열 값.
  final String value;
}
