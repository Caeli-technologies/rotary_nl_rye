/**
 * Section component for iOS
 * Uses SwiftUI-style sections from @expo/ui
 */

import { Section as ExpoSection } from '@expo/ui/swift-ui';
import type { SectionProps } from './types';

export function Section({ title, footer, children }: SectionProps) {
  return (
    <ExpoSection title={title} footer={footer}>
      {children}
    </ExpoSection>
  );
}
