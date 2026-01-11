/**
 * Country selection modal for camps filtering
 */

import { StyleSheet, View, Modal, FlatList, Pressable, Text } from "react-native";
import { SafeAreaView } from "react-native-safe-area-context";
import { Ionicons } from "@expo/vector-icons";
import { Image } from "expo-image";
import { useTheme } from "@/core/theme";
import { getFlagAsset } from "@/shared/utils/flags";
import type { CountryWithCode, FilterState } from "../types";

interface CountryModalProps {
  visible: boolean;
  onClose: () => void;
  countries: CountryWithCode[];
  selectedCountry: string;
  onSelectCountry: (country: string) => void;
}

export function CountryModal({
  visible,
  onClose,
  countries,
  selectedCountry,
  onSelectCountry,
}: CountryModalProps) {
  const { colors } = useTheme();

  const handleSelectCountry = (country: string) => {
    onSelectCountry(country);
    onClose();
  };

  const renderCountryItem = ({ item }: { item: CountryWithCode }) => {
    const isSelected = selectedCountry === item.code;
    const flagAsset = item.code ? getFlagAsset(item.code.toLowerCase()) : null;

    return (
      <Pressable
        style={({ pressed }) => [
          styles.item,
          isSelected && [styles.itemSelected, { backgroundColor: colors.backgroundElevated }],
          pressed && [styles.itemPressed, { backgroundColor: colors.backgroundElevated }],
        ]}
        onPress={() => handleSelectCountry(item.code)}
      >
        <View style={styles.itemContent}>
          {flagAsset ? (
            <Image source={flagAsset} style={styles.flag} contentFit="cover" />
          ) : (
            <View style={[styles.flag, styles.flagPlaceholder]}>
              <Ionicons name="flag-outline" size={16} color={colors.textSecondary} />
            </View>
          )}
          <Text
            style={[styles.itemText, { color: colors.text }, isSelected && styles.itemTextSelected]}
          >
            {item.country}
          </Text>
        </View>
        {isSelected && <Ionicons name="checkmark" size={20} color={colors.primary} />}
      </Pressable>
    );
  };

  const renderAllCountriesItem = () => {
    const isSelected = selectedCountry === "";

    return (
      <Pressable
        style={({ pressed }) => [
          styles.item,
          isSelected && [styles.itemSelected, { backgroundColor: colors.backgroundElevated }],
          pressed && [styles.itemPressed, { backgroundColor: colors.backgroundElevated }],
        ]}
        onPress={() => handleSelectCountry("")}
      >
        <View style={styles.itemContent}>
          <View style={[styles.flag, styles.allCountriesIcon]}>
            <Ionicons name="globe-outline" size={14} color={colors.textSecondary} />
          </View>
          <Text
            style={[styles.itemText, { color: colors.text }, isSelected && styles.itemTextSelected]}
          >
            Alle landen
          </Text>
        </View>
        {isSelected && <Ionicons name="checkmark" size={20} color={colors.primary} />}
      </Pressable>
    );
  };

  return (
    <Modal
      visible={visible}
      animationType="slide"
      presentationStyle="pageSheet"
      onRequestClose={onClose}
    >
      <SafeAreaView style={[styles.container, { backgroundColor: colors.background }]}>
        <View style={[styles.header, { borderBottomColor: colors.border }]}>
          <Text style={[styles.title, { color: colors.text }]}>Selecteer Land</Text>
          <Pressable style={styles.closeButton} onPress={onClose}>
            <Ionicons name="close" size={24} color={colors.textSecondary} />
          </Pressable>
        </View>

        <FlatList
          data={countries}
          renderItem={renderCountryItem}
          keyExtractor={(item) => item.code}
          ListHeaderComponent={renderAllCountriesItem}
          showsVerticalScrollIndicator
          contentContainerStyle={styles.list}
        />
      </SafeAreaView>
    </Modal>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
  },
  header: {
    flexDirection: "row",
    justifyContent: "space-between",
    alignItems: "center",
    paddingHorizontal: 16,
    paddingVertical: 16,
    borderBottomWidth: StyleSheet.hairlineWidth,
  },
  title: {
    fontSize: 18,
    fontWeight: "600",
  },
  closeButton: {
    padding: 4,
  },
  list: {
    paddingVertical: 8,
  },
  item: {
    flexDirection: "row",
    alignItems: "center",
    justifyContent: "space-between",
    paddingHorizontal: 16,
    paddingVertical: 12,
  },
  itemSelected: {},
  itemPressed: {},
  itemContent: {
    flexDirection: "row",
    alignItems: "center",
    flex: 1,
  },
  flag: {
    width: 24,
    height: 18,
    marginRight: 12,
    borderRadius: 2,
  },
  flagPlaceholder: {
    justifyContent: "center",
    alignItems: "center",
  },
  allCountriesIcon: {
    justifyContent: "center",
    alignItems: "center",
  },
  itemText: {
    fontSize: 16,
    fontWeight: "400",
  },
  itemTextSelected: {
    fontWeight: "500",
  },
});
