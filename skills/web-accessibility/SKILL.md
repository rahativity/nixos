---
name: web-accessibility
description: Complete WCAG 2.2 (Level AA & AAA) accessibility engineering standard. Covers semantic HTML, WAI-ARIA 1.2 patterns, keyboard navigation and focus management, color contrast & visual accessibility, screen reader optimization, form validation, motion accessibility, and audit workflows.
license: MIT
metadata:
  standard: WCAG 2.2 (W3C Recommendation) / WAI-ARIA 1.2
  category: frontend-engineering
---

# Web Accessibility Engineering Skill (WCAG 2.2 AA / AAA)

Use this skill when designing, building, auditing, or refactoring web interfaces to ensure universal access for people with disabilities, assistive technology users (screen readers, switch access, screen magnifiers, voice control), and keyboard-only navigators.

---

## 1. The POUR Principles & Engineering Foundations

Every accessible user interface must adhere to the four core principles of the Web Content Accessibility Guidelines (WCAG 2.2):

1. **Perceivable**: Information and user interface components must be presentable to users in ways they can perceive (cannot be invisible to all their senses).
2. **Operable**: User interface components and navigation must be operable (users can navigate and interact via keyboard, mouse, touch, or assistive switches).
3. **Understandable**: Information and the operation of user interface must be understandable (predictable behavior, clear language, helpful error messages).
4. **Robust**: Content must be robust enough that it can be interpreted reliably by a wide variety of user agents, including assistive technologies.

---

## 2. Semantic HTML & The First Rule of ARIA

> **The First Rule of ARIA**: If you can use a native HTML element or attribute with the semantics and behavior already built in, **do so instead of repurposing an element and adding ARIA**.

### Semantic Landmarks & Structure
Use landmark tags to structure the page so screen reader users can navigate sections directly:

```html
<header> <!-- Banner landmark -->
  <nav aria-label="Primary navigation"> <!-- Nav landmark with distinct label -->
    <ul>
      <li><a href="/dashboard">Dashboard</a></li>
      <li><a href="/settings">Settings</a></li>
    </ul>
  </nav>
</header>

<main id="main-content"> <!-- Main landmark: exactly one per page -->
  <h1>Account Overview</h1>
  <section aria-labelledby="billing-heading">
    <h2 id="billing-heading">Billing Information</h2>
  </section>
</main>

<aside aria-label="Related articles"> <!-- Complementary landmark -->
</aside>

<footer> <!-- Contentinfo landmark -->
</footer>
```

### The Button vs. Anchor Rule
- Use `<a>` with an `href` attribute **only** when navigating to a new URL, route, or anchor on the page.
- Use `<button type="button">` for actions, state mutations, opening modals, toggling menus, or submitting forms.
- **Never** write `<a onclick="...">` or `<div role="button">` when a native `<button>` can be used.

---

## 3. Keyboard Navigation & Focus Architecture

Every interactive feature must be fully functional using only a keyboard (`Tab`, `Shift+Tab`, `Enter`, `Space`, `Escape`, arrow keys).

### Skip to Main Content
Provide a skip link as the very first focusable element on every page:

```html
<!-- Visible on focus, visually hidden by default -->
<a href="#main-content" class="skip-link">Skip to main content</a>

<style>
.skip-link {
  position: absolute;
  top: -999px;
  left: 1rem;
  z-index: 10000;
  padding: 0.75rem 1.25rem;
  background: #000;
  color: #fff;
  border-radius: 4px;
}
.skip-link:focus-visible {
  top: 1rem;
}
</style>
```

### Visible Focus Indicators (WCAG 2.4.7 AA & 2.4.13 AAA)
- **Never remove focus outlines**: `outline: none` without an alternative is a critical accessibility failure.
- Implement explicit, high-contrast `:focus-visible` styles:

```css
/* Universal accessible focus ring */
:focus-visible {
  outline: 2px solid #2563eb;
  outline-offset: 2px;
}

/* Dark mode contrast variant */
@media (prefers-color-scheme: dark) {
  :focus-visible {
    outline-color: #60a5fa;
  }
}
```

### Modal Dialog Focus Trapping & Restoration (WAI-ARIA Pattern)
When opening a modal dialog:
1. Save the element that triggered the dialog (`triggerElement = document.activeElement`).
2. Move focus into the first focusable element inside the dialog (or the dialog itself with `tabindex="-1"`).
3. Trap `Tab` and `Shift+Tab` within the dialog boundaries.
4. Listen for `Escape` to close the dialog.
5. On close, return focus to `triggerElement.focus()`.
6. Use `<dialog>` native element whenever possible with `.showModal()`.

