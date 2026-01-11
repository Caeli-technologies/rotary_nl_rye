/**
 * Section component for Android
 * Uses Jetpack Compose-style sections from @expo/ui
 */

import { Section as ExpoSection } from '@expo/ui/jetpack-compose';
import type { SectionProps } from './types';

export function Section({ title, footer, children }: SectionProps) {
  return (
    <ExpoSection title={title} footer={footer}>
      {children}
    </ExpoSection>
  );
}
