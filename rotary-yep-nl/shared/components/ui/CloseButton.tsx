/**
 * CloseButton component - Platform-agnostic wrapper
 * Metro bundler will resolve .ios.tsx or .android.tsx automatically
 */

import { Platform } from "react-native";
import { CloseButtonProps } from "@/shared/components/ui/types";

const PlatformCloseButton = Platform.select({
  ios: () => require("./CloseButton.ios").CloseButton,
  android: () => require("./CloseButton.android").CloseButton,
  default: () => require("./CloseButton.android").CloseButton,
})();

export function CloseButton(props: CloseButtonProps) {
  return <PlatformCloseButton {...props} />;
}
