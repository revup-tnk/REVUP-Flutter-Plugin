# Adiscope → Revup 마이그레이션 가이드 (앱 코드 수정 최소화)

기존 `adiscope_flutter_plugin`을 사용 중인 퍼블리셔가 **앱의 Dart 코드를 거의 수정하지 않고**
Revup SDK로 전환할 수 있도록 호환 레이어(`adiscope_compat.dart`)를 제공합니다.

`AdiscopeFlutterPlugin`, `AdiscopeListener` 등 **기존 클래스명과 메서드명을 그대로 사용**할 수 있으며,
내부 동작은 전부 Revup SDK로 위임됩니다.

---

## 체크리스트

먼저 훑어보시고, 각 항목은 아래 해당 절에서 확인하세요.

**반드시 바꿔야 하는 것**

- [ ] `pubspec.yaml` 의존성을 `revup_flutter_plugin` 으로 교체 → [1-A](#a-pubspecyaml--의존성-교체)
- [ ] `import` 를 `package:revup_flutter_plugin/adiscope_compat.dart` 로 변경 → [1-B](#b-import-1줄-변경)
- [ ] Android 네이티브 의존성을 `com.tnkfactory.revup:*` 로 교체 → [2-B](#b-네이티브-의존성--변경-필요)
- [ ] Android Maven 저장소 주소 변경 → [2-C](#c-maven-저장소--변경-필요)
- [ ] iOS Podfile 의 pod 을 `REVUP/*` subspec 으로 교체 → [3](#3-ios-설정-변경)

**그대로 둬도 되는 것** (자주 오해하는 부분)

- [x] Android 매니페스트의 `adiscope_media_id` / `adiscope_media_secret` — 폴백 지원
- [x] iOS `Info.plist` 의 `AdiscopeMediaId` / `AdiscopeMediaSecret` — 폴백 지원
- [x] 복권 진입용 `adiscope{매체ID}://` scheme — 함께 등록됨
- [x] Dart 앱 코드(클래스명·메서드명·콜백) — 호환 레이어가 흡수

**확인이 필요한 것**

- [ ] Offerwall 사용 여부 — **Revup 은 미지원**, 사용 중이면 협의 필요 → [4](#4-주의사항--offerwall-미지원)
- [ ] 복권 화면 테마 기본값 변경 — 다크모드 단말에서 화면이 달라짐 → [5](#5-동작이-달라지는-부분--복권-화면-테마)
- [ ] 앱/서드파티 SDK 가 `com.adiscope.*` 클래스를 직접 참조하는지 → [6](#6-네이티브-코드가-adiscope-클래스를-참조하는-경우-android)

---

## 1. Dart 코드 변경 (총 2줄)

### A. pubspec.yaml — 의존성 교체

```yaml
dependencies:
  # 변경 전
  # adiscope_flutter_plugin: ^5.4.0

  # 변경 후
  revup_flutter_plugin: ^1.0.4
```

### B. import 1줄 변경

```dart
// 변경 전
import 'package:adiscope_flutter_plugin/adiscope_flutter_plugin.dart';

// 변경 후
import 'package:revup_flutter_plugin/adiscope_compat.dart';
```

### C. 그 외 앱 코드 — **수정 불필요**

클래스명·메서드명·콜백 파라미터가 모두 동일하므로 아래 코드는 **그대로 동작**합니다.

```dart
final _plugin = AdiscopeFlutterPlugin();          // 그대로

await _plugin.initialize();                        // 그대로
await _plugin.setUserId("user_id");                // 그대로
await _plugin.rewardedVideoLoad("UNIT_ID");        // 그대로
await _plugin.rewardedVideoShow();                 // 그대로

AdiscopeListener.setupRewardedVideoListener(       // 그대로
  onRewardedVideoAdLoaded: (unitId) { },
  onRewarded: (unitId, type, amount) { },
);
```

지원되는 API는 기존 Adiscope 플러그인과 동일합니다
(초기화 / 사용자 정보 / RewardedVideo / Interstitial / RewardedInterstitial / LuckyEvent / Etc).

---

## 2. Android 설정 변경

### A. AndroidManifest 설정값 — **수정 불필요**

Revup SDK는 기존과 **동일한 meta-data 키**를 읽습니다. 아래 값은 그대로 두시면 됩니다.

```gradle
manifestPlaceholders = [
        adiscope_media_id    : "...",   // 그대로 유지
        adiscope_media_secret: "...",   // 그대로 유지
        adiscope_sub_domain  : "..."    // 그대로 유지
]
```

SDK는 `revup_media_id` 를 먼저 찾고, 없으면 `adiscope_media_id` 로 폴백합니다.
(`media_secret`, `sub_domain` 도 동일) 그래서 기존 매니페스트를 고칠 필요가 없습니다.
신규 설정이라면 `revup_*` 쪽을 권장합니다.

> AdMob App ID용 placeholder(예: `adiscope_admob_id`)는 퍼블리셔가 직접 정한 이름이므로
> 역시 그대로 두셔도 됩니다.

> **복권(LuckyEvent) scheme 은 양쪽을 모두 받습니다.**
> `revup{매체ID}://thirdpartyevent` 와 `adiscope{매체ID}://thirdpartyevent` 가 함께 등록되므로,
> 외부에서 옛 scheme 으로 진입시키던 경로도 그대로 동작합니다.

### B. 네이티브 의존성 — 변경 필요

```gradle
// 변경 전
implementation platform("com.nps.adiscope:adiscope-bom:5.4.0")
implementation 'com.nps.adiscope:adiscopeCore'
implementation 'com.nps.adiscope:adapter.admob'

// 변경 후
implementation platform("com.tnkfactory.revup:revup-bom:1.0.6")
implementation 'com.tnkfactory.revup:revupCore'
implementation 'com.tnkfactory.revup:adapter.admob'
```

### C. Maven 저장소 — 추가 필요

```gradle
// 아래의 저장소가 없을 경우 추가
maven { url 'https://repository.tnkad.net:8443/repository/android/' }
```

어댑터별 추가 저장소는 [example 앱의 `android/build.gradle`](../example/android/build.gradle)을 참고하세요.

---

## 3. iOS 설정 변경

Podfile의 Adiscope pod을 REVUP pod으로 교체합니다.

REVUP은 **단일 pod + subspec** 구조입니다. Adiscope처럼 `AdiscopeMediaAdMob` 같은
독립 pod이 있는 것이 아니라 `REVUP/AdMob` 형태의 subspec을 지정합니다.

```ruby
platform :ios, '13.0'

target 'Runner' do
  # REVUP.xcframework 는 정적 라이브러리이므로 static linkage 가 필요합니다
  use_frameworks! :linkage => :static
  use_modular_headers!

  # 변경 전
  # pod 'Adiscope/LuckyEvent', '5.4.0'

  # 변경 후 — 필요한 subspec 만 추가
  pod 'REVUP/Core', '1.1.9'
  pod 'REVUP/LuckyEvent', '1.1.9'
  pod 'REVUP/AdMob', '1.1.9'
  # ...
end
```

### subspec 대응표

| Adiscope | REVUP |
| --- | --- |
| `Adiscope` / `Adiscope/Core` | `REVUP/Core` |
| `Adiscope/LuckyEvent` | `REVUP/LuckyEvent` |
| `AdiscopeMediaAdMob` | `REVUP/AdMob` |
| `AdiscopeMediaAdManager` | `REVUP/AdManager` |
| `AdiscopeMediaChartBoost` | `REVUP/ChartBoost` |
| `AdiscopeMediaPangle` | `REVUP/Pangle` |
| `AdiscopeMediaVungle` | `REVUP/Vungle` |
| `AdiscopeMediaTnkPub` | `REVUP/TnkPub` |
| `AdiscopeMediaMax` | `REVUP/Max` |
| `AdiscopeMediaMaxAdapterAdMob` | `REVUP/MaxMediaAdMob` |
| `AdiscopeMediaMaxAdapter*` | `REVUP/MaxMedia*` |
| `AdiscopeMediaMaxAdapterAmazon` | **대응 없음** |

전체 subspec 26종은 [README의 Setup iOS](../README.md#3-setup-ios)를 참고하세요.



1.1.9를 사용하세요.

| 버전 | podspec 자기정합성 | 최소 배포 타겟 |
| --- | --- | --- |
| **1.1.9** (최신) | ✅ OK | iOS 13.0 |


> 검증 방법: `rm -f Podfile.lock && pod install && pod install` — 두 번 다 통과해야 정상입니다.

### Info.plist 키 — **수정 불필요**

Revup iOS SDK는 `REVUPMediaId` 를 먼저 찾고, 없으면 `AdiscopeMediaId` 로 폴백합니다.
`MediaSecret` 도 동일합니다. 기존 키를 그대로 두셔도 동작합니다.

```xml
<!-- 그대로 둬도 됨 -->
<key>AdiscopeMediaId</key>
<key>AdiscopeMediaSecret</key>

<!-- 신규 설정이라면 이쪽을 권장 -->
<key>REVUPMediaId</key>
<key>REVUPMediaSecret</key>
```

> 두 키가 모두 있으면 `REVUP*` 가 우선합니다. 값이 서로 다르면 혼란의 원인이 되므로
> 한쪽만 남기시는 편이 좋습니다.

---

## 4. 주의사항 — Offerwall 미지원

**Revup SDK는 Offerwall(오퍼월) 기능을 제공하지 않습니다.**

---

## 5. 동작이 달라지는 부분 — 복권 화면 테마

`revup_flutter_plugin 1.0.4`(Android SDK `1.0.6` / iOS `1.1.9`)부터 복권 화면에 테마 옵션이
생겼고, **기본값이 "단말의 다크모드 설정을 따름"** 입니다.

Adiscope 시절에는 다크모드 단말에서도 항상 라이트로 보였으므로,
**아무 설정도 하지 않으면 다크모드 사용자에게 화면이 다르게 보입니다.**

적용 범위는 SDK가 그리는 **네이티브 영역**입니다 — 화면 배경, 상태바·내비게이션바 아이콘 대비,
SDK 안내 팝업. 복권 웹 페이지 자체는 웹에서 정한 대로 표시됩니다.

기존과 동일하게 항상 라이트로 두려면 명시해 주세요.

```dart
// 복권 화면을 열기 전에 한 번 호출
await plugin.setLuckyEventTheme(RevupLuckyEventTheme.light);
await plugin.showLuckyEvent();
```

| 값 | 동작 |
| --- | --- |
| `RevupLuckyEventTheme.light` | 단말 설정과 무관하게 항상 라이트 (Adiscope 시절과 동일) |
| `RevupLuckyEventTheme.dark` | 단말 설정과 무관하게 항상 다크 |
| `RevupLuckyEventTheme.system` | 단말 다크모드 설정을 따름 (**기본값**) |

호환 레이어(`adiscope_compat.dart`)에서도 같은 이름으로 호출할 수 있습니다.

---

## 6. 네이티브 코드가 Adiscope 클래스를 참조하는 경우 (Android)

앱이나 앱이 사용하는 **서드파티 SDK가 `com.adiscope.*` 클래스로 컴파일된 바이너리**를
들고 있으면, 의존성만 교체했을 때 `NoClassDefFoundError` 가 발생합니다.
Dart 코드만 쓰는 매체에는 해당하지 않습니다.

이 경우 호환 계층 모듈을 추가하면 **소스 수정 없이** 해결됩니다.

```groovy
dependencies {
    implementation platform("com.tnkfactory.revup:revup-bom:1.0.6")
    implementation "com.tnkfactory.revup:revupCore"
    implementation "com.tnkfactory.revup:revupAndroid"
    implementation "com.tnkfactory.revup:revupLuckyEvent"

    // adiscope 시절 클래스명을 유지해 주는 호환 계층
    implementation "com.tnkfactory.revup:revup_shim"
}
```

옛 공개 API를 같은 패키지·같은 시그니처로 유지하고 호출을 revup 구현으로 위임합니다.
필요 여부가 애매하면 담당자에게 문의해 주세요.

---

## 7. 신규 개발 시 권장 사항

호환 레이어는 **마이그레이션 편의를 위한 것**입니다.
신규 코드는 Revup 정식 API 사용을 권장합니다.

```dart
import 'package:revup_flutter_plugin/revup_flutter_plugin.dart';

final plugin = RevupFlutterPlugin();
RevupListener.setupRewardedVideoListener(/* ... */);
```

전환 시 이름 대응은 아래와 같습니다.

| Adiscope (호환 레이어) | Revup (정식) |
| --- | --- |
| `AdiscopeFlutterPlugin` | `RevupFlutterPlugin` |
| `AdiscopeListener` | `RevupListener` |

메서드명·파라미터는 **완전히 동일**하므로 클래스명만 바꾸면 됩니다.
