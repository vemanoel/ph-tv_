import { Text, StyleSheet, useColorScheme, View } from 'react-native';

function App() {
  const isDarkMode = useColorScheme() === 'dark';

  return (
    <View style={styles.container}>
       <Text style={{ color: 'red', fontSize: 24 }}>
        Olá, Android TV!
      </Text>
       <Text style={{ color: 'red', fontSize: 24 }}>
        Olá, Android TV!
      </Text>
       <Text style={{ color: 'red', fontSize: 24 }}>
        Olá, Android TV!
      </Text>
       <Text style={{ color: 'red', fontSize: 24 }}>
        Olá, Android TV!
      </Text>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
  },
});

export default App;