---

## 4. Color, Contrast & Visual Sizing Rules

### Contrast Ratios (WCAG 1.4.3 AA & 1.4.6 AAA)
- **Standard Body Text** (< 18pt regular or < 14pt bold): Minimum **4.5:1** contrast ratio against background. (AAA: **7:1**).
- **Large Text** (≥ 18pt regular or ≥ 14pt bold): Minimum **3:1** contrast ratio. (AAA: **4.5:1**).
- **UI Components & Graphical Objects** (WCAG 1.4.11 AA): Form input borders, icons, buttons, focus rings must achieve at least **3:1** against adjacent background.
- **Never rely on color alone** (WCAG 1.4.1): Always provide text labels, icons, or patterns alongside color cues (e.g., error fields must have an icon/error message, not just red border).

### Touch & Click Target Sizing (WCAG 2.5.5 AAA / 2.5.8 AA)
- Minimum target size: **24×24 CSS pixels** (WCAG 2.2 AA).
- Recommended touch target: **44×44 CSS pixels** (WCAG AAA & Apple/Android HIG).
- Provide at least **8px** of spacing between adjacent interactive elements.

---

## 5. Forms, Validation & Error Recovery

### Explicit Form Labeling
Every `<input>`, `<select>`, and `<textarea>` must have an accessible name:

```html
<!-- Preferred: explicit for/id pairing -->
<label for="user-email">Email Address <span aria-hidden="true">*</span></label>
<input 
  type="email" 
  id="user-email" 
  name="email" 
  required 
  aria-required="true"
  aria-describedby="email-hint email-error"
  autocomplete="email"
/>
<p id="email-hint" class="hint">We will never share your email.</p>
<p id="email-error" class="error-msg" role="alert" aria-live="assertive">Please enter a valid email address.</p>
```

### Accessible Form Validation Rules
1. Mark invalid fields with `aria-invalid="true"`.
2. Connect field to its error message via `aria-describedby="<error-element-id>"`.
3. Use `aria-live="polite"` or `role="status"` for inline dynamic feedback.
4. On form submission failure, display an error summary at the top of the form, move focus to the summary or the first invalid field, and list each field with a jump link.

---

## 6. Images, Icons & Media

### Accessible Images (`alt` attributes)
- **Informative image**: `alt="Detailed description of the image content and intent"`.
- **Functional image (inside a button/link)**: `alt` describes the action, e.g., `<a href="/"><img src="logo.svg" alt="Company Name Home" /></a>`.
- **Purely decorative image**: `alt=""` or `aria-hidden="true"`. Never omit the `alt` attribute (omitting causes screen readers to announce the raw file URL).

### Icon Buttons
Buttons containing only an icon must provide an accessible name:

```html
<button type="button" aria-label="Close dialog">
  <svg aria-hidden="true" focusable="false" width="20" height="20">
    <path d="..." />
  </svg>
</button>
```

---

## 7. Motion & Sensory Preferences

Respect user system preferences for reduced motion:

```css
@media (prefers-reduced-motion: reduce) {
  *,
  *::before,
  *::after {
    animation-duration: 0.01ms !important;
    animation-iteration-count: 1 !important;
    transition-duration: 0.01ms !important;
    scroll-behavior: auto !important;
  }
}
```

---

## 8. WCAG 2.2 Verification Checklist

Before shipping any component or page, verify:

| Criteria | Item | Verification Method |
|---|---|---|
| **2.1.1** | Keyboard Accessibility | Can every element be activated with `Tab`, `Enter`, `Space`? |
| **2.1.2** | No Keyboard Trap | Can focus enter and leave every widget without getting stuck? |
| **2.4.3** | Focus Order | Is the tab sequence logical and matches visual layout? |
| **2.4.7** | Focus Visible | Is there a clear, high-contrast focus outline on all elements? |
| **2.4.11** | Focus Not Obscured (WCAG 2.2) | Is focused element never fully hidden by sticky headers/footers? |
| **1.4.3** | Contrast Ratio | Text ≥ 4.5:1, Large text ≥ 3:1, UI borders/icons ≥ 3:1 |
| **2.5.8** | Target Size (WCAG 2.2) | All click/touch targets ≥ 24×24px with sufficient spacing |
| **3.3.1** | Error Identification | Are input errors clearly identified in text and announced by ARIA? |
| **4.1.2** | Name, Role, Value | Do custom widgets have valid ARIA roles, states, and properties? |
