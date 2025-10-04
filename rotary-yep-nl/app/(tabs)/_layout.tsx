import MaterialIcons from '@expo/vector-icons/MaterialIcons';
import { NativeTabs, Icon, VectorIcon, Label } from 'expo-router/unstable-native-tabs';
import { Platform } from 'react-native';
import React from 'react';

export default function TabLayout() {
  return (
    <NativeTabs
      tintColor="#1A237E"
      backgroundColor="#FFFFFF"
      disableTransparentOnScrollEdge
      labelStyle={{
        color: '#1A237E',
      }}>
      <NativeTabs.Trigger name="index">
        <Label>Home</Label>
        {Platform.select({
          ios: <Icon sf="house.fill" />,
          android: <Icon src={<VectorIcon family={MaterialIcons} name="home" />} />,
        })}
      </NativeTabs.Trigger>
      <NativeTabs.Trigger name="about">
        <Label>About</Label>
        {Platform.select({
          ios: <Icon sf="info.circle.fill" />,
          android: <Icon src={<VectorIcon family={MaterialIcons} name="info" />} />,
        })}
      </NativeTabs.Trigger>
      <NativeTabs.Trigger name="emergency">
        <Label>Emergency</Label>
        {Platform.select({
          ios: <Icon sf="exclamationmark.triangle.fill" />,
          android: <Icon src={<VectorIcon family={MaterialIcons} name="warning" />} />,
        })}
      </NativeTabs.Trigger>
      <NativeTabs.Trigger name="contact">
        <Label>Contact</Label>
        {Platform.select({
          ios: <Icon sf="person.2.fill" />,
          android: <Icon src={<VectorIcon family={MaterialIcons} name="people" />} />,
        })}
      </NativeTabs.Trigger>
      <NativeTabs.Trigger name="settings">
        <Label>Settings</Label>
        {Platform.select({
          ios: <Icon sf="gearshape.fill" />,
          android: <Icon src={<VectorIcon family={MaterialIcons} name="settings" />} />,
        })}
      </NativeTabs.Trigger>
    </NativeTabs>
  );
}
