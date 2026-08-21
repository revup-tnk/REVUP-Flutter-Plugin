import 'package:flutter/services.dart';
import 'revup_flutter_plugin_platform_interface.dart';
import 'revup_lucky_event_theme.dart';

export 'revup_lucky_event_theme.dart';

class RevupFlutterPlugin {
  /// Initialize adisocpe with [mediaid, mediasecret, callbackTag, childYN].
  Future<bool?> initialize(
      [String mediaId = "",
      String mediaSecret = "",
      String callbackTag = "",
      String childYN = ""]) {
    if (mediaId.isNotEmpty ||
        mediaSecret.isNotEmpty ||
        callbackTag.isNotEmpty ||
        childYN.isNotEmpty) {
      return RevupFlutterPluginPlatform.instance
          .initialize(mediaId, mediaSecret, callbackTag, childYN);
    } else {
      return RevupFlutterPluginPlatform.instance.initialize();
    }
  }

  /// User information settings
  Future<bool?> setUserId(String userId) {
    return RevupFlutterPluginPlatform.instance.setUserId(userId);
  }

  /// User, Child information settings
  Future<bool?> setUserIdChild(String userId, int child) {
    return RevupFlutterPluginPlatform.instance.setUserIdChild(userId, child);
  }

  /// Add Rewarded Callback
  Future<bool?> setRewardedCheckParam(String param) {
    return RevupFlutterPluginPlatform.instance.setRewardedCheckParam(param);
  }

  /// Check initialize
  Future<bool?> isInitialized() {
    return RevupFlutterPluginPlatform.instance.isInitialized();
  }

  /// Check revup sdk version
  Future<String?> getSDKVersion() {
    return RevupFlutterPluginPlatform.instance.getSDKVersion();
  }

  /// Check the versions of third-party networks
  Future<String?> getNetworkVersions() {
    return RevupFlutterPluginPlatform.instance.getNetworkVersions();
  }

  /// Check unit status of rewardedvideo with [unitId]
  Future<Map?> getUnitStatus(String unitId) {
    return RevupFlutterPluginPlatform.instance.getUnitStatus(unitId);
  }

  /// Max Mediation Debugger
  Future<bool?> showMaxMediationDebugger() {
    return RevupFlutterPluginPlatform.instance.showMaxMediationDebugger();
  }

  /// Admob Mediation Debugger
  Future<bool?> showAdmobMediationDebugger() {
    return RevupFlutterPluginPlatform.instance.showAdmobMediationDebugger();
  }

  /// Adjust advertising sound with [isOn]
  Future<bool?> setVolumeOff(bool isOn) {
    return RevupFlutterPluginPlatform.instance.setVolumeOff(isOn);
  }

  /// Adjust advertising sound with [isOn]
  Future<bool?> setShowWithLoad2BackgroundColor(String red, String green, String blue, String alpha) {
    return RevupFlutterPluginPlatform.instance.setShowWithLoad2BackgroundColor(red, green, blue, alpha);
  }

  /// Adjust advertising sound with [isOn]
  Future<bool?> setShowWithLoad2IndicatorStyle(bool isMedium, bool isHidden) {
    return RevupFlutterPluginPlatform.instance.setShowWithLoad2IndicatorStyle(isMedium, isHidden);
  }

  /// Adjust advertising sound with [isOn]
  Future<bool?> setShowWithLoad2ErrorAlert(String msg, bool isHidden) {
    return RevupFlutterPluginPlatform.instance.setShowWithLoad2ErrorAlert(msg, isHidden);
  }

  /// Show Lucky Event.
  Future<bool?> showLuckyEvent() {
    return RevupFlutterPluginPlatform.instance.showLuckyEvent();
  }

  /// Set Lucky Event of Event AppId & PubId.
  Future<bool?> setLuckyEventAppId(String eventId, String pid) {
    return RevupFlutterPluginPlatform.instance.setLuckyEventAppId(eventId, pid);
  }

  /// Set Lucky Event of SafeArea.
  Future<bool?> setLuckyEventUseSafeAreaWebView(bool useSafeArea) {
    return RevupFlutterPluginPlatform.instance.setLuckyEventUseSafeAreaWebView(useSafeArea);
  }

