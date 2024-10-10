import { StatusBar } from "expo-status-bar";
import { useState, useEffect } from "react";
import { StyleSheet, Text, View } from "react-native";
import { FlatList } from "react-native-gesture-handler";
import { SafeAreaView } from "react-native-safe-area-context";
import { GestureHandlerRootView } from 'react-native-gesture-handler';

export default function App() {
  const [todos, setTodos] = useState([]);

  // Llamada a la API al montar el componente
  useEffect(() => {
    async function fetchData() {
      try {
        const response = await fetch("http://192.168.100.86:8080/todos/1");
        if (!response.ok) {
          const errorText = await response.text(); // Obtener el texto del error
          throw new Error(`HTTP error! status: ${response.status} - ${errorText}`);
        }
        const data = await response.json();
        setTodos(data);
      } catch (error) {
        console.error("Error fetching data: ", error);
        setTodos([{ id: 'error', title: error.message }]); // Para mostrar el error en la lista
      }
    }

    fetchData();
  }, []); // El arreglo vacío asegura que se ejecute solo una vez al montar el componente

  return (
    <GestureHandlerRootView style={styles.container}>
      <SafeAreaView>
        <FlatList
          data={todos}
          keyExtractor={(todo) => todo.id.toString()}
          renderItem={({ item }) => <Text>{item.title ? item.title : "Título no disponible"}</Text>} // Manejo de posibles valores no válidos
        />
      </SafeAreaView>
      <StatusBar style="auto" />
    </GestureHandlerRootView>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: "#fff",
    alignItems: "center",
    justifyContent: "center",
  }
});
