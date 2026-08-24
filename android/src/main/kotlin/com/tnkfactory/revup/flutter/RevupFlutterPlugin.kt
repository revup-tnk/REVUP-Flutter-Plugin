package com.tnkfactory.revup.flutter

import android.app.Activity
import android.content.Intent
import com.tnkfactory.revup.RevupError
import com.tnkfactory.revup.RevupSdk
import com.tnkfactory.revup.core.Revup
import com.tnkfactory.revup.interstitial.InterstitialAd
import com.tnkfactory.revup.interstitial.InterstitialAdListener
import com.tnkfactory.revup.listener.RevupInitializeListener
import com.tnkfactory.revup.model.UnitStatus
import com.tnkfactory.revup.model.RevupUserType
import com.tnkfactory.revup.reward.RewardItem
import com.tnkfactory.revup.reward.RewardedVideoAd
import com.tnkfactory.revup.reward.RewardedVideoAdListener
import com.tnkfactory.revup.rewardedinterstitial.RewardedInterstitialAd
import com.tnkfactory.revup.rewardedinterstitial.RewardedInterstitialAdShowListener
import com.tnkfactory.revup.luckyevent.LuckyEventTheme
import com.tnkfactory.revup.luckyevent.RevupLuckyEvent
import com.tnkfactory.revup.luckyevent.tnk.TnkEventActivity
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** RevupFlutterPlugin */
class RevupFlutterPlugin: FlutterPlugin, MethodCallHandler, ActivityAware, RevupInitializeListener,
  RewardedVideoAdListener, InterstitialAdListener, RewardedInterstitialAdShowListener {

  private lateinit var channel : MethodChannel
  private lateinit var flutterPlugin: FlutterPlugin.FlutterPluginBinding
  private lateinit var mActivity: Activity
  private lateinit var callResult : Result
  private var mRewardedVideoAd: RewardedVideoAd? = null
  private var mInterstitialAd: InterstitialAd? = null
  private var mRewardedInterstitialAd: RewardedInterstitialAd? = null
  private var mUserId: String = ""
  private var mChild = 0
  private var mChildYN: String = ""
  private var mLuckyEventId: String = ""
  private var mLuckyTnkAppId: String = ""
  private var mLuckyEventUseSafeArea = false
  private var mLuckyEventHashMark = ""
  private var mLuckyEventBaseUrl = ""
  private var mLuckyEventExtraParams = hashMapOf<String, String>()

  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "revup_flutter_plugin")
    channel.setMethodCallHandler(this)
    flutterPlugin = flutterPluginBinding
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    callResult = result;
    if (call.method == "initialize") {
      var mediaId = call.argument("mediaId") as? String ?: ""
      var mediaSecret = call.argument("mediaSecret") as? String ?: ""
      var callbackTag = call.argument("callbackTag") as? String ?: ""
      var childYN = call.argument("childYN") as? String ?: ""
      if (childYN.isNotEmpty()) mChildYN = childYN
      if (mediaId.length > 0 && mediaSecret.length > 0 && callbackTag.length > 0 && childYN.length > 0) {
        RevupSdk.initialize(mActivity, mediaId, mediaSecret, callbackTag, childYN, this)
      } else if (mediaId.length > 0 && mediaSecret.length > 0 && callbackTag.length > 0) {
        RevupSdk.initialize(mActivity, mediaId, mediaSecret, callbackTag, this)
      } else if (mediaId.length > 0 && mediaSecret.length > 0) {
        RevupSdk.initialize(mActivity, mediaId, mediaSecret, this)
      } else if (callbackTag.length > 0 && childYN.length > 0) {
        RevupSdk.initialize(mActivity, this, callbackTag, childYN)
      } else if (callbackTag.length > 0) {
        RevupSdk.initialize(mActivity, this, callbackTag)
      } else {
        RevupSdk.initialize(mActivity, this)
      }
    } else if (call.method == "setUserId") {
      var userId = call.argument("userId") as? String ?: ""
      mUserId = userId
      RevupSdk.setUserId(userId);
      result.success(true)
    } else if (call.method == "setUserIdChild") {
      var userId = call.argument("userId") as? String ?: ""
      var child = call.argument("child") as? Int ?: 0
      mUserId = userId
      mChild = child
      var userType = RevupUserType.fromInt(child)
      mChildYN = userType.childYN
      RevupSdk.setUserIdChild(userId, userType);
      result.success(true)
    } else if (call.method == "setRewardedCheckParam") {
      var param = call.argument("param") as? String ?: ""
      RevupSdk.setRewardedCheckParam(param);
      result.success(true)
    } else if (call.method == "isInitialized") {
      var returnResult = RevupSdk.isInitialize()
      result.success(returnResult)
    } else if (call.method == "getSDKVersion") {
      var returnResult = RevupSdk.getSDKVersion()
      result.success(returnResult)
    } else if (call.method == "getNetworkVersions") {
      var returnResult = RevupSdk.getNetworksVersions()
      result.success(returnResult)
    } else if (call.method == "getUnitStatus") {
      var unitId = call.argument("unitId") as? String ?: ""
      RevupSdk.getUnitStatus(unitId) { revupError: RevupError?, unitStatus: UnitStatus? ->
        var result = mapOf("live" to unitStatus?.isLive, "active" to unitStatus?.isActive)
        callResult.success(result)
      }
    } else if (call.method == "showMaxMediationDebugger") {
      var resultValue = false
      try {
        val clazz = Class.forName("com.tnkfactory.revup.adapter.max.MaxAdapter")
        val instanceMethod = clazz.getDeclaredMethod("showDebug", Activity::class.java)
        instanceMethod.invoke(null, mActivity)
        resultValue = true
      } catch (e: Exception) {
        resultValue = false
      }
      result.success(resultValue)
    } else if (call.method == "showAdmobMediationDebugger") {
      var resultValue = false
      try {
        val clazz = Class.forName("com.tnkfactory.revup.adapter.admob.AdMobAdapter")
        val instanceMethod = clazz.getDeclaredMethod("showDebug", Activity::class.java)
        instanceMethod.invoke(null, mActivity)
        resultValue = true
      } catch (e: Exception) {
        resultValue = false
      }
      result.success(resultValue)
    } else if (call.method == "setVolumeOff") {
      var isOn = call.argument("isOn") as? Boolean
      RevupSdk.getOptionSetterInstance(mActivity).setVolumeOff(isOn!!)
      result.success(true)
    } else if (call.method == "setShowWithLoad2BackgroundColor") {
      result.success(false)
    } else if (call.method == "setShowWithLoad2IndicatorStyle") {
      result.success(false)
    } else if (call.method == "setShowWithLoad2ErrorAlert") {
      result.success(false)
    } else if (call.method == "rewardedVideoShowWithLoad") {
      result.success(false)
    } else if (call.method == "rewardedVideoLoad") {
      setRevupAdListener()
      if (mRewardedVideoAd != null) {
        var unitId = call.argument("unitId") as? String ?: ""
        mRewardedVideoAd?.load(unitId)
        result.success(true)
      } else {
        result.success(false)
      }
    } else if (call.method == "rewardedVideoIsLoad") {
      setRevupAdListener()
      if (mRewardedVideoAd != null) {
        var unitId = call.argument("unitId") as? String ?: ""
        var resultValue = mRewardedVideoAd?.isLoaded(unitId)
        result.success(resultValue)
      } else {
        result.success(false)
      }
    } else if (call.method == "rewardedVideoShow") {
      setRevupAdListener()
      if (mRewardedVideoAd != null) {
        var resultValue = mRewardedVideoAd?.show(mActivity)
        result.success(resultValue)
      } else {
        result.success(false)
      }
    } else if (call.method == "interstitialShowWithLoad") {
      result.success(false)
    } else if (call.method == "interstitialLoad") {
      setRevupAdListener()
      if (mInterstitialAd != null) {
        var unitId = call.argument("unitId") as? String ?: ""
        mInterstitialAd?.load(unitId)
        result.success(true)
      } else {
        result.success(false)
      }
    } else if (call.method == "interstitialIsLoad") {
      setRevupAdListener()
      if (mInterstitialAd != null) {
        var unitId = call.argument("unitId") as? String ?: ""
        var resultValue = mInterstitialAd?.isLoaded(unitId)
        result.success(resultValue)
      } else {
        result.success(false)
      }
    } else if (call.method == "interstitialShow") {
      setRevupAdListener()
      if (mInterstitialAd != null) {
        var resultValue = mInterstitialAd?.show(mActivity)
        result.success(resultValue)
      } else {
        result.success(false)
      }
    } else if (call.method == "getUnitStatusRewardedInterstitial") {
      setRevupAdListener()
      if (mRewardedInterstitialAd != null) {
        var unitId = call.argument("unitId") as? String ?: ""
        mRewardedInterstitialAd?.getUnitStatus(unitId) { error, unitStatus ->
          var result = mapOf("live" to unitStatus?.isLive, "active" to unitStatus?.isActive)
          callResult.success(result)
        }
      } else {
        result.success(false)
      }
    } else if (call.method == "preLoadAllRewardedInterstitial") {
      setRevupAdListener()
      if (mRewardedInterstitialAd != null) {
        mRewardedInterstitialAd?.preloadAll()
        result.success(true)
      } else {
        result.success(false)
      }
    } else if (call.method == "preLoadRewardedInterstitial") {
      setRevupAdListener()
      if (mRewardedInterstitialAd != null) {
        val unitIds = call.argument<List<String>>("unitIds")
        if (unitIds != null) {
          mRewardedInterstitialAd?.preloadUnit(unitIds.toTypedArray())
          result.success(true)
        } else {
          result.success(false)
        }
      } else {
        result.success(false)
      }
    } else if (call.method == "loadRewardedInterstitial") {
        setRevupAdListener()
        if (mRewardedInterstitialAd != null) {
            var unitId = call.argument("unitId") as? String ?: ""
            mRewardedInterstitialAd?.load(unitId)
            result.success(true)
        } else {
            result.success(false)
        }
    } else if (call.method == "rewardedInterstitialIsLoad") {
        setRevupAdListener()
        if (mRewardedInterstitialAd != null) {
            var unitId = call.argument("unitId") as? String ?: ""
            var resultValue = mRewardedInterstitialAd?.isLoaded(unitId)
            result.success(resultValue)
        } else {
            result.success(false)
        }
    } else if (call.method == "showRewardedInterstitial") {
      setRevupAdListener()
      if (mRewardedInterstitialAd != null) {
        var unitId = call.argument("unitId") as? String ?: ""
        mRewardedInterstitialAd?.show(unitId)
        result.success(true)
      } else {
        result.success(false)
      }
    } else if (call.method == "showWithPopupRewardedInterstitial") {
        setRevupAdListener()
        if (mRewardedInterstitialAd != null) {
            var unitId = call.argument("unitId") as? String ?: ""
            mRewardedInterstitialAd?.showWithPopup(unitId)
            result.success(true)
        } else {
            result.success(false)
        }
    } else if (call.method == "setLuckyEventAppId") {
        mLuckyEventId = call.argument("appId") as? String ?: ""
        mLuckyTnkAppId = call.argument("pubId") as? String ?: ""
        result.success(true)
    } else if (call.method == "showLuckyEvent") {
      var builder = TnkEventActivity.TnkEventBuilder()
        .setUserName(mUserId)
        .setEventIdTnkAppId(mLuckyEventId, mLuckyTnkAppId)
        .setHookerClass(mActivity, LuckyEventHooker::class.java)
      if (mChildYN.isNotEmpty()) {
        builder = builder.setChildYn(mChildYN)
      }
      // TnkEventActivity 는 launchMode="singleTop" 이라 이미 최상단에 떠 있으면
      // 새 인스턴스 대신 onNewIntent() 로 전달되고, SDK 가 그 Intent 의 URL 을 다시 로드한다.
      // (복권 화면 안에서 다른 복권 이벤트를 여는 흐름)
      // 따로 태스크 플래그를 줄 필요는 없다.
      builder.makeUrl(mActivity) { url ->
        val intent = Intent(mActivity, TnkEventActivity::class.java)
        intent.putExtra(TnkEventActivity.EVENT_URL, url)

        mActivity.startActivity(intent)
      }
      result.success(true)
    } else if (call.method == "setLuckyEventUseSafeAreaWebView") {
      mLuckyEventUseSafeArea = call.argument("useSafeArea") as? Boolean ?: false
      result.success(true)
    } else if (call.method == "setLuckyEventEdgeGesture") {
      // iOS 전용 옵션 (웹뷰 edge swipe 제스처)
      result.success(false)
    } else if (call.method == "setLuckyEventHashMark") {
      mLuckyEventHashMark = call.argument("hashMark") as? String ?: ""
      result.success(true)
    } else if (call.method == "setLuckyEventBaseUrl") {
      mLuckyEventHashMark = call.argument("baseUrl") as? String ?: ""
      result.success(true)
    } else if (call.method == "setLuckyEventExtraParam") {
      val k = call.argument("key") as? String ?: ""
      val v = call.argument("value") as? String ?: ""
      mLuckyEventExtraParams.put(k, v)
      result.success(true)
    } else if (call.method == "setLuckyEventTheme") {
      // 알 수 없는 값이면 설정을 바꾸지 않고 false 를 돌려준다.
      // (조용히 기본값으로 되돌리면 매체가 오타를 알아채지 못한다)
      val theme = LuckyEventTheme.from(call.argument("theme") as? String)
      if (theme != null) {
        RevupLuckyEvent.setEventTheme(theme)
        result.success(true)
      } else {
        result.success(false)
      }
    } else {
      result.notImplemented()
    }
  }

  fun setRevupAdListener() {
    if (RevupSdk.isInitialize()) {
      mRewardedVideoAd = Revup.getRewardedVideoAdInstance(mActivity).apply {
        this.setRewardedVideoAdListener(this@RevupFlutterPlugin)
      }
      mInterstitialAd = Revup.getInterstitialAdInstance(mActivity).apply {
        this.setInterstitialAdListener(this@RevupFlutterPlugin)
      }
      mRewardedInterstitialAd = Revup.getRewardedInterstitialAdInstance(mActivity).apply {
        this.setRewardedInterstitialAdListener(this@RevupFlutterPlugin)
      }
    }
  }

  override fun onInitialized(isSuccess: Boolean) {
    try {
      callResult.success(isSuccess)
    } catch (e: IllegalStateException) {
    }
    setRevupAdListener()
  }

  fun adEventWebViewNavigated(ac: Activity, url: String) {
    MethodChannel(flutterPlugin.binaryMessenger, "revupLuckyEventListener").invokeMethod("luckyEventWebViewNavigated", url)
  }

  override fun onRewardedVideoAdLoaded(unitId: String?) {
    MethodChannel(flutterPlugin.binaryMessenger, "revupRewardedVideoListener").invokeMethod("onRewardedVideoAdLoaded", unitId)
  }

  override fun onRewardedVideoAdFailedToLoad(unitId: String?, error: RevupError?) {
    val args: MutableList<Any> = ArrayList()
    args.add(unitId ?: "")
    args.add(error?.code ?: -1)
    args.add(error?.description ?: "")
    args.add(error?.xb3TraceId ?: "")
    MethodChannel(flutterPlugin.binaryMessenger, "revupRewardedVideoListener").invokeMethod("onRewardedVideoAdFailedToLoad", args)
  }

  override fun onRewardedVideoAdOpened(unitId: String?) {
    MethodChannel(flutterPlugin.binaryMessenger, "revupRewardedVideoListener").invokeMethod("onRewardedVideoAdOpened", unitId)
  }

  override fun onRewardedVideoAdClosed(unitId: String?) {
    MethodChannel(flutterPlugin.binaryMessenger, "revupRewardedVideoListener").invokeMethod("onRewardedVideoAdClosed", unitId)
  }

  override fun onRewarded(unitId: String?, item: RewardItem?) {
    val args: MutableList<Any> = ArrayList()
    args.add(unitId ?: "")
    args.add(item?.getType() ?: "")
    args.add(item?.getAmount() ?: "")
    MethodChannel(flutterPlugin.binaryMessenger, "revupRewardedVideoListener").invokeMethod("onRewarded", args)
  }

  override fun onRewardedVideoAdFailedToShow(unitId: String?, error: RevupError?) {
    val args: MutableList<Any> = ArrayList()
    args.add(unitId ?: "")
    args.add(error?.code ?: -1)
    args.add(error?.description ?: "")
    args.add(error?.xb3TraceId ?: "")
    MethodChannel(flutterPlugin.binaryMessenger, "revupRewardedVideoListener").invokeMethod("onRewardedVideoAdFailedToShow", args)
  }

  override fun onInterstitialAdLoaded() {
    MethodChannel(flutterPlugin.binaryMessenger, "revupInterstitialListener").invokeMethod("onInterstitialAdLoaded", "")
  }

  override fun onInterstitialAdFailedToLoad(error: RevupError?) {
    val args: MutableList<Any> = ArrayList()
    args.add("")
    args.add(error?.code ?: -1)
    args.add(error?.description ?: "")
    args.add(error?.xb3TraceId ?: "")
    MethodChannel(flutterPlugin.binaryMessenger, "revupInterstitialListener").invokeMethod("onInterstitialAdFailedToLoad", args)
  }

  override fun onInterstitialAdOpened(unitId: String?) {
    MethodChannel(flutterPlugin.binaryMessenger, "revupInterstitialListener").invokeMethod("onInterstitialAdOpened", unitId)
  }

  override fun onInterstitialAdClosed(unitId: String?) {
    MethodChannel(flutterPlugin.binaryMessenger, "revupInterstitialListener").invokeMethod("onInterstitialAdClosed", unitId)
  }

  override fun onInterstitialAdFailedToShow(unitId: String?, error: RevupError?) {
    val args: MutableList<Any> = ArrayList()
    args.add(unitId ?: "")
    args.add(error?.code ?: -1)
    args.add(error?.description ?: "")
    args.add(error?.xb3TraceId ?: "")
    MethodChannel(flutterPlugin.binaryMessenger, "revupInterstitialListener").invokeMethod("onInterstitialAdFailedToShow", args)
  }

  override fun onRewardedInterstitialAdLoaded(unitId: String?) {
    MethodChannel(flutterPlugin.binaryMessenger, "revupRewardedInterstitialListener").invokeMethod("onRewardedInterstitialAdLoaded", unitId)
  }

  override fun onRewardedInterstitialAdFailedToLoad(unitId: String?, error: RevupError?) {
    val args: MutableList<Any> = ArrayList()
    args.add(unitId ?: "")
    args.add(error?.code ?: -1)
    args.add(error?.description ?: "")
    args.add(error?.xb3TraceId ?: "")
    MethodChannel(flutterPlugin.binaryMessenger, "revupRewardedInterstitialListener").invokeMethod("onRewardedInterstitialAdFailedToLoad", args)
  }

  override fun onRewardedInterstitialAdSkipped(unitId: String?) {
    MethodChannel(flutterPlugin.binaryMessenger, "revupRewardedInterstitialListener").invokeMethod("onRewardedInterstitialAdSkip", unitId)
  }

  override fun onRewardedInterstitialAdOpened(unitId: String?) {
    MethodChannel(flutterPlugin.binaryMessenger, "revupRewardedInterstitialListener").invokeMethod("onRewardedInterstitialAdOpened", unitId)
  }

  override fun onRewardedInterstitialAdClosed(unitId: String?) {
    MethodChannel(flutterPlugin.binaryMessenger, "revupRewardedInterstitialListener").invokeMethod("onRewardedInterstitialAdClosed", unitId)
  }

  override fun onRewardedInterstitialAdRewarded(unitId: String?, item: RewardItem?) {
    val args: MutableList<Any> = ArrayList()
    args.add(unitId ?: "")
    args.add(item?.getType() ?: "")
    args.add(item?.getAmount() ?: "")
    MethodChannel(flutterPlugin.binaryMessenger, "revupRewardedInterstitialListener").invokeMethod("onRewardedInterstitialRewarded", args)
  }

  override fun onRewardedInterstitialAdFailedToShow(unitId: String?, error: RevupError?) {
    val args: MutableList<Any> = ArrayList()
    args.add(unitId ?: "")
    args.add(error?.code ?: -1)
    args.add(error?.description ?: "")
    args.add(error?.xb3TraceId ?: "")
    MethodChannel(flutterPlugin.binaryMessenger, "revupRewardedInterstitialListener").invokeMethod("onRewardedInterstitialAdFailedToShow", args)
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }

  override fun onAttachedToActivity(binding: ActivityPluginBinding) {
    mActivity = binding.activity
    LuckyEventHooker.schemeEvent = ::adEventWebViewNavigated
  }

  override fun onDetachedFromActivityForConfigChanges() {}

  override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {}

  override fun onDetachedFromActivity() {}
}
