## 1.0.4

#### Android
* 네이티브 SDK 를 `1.0.6` 으로 갱신 (revupCore / revupAndroid / revupLuckyEvent)
* **[추가] 복권 화면 테마 옵션** — `setLuckyEventTheme(RevupLuckyEventTheme)`
  * `RevupLuckyEventTheme.light` / `dark` / `system` 중 선택
  * 네이티브 SDK 의 `RevupLuckyEvent.setEventTheme()` 로 전달된다

#### iOS
* 네이티브 SDK 를 `REVUP 1.1.6` 으로 갱신
* **[추가] 복권 화면 테마 옵션** — Android 와 동일한 `setLuckyEventTheme` 사용
  * 네이티브 SDK 의 `setLuckyEventUserInterfaceStyle:` 로 전달된다
  * `system` 은 `UIUserInterfaceStyleUnspecified` 에 대응한다

#### 공통
```dart
// 단말의 다크모드 설정을 따른다 (기본값)
await revup.setLuckyEventTheme(RevupLuckyEventTheme.system);
// 단말 설정과 무관하게 항상 라이트로 고정
await revup.setLuckyEventTheme(RevupLuckyEventTheme.light);

await revup.showLuckyEvent();
```

* 적용 범위는 **네이티브 영역**이다 — 화면 배경, 상태바 아이콘 대비, SDK 안내 팝업.
  복권 웹 콘텐츠는 웹이 정한 대로 표시된다.
* `showLuckyEvent()` 보다 먼저 호출해야 한다. 이미 떠 있는 화면에는 반영되지 않는다.

> **동작 변경:** 기본값이 `system` 이므로, 아무것도 설정하지 않으면 다크모드 단말에서
> 복권 화면의 네이티브 영역이 다크로 표시된다. 기존처럼 항상 라이트로 두려면
> `setLuckyEventTheme(RevupLuckyEventTheme.light)` 를 명시해야 한다.

## 1.0.3

#### iOS
* 네이티브 SDK 를 `REVUP 1.1.3` → **`1.1.5`** 로 갱신
  * podspec 자기정합성 확인 (subspec 26종의 내부 의존성이 모두 1.1.5 로 정렬)
  * 최소 배포 타겟 iOS 13.0 유지
  * `pod install` 2회 연속 통과 확인 — 1.1.1 / 1.1.2 에서 발생하던
    `Podfile.lock` 모순 기록 문제가 재발하지 않는다

## 1.0.2

#### Android
* 네이티브 SDK 를 1.0.3 으로 갱신 (revupCore / revupAndroid / revupLuckyEvent)
* **[수정] 복권 화면에서 다른 복권 이벤트를 열 수 없던 문제**
  * `TnkEventActivity` 는 `launchMode="singleTop"` 인데 네이티브 SDK 가
    `onNewIntent()` 를 처리하지 않아, 복권 화면이 이미 떠 있는 상태에서
    `showLuckyEvent` 를 다시 호출하면 기존 인스턴스로 흡수되고 화면이
    이전 이벤트 그대로 남았다.
  * SDK 1.0.3 에서 `onNewIntent()` 가 새 URL 을 다시 로드하도록 수정됐다.
  * 이에 맞춰 `showLuckyEvent` 가 `TnkEventActivity` 를 두 번 실행하던 중복
    호출(`TnkEventBuilder.show()` + 직접 `startActivity()`)을 제거했다.

> 이 수정은 네이티브 SDK 1.0.3 이 필요하다. 매체가 revupCore/revupAndroid/
> revupLuckyEvent 를 직접 선언해 하위 버전으로 고정하고 있다면 함께 올려야 한다.

## 1.0.1

#### Android
* **[수정] 신규 프로젝트에서 앱 빌드가 실패하던 문제**
  * `RevupFlutterPlugin` 이 `RevupInitializeListener`, `RewardedVideoAdListener`,
    `InterstitialAdListener`, `RewardedInterstitialAdShowListener` 를
    public 시그니처에 구현하는데, 네이티브 SDK 의존성이 `implementation` 이라
    앱 모듈로 전파되지 않았다.
  * 그 결과 앱이 `GeneratedPluginRegistrant` 를 컴파일할 때 실패했다.
    ```
    GeneratedPluginRegistrant.java:19: error: cannot access RevupInitializeListener
    ```
  * 우회하려면 앱의 `build.gradle` 에 revupCore/revupAndroid/revupLuckyEvent 를
    직접 선언해야 했다. `api` 로 변경해 그럴 필요가 없어졌다.

## 1.0.0

Revup Flutter Plugin 최초 공개 배포.

#### 지원 기능
* Initialize / 사용자 정보 설정 (`setUserId`, `setUserIdChild`)
* RewardedVideo — load / isLoaded / show, 보상 콜백
* Interstitial — load / isLoaded / show
* RewardedInterstitial — preload / preloadAll / load / show / showWithPopup, 유닛 상태 조회
* LuckyEvent(복권) — `setLuckyEventAppId` / `showLuckyEvent`, WebView scheme 콜백
* Adiscope 호환 레이어 (`package:revup_flutter_plugin/adiscope_compat.dart`)
  * 기존 `adiscope_flutter_plugin` 사용 매체가 import 한 줄만 바꿔 전환할 수 있다.
  * 자세한 내용은 [마이그레이션 가이드](doc/migration_from_adiscope.md) 참고.

> Offerwall 은 제공하지 않는다.

#### 네이티브 SDK
| 플랫폼 | 버전 |
| --- | --- |
| Android | `revup-bom 1.0.2` (revupCore / revupAndroid / revupLuckyEvent 1.0.2) |
| iOS | `REVUP 1.1.3` |

#### 요구 사항
* Android minSdk 23
* iOS 13.0+
* Android SDK 는 Maven Central 이 아닌 자체 Maven 저장소에 배포된다.
  연동 시 저장소 추가가 필요하다 (README 참고).
