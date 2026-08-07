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
