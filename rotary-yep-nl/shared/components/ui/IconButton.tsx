/**
 * IconButton component - Platform-agnostic wrapper
 * Metro bundler will resolve .ios.tsx or .android.tsx automatically
 */

import { Platform } from "react-native";
import type { IconButtonProps } from "./types";

// eslint-disable-next-line @typescript-eslint/no-require-imports
const PlatformIconButton = Platform.select({
  ios: () => require("./IconButton.ios").IconButton,
  android: () => require("./IconButton.android").IconButton,
  default: () => require("./IconButton.android").IconButton,
})();

export function IconButton(props: IconButtonProps) {
  return <PlatformIconButton {...props} />;
}