  /// Set Lucky Event of edge swipe gesture. (iOS only)
  Future<bool?> setLuckyEventEdgeGesture(bool isEdgeGesture) {
    return RevupFlutterPluginPlatform.instance.setLuckyEventEdgeGesture(isEdgeGesture);
  }

  /// Set Lucky Event of HashMark.
  Future<bool?> setLuckyEventHashMark(String hashMark) {
    return RevupFlutterPluginPlatform.instance.setLuckyEventHashMark(hashMark);
  }

  /// Set Lucky Event of BaseUrl.
  Future<bool?> setLuckyEventBaseUrl(String baseUrl) {
    return RevupFlutterPluginPlatform.instance.setLuckyEventBaseUrl(baseUrl);
  }

  /// Set Lucky Event of ExtraParam.
  Future<bool?> setLuckyEventExtraParam(String key, String value) {
    return RevupFlutterPluginPlatform.instance.setLuckyEventExtraParam(key, value);
  }

  /// 복권 화면의 테마를 설정합니다. (네이티브 영역만 적용 - 웹 콘텐츠는 웹이 정한 대로 보입니다)
  ///
  /// 이후에 여는 화면부터 적용되므로 [showLuckyEvent] 보다 먼저 호출해야 합니다.
  /// 이미 떠 있는 화면에는 반영되지 않습니다.
  ///
  /// 설정하지 않으면 [RevupLuckyEventTheme.system]으로 동작합니다.
  ///
  /// ```dart
  /// // 단말 설정과 무관하게 항상 라이트로 고정하는 경우
  /// await revup.setLuckyEventTheme(RevupLuckyEventTheme.light);
  /// await revup.showLuckyEvent();
  /// ```
  Future<bool?> setLuckyEventTheme(RevupLuckyEventTheme theme) {
    return RevupFlutterPluginPlatform.instance.setLuckyEventTheme(theme);
  }

  /// Show With Load rewardedVideo of [unitId] value.
  Future<bool?> rewardedVideoShowWithLoad(String unitId) {
    return RevupFlutterPluginPlatform.instance.rewardedVideoShowWithLoad(unitId);
  }

  /// Load rewardedVideo of [unitId] value.
  Future<bool?> rewardedVideoLoad(String unitId) {
    return RevupFlutterPluginPlatform.instance.rewardedVideoLoad(unitId);
  }

  /// Check the Load status of the rewardedVideo of the [unitId] value.
  Future<bool?> rewardedVideoIsLoad(String unitId) {
    return RevupFlutterPluginPlatform.instance.rewardedVideoIsLoad(unitId);
  }

  /// Show rewardedVideo.
  Future<bool?> rewardedVideoShow() {
    return RevupFlutterPluginPlatform.instance.rewardedVideoShow();
  }

  /// Show With Load interstitial of [unitId] value.
  Future<bool?> interstitialShowWithLoad(String unitId) {
    return RevupFlutterPluginPlatform.instance.interstitialShowWithLoad(unitId);
  }

  /// Load interstitial of [unitId] value.
  Future<bool?> interstitialLoad(String unitId) {
    return RevupFlutterPluginPlatform.instance.interstitialLoad(unitId);
  }

  /// Check the Load status of the interstitial of the [unitId] value.
  Future<bool?> interstitialIsLoad(String unitId) {
    return RevupFlutterPluginPlatform.instance.interstitialIsLoad(unitId);
  }

  /// Show interstitial.
  Future<bool?> interstitialShow() {
    return RevupFlutterPluginPlatform.instance.interstitialShow();
  }

  /// Check unit status of RewardedInterstitial with [unitId]
  Future<Map?> getUnitStatusRewardedInterstitial(String unitId) {
    return RevupFlutterPluginPlatform.instance
        .getUnitStatusRewardedInterstitial(unitId);
  }

  /// Loads RewardedInterstitial of [unitId] value.
  Future<bool?> loadRewardedInterstitial(String unitId) {
    return RevupFlutterPluginPlatform.instance.loadRewardedInterstitial(unitId);
  }

  /// Loads all units of RewardedInterstitial.
  Future<bool?> preLoadAllRewardedInterstitial() {
    return RevupFlutterPluginPlatform.instance
        .preLoadAllRewardedInterstitial();
  }

