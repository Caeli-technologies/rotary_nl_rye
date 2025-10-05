import MaterialIcons from '@expo/vector-icons/MaterialIcons';
import { NativeTabs, Icon, VectorIcon, Label } from 'expo-router/unstable-native-tabs';
import { Platform, useColorScheme } from 'react-native';
import React from 'react';

export default function TabLayout() {
  const colorScheme = useColorScheme();

  // Define colors based on color scheme
  const colors = {
    light: {
      tintColor: '#1A237E',
      backgroundColor: '#FFFFFF',
      iconColor: '#8E8E93',
      selectedIconColor: '#1A237E',
      labelColor: '#8E8E93',
      selectedLabelColor: '#1A237E',
      shadowColor: '#000000',
    },
    dark: {
      tintColor: '#9FA8DA',
      backgroundColor: '#1C1C1E',
      iconColor: '#8E8E93',
      selectedIconColor: '#9FA8DA',
      labelColor: '#8E8E93',
      selectedLabelColor: '#9FA8DA',
      shadowColor: '#000000',
    },
  };

  const activeColors = colors[colorScheme ?? 'light'];

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
      rippleColor={Platform.OS === 'android' ? 'rgba(26, 35, 126, 0.2)' : undefined}>
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
