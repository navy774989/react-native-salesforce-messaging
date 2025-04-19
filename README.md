# React Native Salesforce Messaging

A React Native module for integrating Salesforce Messaging (In-App) into your React Native applications.

## Features

- Configure Salesforce Messaging service
- Set pre-chat data
- Open chat interface
- Support for both iOS and Android

## Installation

```bash
npm install react-native-salesforce-messaging
# or
yarn add react-native-salesforce-messaging
```

### iOS Installation

For iOS, the installation is handled automatically by React Native's auto-linking. Just run:

```bash
cd ios && pod install
```

### Android Installation

1. Add the following to your `android/build.gradle`:

```gradle
allprojects {
    repositories {
        google()
        mavenCentral()
        maven {
            url "https://s3.amazonaws.com/inapp.salesforce.com/public/android"
        }
    }
}
```

2. Add the following to your `android/app/build.gradle`:

```gradle
dependencies {
    implementation "com.salesforce.service:messaging-inapp-ui:1.8.0"
}
```

## Usage

```javascript
import { NativeModules } from 'react-native';
const { SalesforceMessaging } = NativeModules;

// Configure the messaging service
await SalesforceMessaging.configureMessagingService(
  'your-service-api-url',
  'your-organization-id',
  'your-developer-name'
);

// Set pre-chat data
SalesforceMessaging.setPreChatData({
  name: 'John Doe',
  email: 'john@example.com',
  // Add other pre-chat fields as needed
});

// Open the chat interface
SalesforceMessaging.openChatPage();
```

## API Reference

### `configureMessagingService(serviceAPIUrl, organizationId, developerName)`

Configures the Salesforce Messaging service.

| Parameter      | Type   | Description                                  |
| -------------- | ------ | -------------------------------------------- |
| serviceAPIUrl  | string | The URL of your Salesforce Messaging service |
| organizationId | string | Your Salesforce organization ID              |
| developerName  | string | The developer name for your deployment       |

### `setPreChatData(data)`

Sets pre-chat data for the conversation.

| Parameter | Type   | Description                                |
| --------- | ------ | ------------------------------------------ |
| data      | object | An object containing pre-chat field values |

### `openChatPage()`

Opens the chat interface.

## Example

```javascript
import React from 'react';
import { Button, View } from 'react-native';
import { NativeModules } from 'react-native';

const { SalesforceMessaging } = NativeModules;

const App = () => {
  const startChat = async () => {
    try {
      // Configure the service
      await SalesforceMessaging.configureMessagingService(
        'https://your-service-url.com',
        'your-org-id',
        'your-dev-name'
      );

      // Set pre-chat data
      await SalesforceMessaging.setPreChatData({
        name: 'John Doe',
        email: 'john@example.com',
        phone: '+1234567890',
      });

      // Open chat
      await SalesforceMessaging.openChatPage();
    } catch (error) {
      console.error('Error starting chat:', error);
    }
  };

  return (
    <View style={{ flex: 1, justifyContent: 'center', alignItems: 'center' }}>
      <Button title="Start Chat" onPress={startChat} />
    </View>
  );
};

export default App;
```

## Requirements

- React Native >= 0.60.0
- iOS >= 12.0
- Android API Level >= 24

## License

MIT

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

---

Made with [create-react-native-library](https://github.com/callstack/react-native-builder-bob)
