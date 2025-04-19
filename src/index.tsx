import { NativeModules, Platform } from 'react-native';

const LINKING_ERROR =
  `The package 'react-native-salesforce-messaging' doesn't seem to be linked. Make sure: \n\n` +
  Platform.select({ ios: "- You have run 'pod install'\n", default: '' }) +
  '- You rebuilt the app after installing the package\n' +
  '- You are not using Expo Go\n';

const SalesforceMessaging = NativeModules.SalesforceMessaging
  ? NativeModules.SalesforceMessaging
  : new Proxy(
      {},
      {
        get() {
          throw new Error(LINKING_ERROR);
        },
      }
    );
interface PreChatData {
  [key: string]: string;
}
export function setPreChatData(data: PreChatData): Promise<number> {
  return SalesforceMessaging.setPreChatData(data);
}
export function openChatPage(): Promise<string> {
  return SalesforceMessaging.openChatPage();
}
export function configureMessagingService(
  serviceAPIUrl: string,
  organizationId: string,
  developerName: string
): Promise<string> {
  return SalesforceMessaging.configureMessagingService(
    serviceAPIUrl,
    organizationId,
    developerName
  );
}
