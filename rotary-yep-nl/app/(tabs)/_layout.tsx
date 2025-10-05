import MaterialIcons from '@expo/vector-icons/MaterialIcons';
import { NativeTabs, Icon, VectorIcon, Label } from 'expo-router/unstable-native-tabs';
import { Platform } from 'react-native';
import { useTheme } from '@/hooks/use-theme';
import React from 'react';

export default function TabLayout() {
  const { colors: themeColors } = useTheme();

  // Define tab bar colors using Rotary brand colors
  const activeColors = {
    tintColor: themeColors.primary,
    backgroundColor: themeColors.card,
    iconColor: themeColors.icon,
    labelColor: themeColors.textSecondary,
    shadowColor: themeColors.shadow,
    selectedIconColor: themeColors.primary,
  };

  return (
    <NativeTabs
      tintColor={activeColors.tintColor}
      backgroundColor={activeColors.backgroundColor}
      iconColor={activeColors.iconColor}
      labelStyle={{
        color: activeColors.labelColor,
        fontSize: Platform.OS === 'ios' ? 12 : 12,
        fontWeight: '500',
      }}
      disableTransparentOnScrollEdge={Platform.OS === 'ios'}
      blurEffect={Platform.OS === 'ios' ? 'systemMaterial' : undefined}
      shadowColor={Platform.OS === 'ios' ? activeColors.shadowColor : undefined}
      labelVisibilityMode={Platform.OS === 'android' ? 'labeled' : undefined}
      rippleColor={Platform.OS === 'android' ? `${themeColors.primary}33` : undefined}>
      <NativeTabs.Trigger name="index">
        <Label>Home</Label>
        {Platform.select({
          ios: (
            <Icon
              sf={{ default: 'house', selected: 'house.fill' }}
              selectedColor={activeColors.selectedIconColor}
            />
          ),
          android: (
            <Icon
              src={<VectorIcon family={MaterialIcons} name="home" />}
              selectedColor={activeColors.selectedIconColor}
            />
          ),
        })}
      </NativeTabs.Trigger>

      <NativeTabs.Trigger name="about">
        <Label>About</Label>
        {Platform.select({
          ios: (
            <Icon
              sf={{ default: 'info.circle', selected: 'info.circle.fill' }}
              selectedColor={activeColors.selectedIconColor}
            />
          ),
          android: (
            <Icon
              src={<VectorIcon family={MaterialIcons} name="info" />}
              selectedColor={activeColors.selectedIconColor}
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
                default: 'exclamationmark.triangle',
                selected: 'exclamationmark.triangle.fill',
              }}
              selectedColor={activeColors.selectedIconColor}
            />
          ),
          android: (
            <Icon
              src={<VectorIcon family={MaterialIcons} name="warning" />}
              selectedColor={activeColors.selectedIconColor}
            />
          ),
        })}
      </NativeTabs.Trigger>

      <NativeTabs.Trigger name="contact">
        <Label>Contact</Label>
        {Platform.select({
          ios: (
            <Icon
              sf={{ default: 'person.2', selected: 'person.2.fill' }}
              selectedColor={activeColors.selectedIconColor}
            />
          ),
          android: (
            <Icon
              src={<VectorIcon family={MaterialIcons} name="people" />}
              selectedColor={activeColors.selectedIconColor}
            />
          ),
        })}
      </NativeTabs.Trigger>

      <NativeTabs.Trigger name="settings">
        <Label>Settings</Label>
        {Platform.select({
          ios: (
            <Icon
              sf={{ default: 'gearshape', selected: 'gearshape.fill' }}
              selectedColor={activeColors.selectedIconColor}
            />
          ),
          android: (
            <Icon
              src={<VectorIcon family={MaterialIcons} name="settings" />}
              selectedColor={activeColors.selectedIconColor}
            />
          ),
        })}
      </NativeTabs.Trigger>
    </NativeTabs>
  );
}
