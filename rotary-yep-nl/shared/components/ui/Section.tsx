/**
 * Section component - Platform-agnostic wrapper
 * Metro bundler will resolve .ios.tsx or .android.tsx automatically
 * This file exists for TypeScript compilation
 */

import { Platform } from "react-native";
import type { SectionProps } from "./types";

// eslint-disable-next-line @typescript-eslint/no-require-imports
const PlatformSection = Platform.select({
  ios: () => require("./Section.ios").Section,
  android: () => require("./Section.android").Section,
  default: () => require("./Section.android").Section,
})();

export function Section(props: SectionProps) {
  return <PlatformSection {...props} />;
}
