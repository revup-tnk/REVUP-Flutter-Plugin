## Unreleased

#### Example
* **예제 앱 Android 빌드를 Flutter 3.47 에 맞춤** — AGP `8.9.3` → `8.11.1`, Kotlin `2.1.21` → `2.2.20`.
  Flutter 3.47 은 AGP 8.11.1 · Kotlin 2.2.20 미만인 앱의 빌드를 거부한다
* Flutter 3.47 마이그레이터가 추가한 `android.builtInKotlin=false` / `android.newDsl=false`
  (`example/android/gradle.properties`) 와 `analyzer.exclude` (`analysis_options.yaml`) 반영
* 플러그인 본체는 변경 없음 — 매체 앱 빌드에는 앱의 AGP 가 쓰인다.
  Flutter 3.47 로 새로 만든 앱(AGP 9.1.0 · Gradle 9.3.1)에서 1.1.0 빌드 확인

## 1.1.0

#### iOS
* **네이티브 SDK 를 `REVUP 1.1.11` 로 갱신** — podspec `REVUP/Core` 제약을 `'~> 1.1.9'` → `'~> 1.1.11'`
* **[변경] iOS 최소 지원 버전 13.0 → 15.0** (Xcode 27 대응) — podspec `s.platform` 을 `'15.0'` 으로 상향.
  **앱의 iOS deployment target 이 14.x 이하면 이 릴리스를 적용할 수 없다.**
  REVUP iOS SDK 자체는 1.1.11 에서도 13.0 을 지원하므로, 15.0 은 플러그인 쪽 요구사항이다
* README / 마이그레이션 문서의 Podfile 예시를 `1.1.11` + 15.0 + Xcode 27 용 `post_install` 로 갱신

#### Android
* 변경 없음 (`revupCore` / `revupAndroid` / `revupLuckyEvent` `1.0.9` 유지)

## 1.0.5

#### Android
* 네이티브 SDK 를 `1.0.9` 으로 갱신 (revupCore / revupAndroid / revupLuckyEvent)
* **[변경] 플러그인 `minSdkVersion` 21 → 24** — 네이티브 SDK `1.0.9` 가 minSdk 24 를 요구한다.
  Meta(FAN) 비더 어댑터와 `play-services-ads 25.5.0` 이 직접 원인이다.
  **앱의 `minSdkVersion` 이 23 이하면 이 버전을 적용할 수 없다**
* 네이티브 `1.0.9` 가 가져오는 변경 (상세는 Android SDK 릴리즈 노트 참조)
  * SDK 가 넣던 과도한 ProGuard keep 규칙 제거 — Play Console 의 'DEX 코드 최적화' 점수 개선.
    `adapter.vungle` 이 `com.google.android.gms.**` 전체를 keep 하던 규칙이 가장 컸다
  * AGP 9 R8 full mode 릴리즈 빌드가 시작 직후 죽던 문제 해결
  * 네트워크 SDK 최신화 — MAX 13.6.4 / admob 25.5.0 / chartboost 9.14.1 / pangle 8.3.0.4 / vungle 7.7.8
* 예제 앱의 BOM 을 `1.0.9` 로 갱신

#### iOS
* 변경 없음 (`REVUP/Core ~> 1.1.9` 유지)

## 1.0.4

#### Android
* 네이티브 SDK 를 `1.0.6` 으로 갱신 (revupCore / revupAndroid / revupLuckyEvent)
* **[추가] 복권 화면 테마 옵션** — `setLuckyEventTheme(RevupLuckyEventTheme)`
  * `RevupLuckyEventTheme.light` / `dark` / `system` 중 선택
  * 네이티브 SDK 의 `RevupLuckyEvent.setEventTheme()` 로 전달된다

#### iOS
* 네이티브 SDK 를 `REVUP 1.1.9` 로 갱신
* **[변경] podspec 의 `REVUP/Core` 제약을 하드핀에서 범위로 완화** — `'1.1.5'` → `'~> 1.1.9'`
  * `REVUP` 의 각 subspec 은 자기 버전과 동일한 `REVUP/Core (= X)` 를 요구한다.
    코어를 한 버전에 못박으면 매체가 `REVUP/LuckyEvent` 등 다른 subspec 만
    상위 패치로 올릴 때 CocoaPods 해석이 실패했다.
  * 하한 `1.1.9` — LuckyEvent 테마가 들어간 버전이자 결함이 있는 `1.1.1` / `1.1.2` 를
    배제하는 선. 상한은 `1.2.0` 미만이다.
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
