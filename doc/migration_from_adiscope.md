# Adiscope → Revup 마이그레이션 가이드 (앱 코드 수정 최소화)

기존 `adiscope_flutter_plugin`을 사용 중인 퍼블리셔가 **앱의 Dart 코드를 거의 수정하지 않고**
Revup SDK로 전환할 수 있도록 호환 레이어(`adiscope_compat.dart`)를 제공합니다.

`AdiscopeFlutterPlugin`, `AdiscopeListener` 등 **기존 클래스명과 메서드명을 그대로 사용**할 수 있으며,
내부 동작은 전부 Revup SDK로 위임됩니다.

---

## 1. Dart 코드 변경 (총 2줄)

### A. pubspec.yaml — 의존성 교체

```yaml
dependencies:
  # 변경 전
  # adiscope_flutter_plugin: ^5.4.0

  # 변경 후
  revup_flutter_plugin: ^1.0.0
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
(초기화 / 사용자 정보 / RewardedVideo / Interstitial / RewardedInterstitial / LuckyEvent / Etc — **총 36개**).

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

> AdMob App ID용 placeholder(예: `adiscope_admob_id`)는 퍼블리셔가 직접 정한 이름이므로
> 역시 그대로 두셔도 됩니다.

### B. 네이티브 의존성 — 변경 필요

```gradle
// 변경 전
implementation platform("com.nps.adiscope:adiscope-bom:5.4.0")
implementation 'com.nps.adiscope:adiscopeCore'
implementation 'com.nps.adiscope:adapter.admob'

// 변경 후
implementation platform("com.tnkfactory.revup:revup-bom:1.0.2")
implementation 'com.tnkfactory.revup:revupCore'
implementation 'com.tnkfactory.revup:adapter.admob'
```

### C. Maven 저장소 — 변경 필요

```gradle
// 변경 전
maven { url 'https://repository.adiscope.com/repository/adiscope/' }

// 변경 후
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
  pod 'REVUP/Core', '1.1.3'
  pod 'REVUP/LuckyEvent', '1.1.3'
  pod 'REVUP/AdMob', '1.1.3'
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

### ⚠️ 1.1.1 / 1.1.2 는 사용하지 마세요

`1.1.1` 과 `1.1.2` 는 podspec이 **자기모순 상태**입니다. subspec의 내부 의존성이
`REVUP/Core = 1.1.0` (1.1.2 는 `REVUP/Max = 1.1.0`)으로 고정되어 있어,
첫 `pod install` 은 통과하지만 `Podfile.lock` 에
`REVUP/Max (= 1.1.0, = 1.1.1)` 같은 모순이 기록되고 그 이후의
`pod install`(= `flutter build ios` 가 매번 실행)은 항상 실패합니다.

```
[!] CocoaPods could not find compatible versions for pod "REVUP/Max"
```

**`1.1.3` 에서 수정되었습니다.** 1.1.3 이상을 사용하세요.

| 버전 | podspec 자기정합성 | 최소 배포 타겟 |
| --- | --- | --- |
| **1.1.3** | ✅ OK | iOS 13.0 |
| 1.1.2 | ❌ NG | iOS 13.0 |
| 1.1.1 | ❌ NG | iOS 13.0 |
| 1.1.0 | ✅ OK | iOS 15.0 |

> 검증 방법: `rm -f Podfile.lock && pod install && pod install` — 두 번 다 통과해야 정상입니다.

### Info.plist 키

```xml
<!-- 변경 전 -->
<key>AdiscopeMediaId</key>
<key>AdiscopeMediaSecret</key>

<!-- 변경 후 -->
<key>REVUPMediaId</key>
<key>REVUPMediaSecret</key>
```

Android의 `adiscope_media_id` / `adiscope_media_secret` 매니페스트 키와 달리
**iOS Info.plist 키는 반드시 바꿔야 합니다.** SDK가 `REVUP` 접두어로만 읽습니다.

---

## 4. 주의사항 — Offerwall 미지원

**Revup SDK는 Offerwall(오퍼월) 기능을 제공하지 않습니다.**
따라서 호환 레이어에도 아래 API가 포함되어 있지 않으며, 사용 중이라면 컴파일 에러가 발생합니다.

| 미제공 API |
| --- |
| `showOfferwall()` |
| `showOfferwallDetail()` |
| `showOfferwallDetailFromUrl()` |
| `AdiscopeListener.setupOfferwallListener()` |

해당 코드를 사용 중이라면 제거가 필요하며, 대체 방안은 담당자와 협의해 주세요.

---

## 5. 신규 개발 시 권장 사항

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
