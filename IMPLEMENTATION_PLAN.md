# Zamir Professional Portfolio - Master Implementation Plan

## Phase Alignment Status
- [x] Phase 1: Environment Setup & Senior Guardrails
- [x] Phase 2: Domain Modeling
- [x] Phase 3: Data Layer & Firebase Integration
- [x] Phase 4: Modern Branding & The "Beautiful" Splash
- [x] Phase 5: Interactive Dashboard & Navigation Sync (VERIFIED)
- [x] Phase 6: Resume Module & Social Integration (VERIFIED)
- [x] Phase 7: Responsiveness Verification & Optimization (VERIFIED)
- [x] Phase 8: Automated Deployment to GitHub Pages (VERIFIED)

## Phase 5: Interactive Dashboard & Navigation Sync
...
## Phase 6: Resume Module & Social Integration

### Stage 1: Global Navigation Updates
- [ ] **Social Icons**: GitHub and LinkedIn integration in Top Nav.
- [ ] **Action Buttons**: "Download CV" button with direct PDF link.
- [ ] **Url Launcher**: Browser-tab redirection for external links.

### Stage 2: Resume Viewer Module
- [ ] **PDF Rendering**: Integration of `pdfrx` for skeuomorphic viewer.
- [ ] **Interactive Viewer**: Zoom, scroll, and responsive modal transitions.
- [ ] **Resume Dashboard Section**: New dedicated section for document viewing.

### Stage 3: Clean Architecture Sync
- [ ] **Domain Entity**: `ResumeEntity` for versioning.
- [ ] **Riverpod Provider**: `ResumeProvider` for async PDF loading state.
- [ ] **Mobile Optimization**: Full-screen modal viewer for smaller viewports.

## Phase 7: Responsiveness Verification & Optimization

### Stage 1: Responsive Breakpoints
- [x] **ResponsiveConfig**: Defined breakpoints for Mobile (<600), Tablet (<1024), and Desktop.
- [ ] **Hamburger Menu**: Implement Drawer for mobile navigation.
- [ ] **Adaptive Nav Bar**: Hide floating nav on mobile in favor of Drawer.

### Stage 2: Adaptive Widgets
- [x] **Responsive Grid**: Project grid adapts crossAxisCount (1, 2, or 4).
- [ ] **Fluid Typography**: Adjust header sizes based on screen width.
- [ ] **Resume Scaling**: Ensure PDF viewer scales and maintains usability on small screens.

### Stage 3: Layout Verification
- [ ] **Hardcoded Audit**: Replace fixed widths/heights with MediaQuery/Flexible.
- [ ] **Viewport Testing**: Verify 375px, 768px, and 1440px widths.
- [ ] **Edge Padding**: Fluid padding for various screen sizes.

## Verification Plan
...
- Verify scroll sync accuracy.
- Test hover states on project cards.
- Ensure theme toggle doesn't break scroll listeners.
