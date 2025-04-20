import {
  configureMessagingService,
  openChatPage,
  setPreChatData,
} from 'react-native-salesforce-messaging';
import { View, StyleSheet, Button } from 'react-native';

export default function App() {
  const openChat = async () => {
    try {
      await configureMessagingService(
        'https://messaging-service-dev-ed.develop.lightning.force.com/services/apexrest/MessagingService/',
        '00D000000000000',
        'MessagingService'
      );
      await openChatPage();
      await setPreChatData({
        name: 'John Doe',
        email: 'john.doe@example.com',
        phone: '1234567890',
      });
    } catch (error) {
      console.log(error);
    }
  };

  return (
    <View style={styles.container}>
      <Button title="Open Chat" onPress={openChat} />
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
  },
});
