package com.salesforcemessaging

import com.facebook.react.bridge.ReactApplicationContext
import com.facebook.react.bridge.ReactContextBaseJavaModule
import com.facebook.react.bridge.ReactMethod
import com.facebook.react.bridge.Promise
import com.facebook.react.bridge.ReadableMap
import com.salesforce.android.smi.core.CoreClient
import com.salesforce.android.smi.core.CoreConfiguration
import com.salesforce.android.smi.core.PreChatValuesProvider
import com.salesforce.android.smi.network.data.domain.prechat.PreChatField
import com.salesforce.android.smi.ui.UIClient
import com.salesforce.android.smi.ui.UIConfiguration
import java.net.URL
import java.util.UUID

class SalesforceMessagingModule(reactContext: ReactApplicationContext) :
  ReactContextBaseJavaModule(reactContext) {
  private var config: UIConfiguration? = null
  private var preChatData: ReadableMap? = null
  private val context = reactContext
  override fun getName(): String {
    return NAME
  }

  @ReactMethod
  fun setPreChatData(data: ReadableMap) {
    preChatData = data
    config?.let {
      config->
      val coreClient = CoreClient.Factory.create(context, config)
      coreClient.registerHiddenPreChatValuesProvider( object : PreChatValuesProvider {
        override suspend fun setValues(input: List<PreChatField>): List<PreChatField> {
          input.forEach {
             data.getString(it.name)?.let {
              value->
               it.userInput = value
            }
          }
          return input
        }
      })
    }

  }

  @ReactMethod
  fun configureMessagingService(serviceAPIUrl: String, organizationId: String, developerName: String, promise: Promise) {
    val url = URL(serviceAPIUrl)
    val coreConfig = CoreConfiguration(url, organizationId, developerName)
    val conversationID = UUID.randomUUID()
    config = UIConfiguration(coreConfig, conversationID)
    promise.resolve("done")
  }

  @ReactMethod
  fun openChatPage() {
    config?.let { config ->
      val activity = reactApplicationContext.currentActivity
      activity?.let {
        val uiClient = UIClient.Factory.create(config)
        uiClient.openConversationActivity(activity)
      }

    }
  }

  companion object {
    const val NAME = "SalesforceMessaging"
  }
}