  /// Loads the [unitIds] values of RewardedInterstitial.
  Future<bool?> preLoadRewardedInterstitial(List<String>? unitIds) {
    return RevupFlutterPluginPlatform.instance
        .preLoadRewardedInterstitial(unitIds);
  }

  /// Check the Load status of the RewardedInterstitial of the [unitId] value.
  Future<bool?> rewardedInterstitialIsLoad(String unitId) {
    return RevupFlutterPluginPlatform.instance.rewardedInterstitialIsLoad(unitId);
  }

  /// Show immediately RewardedInterstitial of [unitId] value. (without popup)
  Future<bool?> showRewardedInterstitial(String unitId) {
    return RevupFlutterPluginPlatform.instance
        .showRewardedInterstitial(unitId);
  }

  /// Show RewardedInterstitial of [unitId] value. (with Revup popup)
  Future<bool?> showWithPopupRewardedInterstitial(String unitId) {
    return RevupFlutterPluginPlatform.instance
        .showWithPopupRewardedInterstitial(unitId);
  }
}

class RevupListener {
  /// Register listener channel of luckyEvent
  static final listenerLuckyEventChannel =
  const MethodChannel('revupLuckyEventListener');

  /// Register listener channel of rewardedVideo
  static final listenerRewardedVideoChannel =
  const MethodChannel('revupRewardedVideoListener');

  /// Register listener channel of interstitial
  static final listenerInterstitialChannel =
      const MethodChannel('revupInterstitialListener');

  /// Register listener channel of rewardedInterstitial
  static final listenerRewardedInterstitialChannel =
      const MethodChannel('revupRewardedInterstitialListener');

  /// Register listener of LuckyEvent
  static Future<void> setupLuckyEventListener({
    Function(String)? luckyEventWebViewNavigated
  }) async {
    listenerLuckyEventChannel.setMethodCallHandler((call) async {
      switch (call.method) {
        case 'luckyEventWebViewNavigated':
          if (luckyEventWebViewNavigated != null) {
            luckyEventWebViewNavigated(call.arguments as String);
          }
          break;
        default:
          break;
      }
    });
  }

  /// Register listener of rewardedVideo
  static Future<void> setupRewardedVideoListener({
    Function(String)? onRewardedVideoAdLoaded,
    Function(String, int, String, String)? onRewardedVideoAdFailedToLoad,
    Function(String)? onRewardedVideoAdOpened,
    Function(String)? onRewardedVideoAdClosed,
    Function(String, String, int)? onRewarded,
    Function(String, int, String, String)? onRewardedVideoAdFailedToShow,
  }) async {
    listenerRewardedVideoChannel.setMethodCallHandler((call) async {
      switch (call.method) {
        case 'onRewardedVideoAdLoaded':
          if (onRewardedVideoAdLoaded != null) {
            onRewardedVideoAdLoaded(call.arguments as String);
          }
          break;
        case 'onRewardedVideoAdFailedToLoad':
          if (onRewardedVideoAdFailedToLoad != null) {
            List<dynamic> args = call.arguments as List<dynamic>;
            onRewardedVideoAdFailedToLoad(
                args[0] as String, args[1] as int, args[2] as String, args[3] as String);
          }
          break;
        case 'onRewardedVideoAdOpened':
          if (onRewardedVideoAdOpened != null) {
            onRewardedVideoAdOpened(call.arguments as String);
          }
          break;
        case 'onRewardedVideoAdClosed':
          if (onRewardedVideoAdClosed != null) {
            onRewardedVideoAdClosed(call.arguments as String);
          }
          break;
        case 'onRewarded':
          if (onRewarded != null) {
            List<dynamic> args = call.arguments as List<dynamic>;
            onRewarded(args[0] as String, args[1] as String, args[2] as int);
          }
          break;
        case 'onRewardedVideoAdFailedToShow':
          if (onRewardedVideoAdFailedToShow != null) {
            List<dynamic> args = call.arguments as List<dynamic>;
            onRewardedVideoAdFailedToShow(
                args[0] as String, args[1] as int, args[2] as String, args[3] as String);
          }
          break;
        default:
          break;
      }
    });
  }

