import SMIClientCore
import SMIClientUI
@objc(SalesforceMessaging)
class SalesforceMessaging: NSObject, HiddenPreChatDelegate  {
  var preChatData: NSDictionary!
  var config : UIConfiguration!
  
  @objc(setPreChatData:)
  func setPreChatData(_ data: NSDictionary) {
    self.preChatData = data
  }
  
  @objc(openChatPage)
  func openChatPage() {
    DispatchQueue.main.async {
      let chatVC = ModalInterfaceViewController(self.config)
      chatVC.modalPresentationStyle = .popover
      let presentedViewController = RCTPresentedViewController()
      presentedViewController?.present(chatVC, animated: true, completion: nil)
    }
  }
  
  @objc(configureMessagingService:withOrganizationId:withDeveloperName:withResolver:withRejecter:)
  func configureMessagingService(serviceAPIUrl:String, organizationId:String, developerName:String, resolve:RCTPromiseResolveBlock,reject:RCTPromiseRejectBlock) {
    guard let serviceURL = URL(string: serviceAPIUrl) else {
      reject("invalid_url", "Invalid service API URL", nil)
      return
    }
    let conversationID = UUID()
    config = UIConfiguration(serviceAPI: serviceURL,
                             organizationId: organizationId,
                             developerName: developerName,
                             conversationId: conversationID)
    resolve("done")
  }
}

extension SalesforceMessaging {
  func core(_ core: any CoreClient, conversation: any Conversation, didRequestPrechatValues hiddenPreChatFields: [any HiddenPreChatField], completionHandler: @escaping HiddenPreChatValueCompletion) {
    for preChatField in hiddenPreChatFields {
      let value: String! = preChatData.object(forKey: preChatField.label) as? String
      preChatField.value = value
    }
    completionHandler(hiddenPreChatFields)
  }
  
}
