import MaterialIcons from "@expo/vector-icons/MaterialIcons";
import {
  NativeTabs,
  Icon,
  VectorIcon,
  Label,
} from "expo-router/unstable-native-tabs";
import { Platform, DynamicColorIOS } from "react-native";
import { useTheme } from "@/core/theme";

export default function TabLayout() {
  const { colors: themeColors } = useTheme();

  // Use DynamicColorIOS for liquid glass effect on iOS
  const tintColor =
    Platform.OS === "ios"
      ? DynamicColorIOS({
          dark: themeColors.primary,
          light: themeColors.primary,
        })
      : themeColors.primary;

  const labelColor =
    Platform.OS === "ios"
      ? DynamicColorIOS({
          dark: "white",
          light: "black",
        })
      : undefined;

  return (
    <NativeTabs
      minimizeBehavior="onScrollDown"
      disableTransparentOnScrollEdge
      tintColor={tintColor}
      labelStyle={
        labelColor
          ? {
              color: labelColor,
            }
          : undefined
      }
    >
      <NativeTabs.Trigger name="index">
        <Label>Home</Label>
        {Platform.select({
          ios: (
            <Icon
              sf={{ default: "house", selected: "house.fill" }}
              selectedColor={tintColor}
            />
          ),
          android: (
            <Icon
              src={<VectorIcon family={MaterialIcons} name="home" />}
              selectedColor={themeColors.primary}
            />
          ),
        })}
      </NativeTabs.Trigger>

      <NativeTabs.Trigger name="about">
        <Label>About</Label>
        {Platform.select({
          ios: (
            <Icon
              sf={{ default: "info.circle", selected: "info.circle.fill" }}
              selectedColor={tintColor}
            />
          ),
          android: (
            <Icon
              src={<VectorIcon family={MaterialIcons} name="info" />}
              selectedColor={themeColors.primary}
            />
          ),
        })}
      </NativeTabs.Trigger>

      <NativeTabs.Trigger name="emergency">
        <Label>Emergency</Label>
        {Platform.select({
          ios: (
            <Icon
              sf={{
                default: "exclamationmark.triangle",
                selected: "exclamationmark.triangle.fill",
              }}
              selectedColor={tintColor}
            />
          ),
          android: (
            <Icon
              src={<VectorIcon family={MaterialIcons} name="warning" />}
              selectedColor={themeColors.primary}
            />
          ),
        })}
      </NativeTabs.Trigger>

      <NativeTabs.Trigger name="contact">
        <Label>Contact</Label>
        {Platform.select({
          ios: (
            <Icon
              sf={{ default: "person.2", selected: "person.2.fill" }}
              selectedColor={tintColor}
            />
          ),
          android: (
            <Icon
              src={<VectorIcon family={MaterialIcons} name="people" />}
              selectedColor={themeColors.primary}
            />
          ),
        })}
      </NativeTabs.Trigger>

      <NativeTabs.Trigger name="settings">
        <Label>Settings</Label>
        {Platform.select({
          ios: (
            <Icon
              sf={{ default: "gear", selected: "gear" }}
              selectedColor={tintColor}
            />
          ),
          android: (
            <Icon
              src={<VectorIcon family={MaterialIcons} name="settings" />}
              selectedColor={themeColors.primary}
            />
          ),
        })}
      </NativeTabs.Trigger>
    </NativeTabs>
  );
}
