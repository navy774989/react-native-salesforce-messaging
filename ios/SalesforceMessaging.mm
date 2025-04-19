#import <React/RCTBridgeModule.h>
#import "SalesforceMessaging-Swift.h"

@interface RCT_EXTERN_MODULE(SalesforceMessaging, NSObject)

RCT_EXTERN_METHOD(openChatPage)

RCT_EXTERN_METHOD(setPreChatData:(NSDictionary) prechatData)
RCT_EXTERN_METHOD(configureMessagingService:(NSString)serviceAPIUrl withOrganizationId:(NSString)organizationId
                  withDeveloperName:(NSString)developerName
                  withResolver:(RCTPromiseResolveBlock)resolve
                  withRejecter:(RCTPromiseRejectBlock)reject)

+ (BOOL)requiresMainQueueSetup
{
  return NO;
}

@end
