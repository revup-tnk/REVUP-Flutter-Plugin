import Flutter
import UIKit
import REVUP

public class RevupFlutterPlugin: NSObject, FlutterPlugin, REVUPDelegate {

  var _revupRegistrar: FlutterPluginRegistrar?
  var _revupResult: FlutterResult?

  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "revup_flutter_plugin", binaryMessenger: registrar.messenger())
    let instance = RevupFlutterPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
    instance._revupRegistrar = registrar
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    _revupResult = result
    switch call.method {
    case "getPlatformVersion":
      result("iOS " + UIDevice.current.systemVersion)
    case "initialize":
      if let revupSDK = REVUPInterface.sharedInstance() {
        revupSDK.setMainDelegate(self)
        if let args = call.arguments as? Dictionary<String, Any>{
          if let mediaId = args["mediaId"] as? String, mediaId.count > 0, let mediaSecret = args["mediaSecret"] as? String, mediaSecret.count > 0, let callbackTag = args["callbackTag"] as? String, callbackTag.count > 0 {
            revupSDK.initialize(mediaId, mediaSecret: mediaSecret, callBackTag: callbackTag)
          } else if let mediaId = args["mediaId"] as? String, mediaId.count > 0, let mediaSecret = args["mediaSecret"] as? String, mediaSecret.count > 0 {
            revupSDK.initialize(mediaId, mediaSecret: mediaSecret)
          } else if let callbackTag = args["callbackTag"] as? String, callbackTag.count > 0 {
            revupSDK.initialize(callbackTag)
          } else {
            revupSDK.initialize()
          }
          return;
        }
      }
      result(false)
    case "setUserId":
      var resultValue = false
      if let revupSDK = REVUPInterface.sharedInstance() {
        if let args = call.arguments as? Dictionary<String, Any>{
          if let userId = args["userId"] as? String {
            resultValue = revupSDK.setUserId(userId)
          }
        }
      }
      result(resultValue)
    case "setUserIdChild":
      var resultValue = false
      if let revupSDK = REVUPInterface.sharedInstance() {
        if let args = call.arguments as? Dictionary<String, Any>{
          if let userId = args["userId"] as? String, let child = args["child"] as? Int {
            if child == 1 {
              resultValue = revupSDK.setUserId(userId, child: .adult)
            } else if child == 2 {
              resultValue = revupSDK.setUserId(userId, child: .child)
            } else {
              resultValue = revupSDK.setUserId(userId, child: .none)
            }
          }
        }
      }
      result(resultValue)
    case "setRewardedCheckParam":
      if let revupSDK = REVUPInterface.sharedInstance() {
        if let args = call.arguments as? Dictionary<String, Any>{
          if let param = args["param"] as? String {
            revupSDK.setRewardedCheckParam(param)
            result(true)
            return;
          }
        }
      }
      result(false)
    case "isInitialized":
      result(REVUPInterface.sharedInstance().isInitialized())
    case "getSDKVersion":
      result(REVUPInterface.sharedInstance().getSDKVersion())
    case "getNetworkVersions":
      result(REVUPInterface.sharedInstance().networkVersions)
    case "getUnitStatus":
      if let revupSDK = REVUPInterface.sharedInstance() {
        if let args = call.arguments as? Dictionary<String, Any>{
          if let unitId = args["unitId"] as? String {
            revupSDK.getUnitStatus(unitId)
            return;
          }
        }
      }
      result([])
    case "showMaxMediationDebugger":
      REVUPInterface.sharedInstance().showMaxMediationDebugger()
      result(true)
    case "showAdmobMediationDebugger":
      result(false)
    case "setVolumeOff":
      if let revupSDK = REVUPInterface.sharedInstance() {
        if let args = call.arguments as? Dictionary<String, Any>{
          if let isOn = args["isOn"] as? Bool {
            if (isOn) {
              revupSDK.setVolumeOff()
            } else {
              revupSDK.setVolumeOn()
            }
            result(true)
            return;
          }
        }
      }
      result(false)
    case "setShowWithLoad2BackgroundColor":
      if let revupSDK = REVUPInterface.sharedInstance() {
        if let args = call.arguments as? Dictionary<String, Any>{
          if let red = args["red"] as? String, let green = args["green"] as? String, let blue = args["blue"] as? String, let alpha = args["alpha"] as? String {
            revupSDK.setShowWithLoad2BackgroundColor(red, green: green, blue: blue, alpha: alpha)
            result(true)
            return;
          }
        }
      }
      result(false)
    case "setShowWithLoad2IndicatorStyle":
      if let revupSDK = REVUPInterface.sharedInstance() {
        if let args = call.arguments as? Dictionary<String, Any>{
          if let isHidden = args["isHidden"] as? Bool, let isMedium = args["isMedium"] as? Bool {
            revupSDK.setShowWithLoad2IndicatorStyleMedium(isMedium, isHidden: isHidden)
            result(true)
            return;
          }
        }
      }
      result(false)
    case "setShowWithLoad2ErrorAlert":
      if let revupSDK = REVUPInterface.sharedInstance() {
        if let args = call.arguments as? Dictionary<String, Any>{
          if let isHidden = args["isHidden"] as? Bool, let msg = args["msg"] as? String {
            revupSDK.setShowWithLoad2ErrorAlertMsg(msg, isHidden: isHidden)
            result(true)
            return;
          }
        }
      }
      result(false)
    case "showLuckyEvent":
      if let revupSDK = REVUPInterface.sharedInstance() {
        revupSDK.setMainDelegate(self)
        revupSDK.showLuckyEvent()
        result(true)
        return;
      }
      result(false)
    case "setLuckyEventAppId":
      if let revupSDK = REVUPInterface.sharedInstance() {
        if let args = call.arguments as? Dictionary<String, Any>{
          if let appId = args["appId"] as? String, appId.count > 0, let pubId = args["pubId"] as? String, pubId.count > 0 {
            revupSDK.setLuckyEventAppId(appId, pubId: pubId)
            result(true)
            return;
          }
        }
      }
      result(false)
    case "setLuckyEventUseSafeAreaWebView":
      if let revupSDK = REVUPInterface.sharedInstance() {
        if let args = call.arguments as? Dictionary<String, Any>{
          if let useSafeArea = args["useSafeArea"] as? Bool {
            revupSDK.setLuckyEventUseSafeAreaWebView(useSafeArea)
            result(true)
            return;
          }
        }
      }
      result(false)
    case "setLuckyEventHashMark":
      if let revupSDK = REVUPInterface.sharedInstance() {
        if let args = call.arguments as? Dictionary<String, Any>{
          if let hashMark = args["hashMark"] as? String, hashMark.count > 0 {
            revupSDK.setLuckyEventHashMark(hashMark)
            result(true)
            return;
          }
        }
      }
      result(false)
    case "setLuckyEventBaseUrl":
      if let revupSDK = REVUPInterface.sharedInstance() {
        if let args = call.arguments as? Dictionary<String, Any>{
          if let baseUrl = args["baseUrl"] as? String, baseUrl.count > 0 {
            revupSDK.setLuckyEventBaseUrl(baseUrl)
            result(true)
            return;
          }
        }
      }
      result(false)
    case "setLuckyEventExtraParam":
      if let revupSDK = REVUPInterface.sharedInstance() {
        if let args = call.arguments as? Dictionary<String, Any>{
          if let key = args["key"] as? String, key.count > 0, let value = args["value"] as? String, value.count > 0 {
            revupSDK.setLuckyEventExtraParam(key, value: value)
            result(true)
            return;
          }
        }
      }
      result(false)
    case "rewardedVideoShowWithLoad":
      if let revupSDK = REVUPInterface.sharedInstance() {
        if let args = call.arguments as? Dictionary<String, Any>{
          if let unitId = args["unitId"] as? String {
            revupSDK.show(withLoad:unitId, delegate:self)
            result(true)
            return;
          }
        }
      }
      result(false)
    case "rewardedVideoLoad":
      if let revupSDK = REVUPInterface.sharedInstance() {
        revupSDK.setMainDelegate(self)
        if let args = call.arguments as? Dictionary<String, Any>{
          if let unitId = args["unitId"] as? String {
            revupSDK.load(unitId)
            result(true)
            return;
          }
        }
      }
      result(false)
    case "rewardedVideoIsLoad":
      var resultValue = false
      if let revupSDK = REVUPInterface.sharedInstance() {
        if let args = call.arguments as? Dictionary<String, Any>{
          if let unitId = args["unitId"] as? String {
            resultValue = revupSDK.isLoaded(unitId)
          }
        }
      }
      result(resultValue)
    case "rewardedVideoShow":
      var resultValue = false
      if let revupSDK = REVUPInterface.sharedInstance() {
        revupSDK.setMainDelegate(self)
        resultValue = revupSDK.show()
      }
      result(resultValue)
    case "interstitialShowWithLoad":
      if let revupSDK = REVUPInterface.sharedInstance() {
        if let args = call.arguments as? Dictionary<String, Any>{
          if let unitId = args["unitId"] as? String {
            revupSDK.show(withLoadInterstitial:unitId, delegate:self)
            result(true)
            return;
          }
        }
      }
      result(false)
    case "interstitialLoad":
      if let revupSDK = REVUPInterface.sharedInstance() {
        revupSDK.setMainDelegate(self)
        if let args = call.arguments as? Dictionary<String, Any>{
          if let unitId = args["unitId"] as? String {
            revupSDK.loadInterstitial(unitId)
            result(true)
            return;
          }
        }
      }
      result(false)
    case "interstitialIsLoad":
      var resultValue = false
      if let revupSDK = REVUPInterface.sharedInstance() {
        if let args = call.arguments as? Dictionary<String, Any>{
          if let unitId = args["unitId"] as? String {
            resultValue = revupSDK.isLoadedInterstitialUnitID(unitId)
          }
        }
      }
      result(resultValue)
    case "interstitialShow":
      if let revupSDK = REVUPInterface.sharedInstance() {
        revupSDK.setMainDelegate(self)
        revupSDK.showInterstitial()
        result(true)
        return;
      }
      result(false)
    case "getUnitStatusRewardedInterstitial":
      if let revupSDK = REVUPInterface.sharedInstance() {
        revupSDK.setMainDelegate(self)
        if let args = call.arguments as? Dictionary<String, Any>{
          if let unitId = args["unitId"] as? String {
            revupSDK.getRewardedInterstitialUnitStatus(unitId)
            return;
          }
        }
      }
      result([])
    case "loadRewardedInterstitial":
      if let revupSDK = REVUPInterface.sharedInstance() {
        revupSDK.setMainDelegate(self)
        if let args = call.arguments as? Dictionary<String, Any>{
          if let unitId = args["unitId"] as? String {
            revupSDK.loadRewardedInterstitial(unitId)
            result(true)
            return;
          }
        }
      }
      result(false)
    case "preLoadAllRewardedInterstitial":
      if let revupSDK = REVUPInterface.sharedInstance() {
        revupSDK.setMainDelegate(self)
        revupSDK.preLoadAllRewardedInterstitial()
        result(true)
        return;
      }
      result(false)
    case "preLoadRewardedInterstitial":
      if let revupSDK = REVUPInterface.sharedInstance() {
        revupSDK.setMainDelegate(self)
        if let args = call.arguments as? Dictionary<String, Any>{
          if let unitIds = args["unitIds"] as? Array<String> {
            revupSDK.preLoadRewardedInterstitial(unitIds)
            result(true)
            return;
          }
        }
      }
      result(false)
    case "rewardedInterstitialIsLoad":
      var resultValue = false
      if let revupSDK = REVUPInterface.sharedInstance() {
        if let args = call.arguments as? Dictionary<String, Any>{
          if let unitId = args["unitId"] as? String {
            resultValue = revupSDK.isLoadedRewardedInterstitial(unitId)
          }
        }
      }
      result(resultValue)
    case "showRewardedInterstitial":
      var resultValue = false
      if let revupSDK = REVUPInterface.sharedInstance() {
        revupSDK.setMainDelegate(self)
        if let args = call.arguments as? Dictionary<String, Any>{
          if let unitId = args["unitId"] as? String {
            resultValue = revupSDK.showRewardedInterstitial(unitId)
          }
        }
      }
      result(resultValue)
    case "showWithPopupRewardedInterstitial":
      var resultValue = false
      if let revupSDK = REVUPInterface.sharedInstance() {
        revupSDK.setMainDelegate(self)
        if let args = call.arguments as? Dictionary<String, Any>{
          if let unitId = args["unitId"] as? String {
            resultValue = revupSDK.showRewardedInterstitial(withPop:unitId)
          }
        }
      }
      result(resultValue)
    default:
      result(FlutterMethodNotImplemented)
    }
  }

  public func onInitialized(_ isSuccess: Bool) {
    _revupResult?(isSuccess)
  }

  public func onResponsedUnitStatus(_ status: REVUPUnitStatus!) {
    let result = ["live": status.live, "active": status.active]
    _revupResult?(result)
  }

  public func luckyEventWebViewNavigated(_ url: URL, vc: UIViewController) {
    let channel = FlutterMethodChannel(name: "revupLuckyEventListener", binaryMessenger: _revupRegistrar!.messenger())
    channel.invokeMethod("luckyEventWebViewNavigated", arguments: url.absoluteString)
  }

  public func onRewardedVideoAdLoaded(_ unitID: String!) {
    let channel = FlutterMethodChannel(name: "revupRewardedVideoListener", binaryMessenger: _revupRegistrar!.messenger())
    channel.invokeMethod("onRewardedVideoAdLoaded", arguments: unitID)
  }

  public func onRewardedVideoAdFailed(toLoad unitID: String!, error: REVUPError!) {
    let errorCode = error.code
    let errorDescription = error.description
    let errorXB3TraceID = error.getXB3TraceID() ?? ""
    let channel = FlutterMethodChannel(name: "revupRewardedVideoListener", binaryMessenger: _revupRegistrar!.messenger())
    channel.invokeMethod("onRewardedVideoAdFailedToLoad", arguments: [unitID!, errorCode, errorDescription, errorXB3TraceID])
  }

  public func onRewardedVideoAdOpened(_ unitID: String!) {
    let channel = FlutterMethodChannel(name: "revupRewardedVideoListener", binaryMessenger: _revupRegistrar!.messenger())
    channel.invokeMethod("onRewardedVideoAdOpened", arguments: unitID)
  }

  public func onRewardedVideoAdClosed(_ unitID: String!) {
    let channel = FlutterMethodChannel(name: "revupRewardedVideoListener", binaryMessenger: _revupRegistrar!.messenger())
    channel.invokeMethod("onRewardedVideoAdClosed", arguments: unitID)
  }

  public func onRewarded(_ unitID: String!, item: REVUPRewardItem!) {
    let currencyUnit = item.unit ?? ""
    let channel = FlutterMethodChannel(name: "revupRewardedVideoListener", binaryMessenger: _revupRegistrar!.messenger())
    channel.invokeMethod("onRewarded", arguments: [unitID!, currencyUnit, item.amount])
  }

  public func onRewardedVideoAdFailed(toShow unitID: String!, error: REVUPError!) {
    let errorCode = error.code
    let errorDescription = error.description
    let errorXB3TraceID = error.getXB3TraceID() ?? ""
    let channel = FlutterMethodChannel(name: "revupRewardedVideoListener", binaryMessenger: _revupRegistrar!.messenger())
    channel.invokeMethod("onRewardedVideoAdFailedToShow", arguments: [unitID!, errorCode, errorDescription, errorXB3TraceID])
  }

  public func onInterstitialAdLoaded(_ unitID: String!) {
    let channel = FlutterMethodChannel(name: "revupInterstitialListener", binaryMessenger: _revupRegistrar!.messenger())
    channel.invokeMethod("onInterstitialAdLoaded", arguments: unitID)
  }

  public func onInterstitialAdFailed(toLoad unitID: String!, error: REVUPError!) {
    let errorCode = error.code
    let errorDescription = error.description
    let errorXB3TraceID = error.getXB3TraceID() ?? ""
    let channel = FlutterMethodChannel(name: "revupInterstitialListener", binaryMessenger: _revupRegistrar!.messenger())
    channel.invokeMethod("onInterstitialAdFailedToLoad", arguments: [unitID!, errorCode, errorDescription, errorXB3TraceID])
  }

  public func onInterstitialAdOpened(_ unitID: String!) {
    let channel = FlutterMethodChannel(name: "revupInterstitialListener", binaryMessenger: _revupRegistrar!.messenger())
    channel.invokeMethod("onInterstitialAdOpened", arguments: unitID)
  }

  public func onInterstitialAdClosed(_ unitID: String!) {
    let channel = FlutterMethodChannel(name: "revupInterstitialListener", binaryMessenger: _revupRegistrar!.messenger())
    channel.invokeMethod("onInterstitialAdClosed", arguments: unitID)
  }

  public func onInterstitialAdFailed(toShow unitID: String!, error: REVUPError!) {
    let errorCode = error.code
    let errorDescription = error.description
    let errorXB3TraceID = error.getXB3TraceID() ?? ""
    let channel = FlutterMethodChannel(name: "revupInterstitialListener", binaryMessenger: _revupRegistrar!.messenger())
    channel.invokeMethod("onInterstitialAdFailedToShow", arguments: [unitID!, errorCode, errorDescription, errorXB3TraceID])
  }

  public func onRewardedInterstitialResponsedUnitStatus(_ status: REVUPUnitStatus!) {
    let result = ["live": status.live, "active": status.active]
    _revupResult?(result)
  }

  public func onRewardedInterstitialAdLoaded(_ unitID: String!) {
    let channel = FlutterMethodChannel(name: "revupRewardedInterstitialListener", binaryMessenger: _revupRegistrar!.messenger())
    channel.invokeMethod("onRewardedInterstitialAdLoaded", arguments: unitID)
  }

  public func onRewardedInterstitialAdFailed(toLoad unitID: String!, error: REVUPError!) {
    let errorCode = error.code
    let errorDescription = error.description
    let errorXB3TraceID = error.getXB3TraceID() ?? ""
    let channel = FlutterMethodChannel(name: "revupRewardedInterstitialListener", binaryMessenger: _revupRegistrar!.messenger())
    channel.invokeMethod("onRewardedInterstitialAdFailedToLoad", arguments: [unitID!, errorCode, errorDescription, errorXB3TraceID])
  }

  public func onRewardedInterstitialAdSkip(_ unitID: String!) {
    let channel = FlutterMethodChannel(name: "revupRewardedInterstitialListener", binaryMessenger: _revupRegistrar!.messenger())
    channel.invokeMethod("onRewardedInterstitialAdSkip", arguments: unitID)
  }

  public func onRewardedInterstitialAdOpened(_ unitID: String!) {
    let channel = FlutterMethodChannel(name: "revupRewardedInterstitialListener", binaryMessenger: _revupRegistrar!.messenger())
    channel.invokeMethod("onRewardedInterstitialAdOpened", arguments: unitID)
  }

  public func onRewardedInterstitialAdClosed(_ unitID: String!) {
    let channel = FlutterMethodChannel(name: "revupRewardedInterstitialListener", binaryMessenger: _revupRegistrar!.messenger())
    channel.invokeMethod("onRewardedInterstitialAdClosed", arguments: unitID)
  }

  public func onRewardedInterstitialRewarded(_ unitID: String!, item: REVUPRewardItem!) {
    let currencyUnit = item.unit ?? ""
    let channel = FlutterMethodChannel(name: "revupRewardedInterstitialListener", binaryMessenger: _revupRegistrar!.messenger())
    channel.invokeMethod("onRewardedInterstitialRewarded", arguments: [unitID!, currencyUnit, item.amount])
  }

  public func onRewardedInterstitialAdFailed(toShow unitID: String!, error: REVUPError!) {
    let errorCode = error.code
    let errorDescription = error.description
    let errorXB3TraceID = error.getXB3TraceID() ?? ""
    let channel = FlutterMethodChannel(name: "revupRewardedInterstitialListener", binaryMessenger: _revupRegistrar!.messenger())
    channel.invokeMethod("onRewardedInterstitialAdFailedToShow", arguments: [unitID!, errorCode, errorDescription, errorXB3TraceID])
  }
}