  /// Register listener of interstitial
  static Future<void> setupInterstitialListener({
    Function(String)? onInterstitialAdLoaded,
    Function(String, int, String, String)? onInterstitialAdFailedToLoad,
    Function(String)? onInterstitialAdOpened,
    Function(String)? onInterstitialAdClosed,
    Function(String, int, String, String)? onInterstitialAdFailedToShow,
  }) async {
    listenerInterstitialChannel.setMethodCallHandler((call) async {
      switch (call.method) {
        case 'onInterstitialAdLoaded':
          if (onInterstitialAdLoaded != null) {
            onInterstitialAdLoaded(call.arguments as String);
          }
          break;
        case 'onInterstitialAdFailedToLoad':
          if (onInterstitialAdFailedToLoad != null) {
            List<dynamic> args = call.arguments as List<dynamic>;
            onInterstitialAdFailedToLoad(
                args[0] as String, args[1] as int, args[2] as String, args[3] as String);
          }
          break;
        case 'onInterstitialAdOpened':
          if (onInterstitialAdOpened != null) {
            onInterstitialAdOpened(call.arguments as String);
          }
          break;
        case 'onInterstitialAdClosed':
          if (onInterstitialAdClosed != null) {
            onInterstitialAdClosed(call.arguments as String);
          }
          break;
        case 'onInterstitialAdFailedToShow':
          if (onInterstitialAdFailedToShow != null) {
            List<dynamic> args = call.arguments as List<dynamic>;
            onInterstitialAdFailedToShow(
                args[0] as String, args[1] as int, args[2] as String, args[3] as String);
          }
          break;
        default:
          break;
      }
    });
  }

  /// Register listener of rewardedInterstitial
  static Future<void> setupRewardedInterstitialListener({
    Function(String)? onRewardedInterstitialAdLoaded,
    Function(String, int, String, String)? onRewardedInterstitialAdFailedToLoad,
    Function(String)? onRewardedInterstitialAdSkip,
    Function(String)? onRewardedInterstitialAdOpened,
    Function(String)? onRewardedInterstitialAdClosed,
    Function(String, String, int)? onRewardedInterstitialRewarded,
    Function(String, int, String, String)? onRewardedInterstitialAdFailedToShow,
  }) async {
    listenerRewardedInterstitialChannel.setMethodCallHandler((call) async {
      switch (call.method) {
        case 'onRewardedInterstitialAdLoaded':
          if (onRewardedInterstitialAdLoaded != null) {
            onRewardedInterstitialAdLoaded(call.arguments as String);
          }
          break;
        case 'onRewardedInterstitialAdFailedToLoad':
          if (onRewardedInterstitialAdFailedToLoad != null) {
            List<dynamic> args = call.arguments as List<dynamic>;
            onRewardedInterstitialAdFailedToLoad(
                args[0] as String, args[1] as int, args[2] as String, args[3] as String);
          }
          break;
        case 'onRewardedInterstitialAdSkip':
          if (onRewardedInterstitialAdSkip != null) {
            onRewardedInterstitialAdSkip(call.arguments as String);
          }
          break;
        case 'onRewardedInterstitialAdOpened':
          if (onRewardedInterstitialAdOpened != null) {
            onRewardedInterstitialAdOpened(call.arguments as String);
          }
          break;
        case 'onRewardedInterstitialAdClosed':
          if (onRewardedInterstitialAdClosed != null) {
            onRewardedInterstitialAdClosed(call.arguments as String);
          }
          break;
        case 'onRewardedInterstitialRewarded':
          if (onRewardedInterstitialRewarded != null) {
            List<dynamic> args = call.arguments as List<dynamic>;
            onRewardedInterstitialRewarded(
                args[0] as String, args[1] as String, args[2] as int);
          }
          break;
        case 'onRewardedInterstitialAdFailedToShow':
          if (onRewardedInterstitialAdFailedToShow != null) {
            List<dynamic> args = call.arguments as List<dynamic>;
            onRewardedInterstitialAdFailedToShow(
                args[0] as String, args[1] as int, args[2] as String, "");
          }
          break;
        default:
          break;
      }
    });
  }
}
