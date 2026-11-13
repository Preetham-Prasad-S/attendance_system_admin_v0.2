---
name: flutter-ui-development
description: Build clean, modular, maintainable and visually appealing Flutter screens and widgets following this project's UI development conventions, widget composition standards, styling rules and code quality requirements.
---

# Flutter UI Development

## Purpose

This skill defines the UI development standards for this Flutter project.

Whenever creating, modifying or refactoring screens and widgets, follow these guidelines.

The primary goals are:

- Clean and maintainable code.
- Small and reusable widgets.
- Maximum practical use of const constructors.
- Separation of UI and logic.
- Consistent application styling.
- High-quality visual design.
- Easy future extensibility.

## 1. Project Inspection

Before implementing anything:

- Inspect the existing project structure.
- Understand the existing architecture and naming conventions.
- Identify existing reusable widgets and components.
- Check existing theme and color definitions.
- Reuse existing implementations whenever appropriate.
- Avoid creating duplicate components.
- Do not modify unrelated files.

Never assume the project structure without inspecting it first.

## 2. Widget Development

### Const First

- Use const constructors wherever possible.
- Mark widgets and objects as const whenever their values are compile-time constants.
- Prefer const widgets to reduce unnecessary widget recreation.
- Do not sacrifice readability just to force const usage.

### Small Build Methods

- Keep build methods small, readable and focused.
- Never implement an entire complex screen inside one build method.
- Break down large UI sections into smaller widgets.
- Avoid deeply nested and unnecessarily complicated widget trees.

### Widget Extraction

Follow these guidelines when extracting widgets:

- Extract meaningful UI sections into separate widgets.
- Place extracted widgets in their own Dart files.
- Very small and trivial UI elements can remain together when extraction adds unnecessary complexity.
- Each widget must have a clear responsibility.
- Avoid creating unnecessary one-line wrapper widgets.

### Widget Communication

- Pass required data through constructors.
- Pass callbacks through constructors.
- Avoid unnecessary dependencies between widgets.
- Prefer immutable widget properties.
- Keep widgets independent and reusable wherever practical.

## 3. Event Handlers and Validation

- Do not unnecessarily write complex callback logic directly inside onPressed, onTap or similar properties.
- Extract event-handler functions into clearly named methods.
- Keep handlers within the widget or state class responsible for that interaction.
- Pass callbacks to child widgets through constructors.
- Extract form validation into dedicated validator functions.
- Keep validation logic separate from UI composition.
- Avoid mixing unrelated business logic into event handlers.

## 4. Theme and Styling

The application must maintain centralized theme and color definitions.

### app_theme.dart

- Define the application's theme class in app_theme.dart.
- Centralize ThemeData configuration.
- Define reusable theme configurations where appropriate.
- Use the application's existing theme when implementing widgets.

### app_colors.dart

- Define application colors in app_colors.dart.
- Avoid hardcoding colors throughout individual widgets.
- Reuse centralized color definitions.
- Add new application colors to the centralized color file when necessary.

### Styling Guidelines

- Maintain consistent spacing and visual hierarchy.
- Reuse styling definitions when they provide genuine value.
- Avoid unnecessary duplication of styling logic.
- Choose font sizes, padding, margins, border radii and dimensions according to the design requirements.
- There are no mandatory fixed values for these dimensions.
- Do not introduce unnecessary styling restrictions.

## 5. State Management

Initially, use Flutter's built-in state management.

- Prefer StatelessWidget when mutable state is unnecessary.
- Use StatefulWidget when local state is required.
- Use setState for straightforward local state updates.
- Keep complex logic outside build methods.
- Avoid making API calls directly inside UI widgets.
- Keep UI composition separate from business logic wherever practical.
- Structure widgets so state and callbacks can be migrated to a different state-management solution later.

Do not introduce Riverpod, Bloc, Provider, GetX or other third-party state-management packages unless explicitly requested.

State-management architecture and migration will be handled by a separate skill.

## 6. Responsive Design

Follow the platform requirements specified in the user's task.

Examples:

- Mobile only: Optimize for mobile.
- Desktop only: Optimize for desktop.
- Mobile and desktop: Design for both platforms.
- Tablet only: Optimize for tablet.

Do not automatically implement responsiveness for every platform.

Avoid unnecessary responsive complexity when only one target platform is requested.

Keep the implementation maintainable so additional platform support can be introduced later.

## 7. UI/UX Design

The user's explicit design preferences take priority over reference images and the AI's default design preferences.

- Follow the user's design instructions carefully.
- Treat screenshots and design references as guidance rather than strict specifications.
- Use good visual hierarchy, spacing, typography and alignment.
- Make appropriate design decisions to improve usability and visual appeal.
- Avoid generic-looking interfaces.
- Do not unnecessarily simplify designs.
- Use appropriate Flutter widgets and layout techniques.
- Introduce animations and transitions when they improve the experience.
- Maintain consistency with the existing application design system.

When a reference is provided, understand its layout and visual structure before implementation.

## 8. Code Quality

After implementation:

- Check whether existing widgets and components can be reused.
- Avoid duplicate implementations.
- Follow existing naming conventions.
- Avoid modifying unrelated files.
- Ensure widget responsibilities are clear.
- Check for unnecessary widget nesting.
- Check whether const can be applied.
- Check that callbacks and validation functions are properly separated.
- Run Dart formatting.
- Run Flutter analysis and resolve relevant errors and warnings.

Do not claim that formatting, analysis or testing succeeded unless the corresponding commands have actually been executed.

## 9. Implementation Workflow

For every screen or widget implementation, follow this workflow:

1. Inspect the existing project and relevant files.
2. Understand the requested design and functionality.
3. Identify existing components that can be reused.
4. Plan the screen and widget composition.
5. Implement the screen using small, focused widgets.
6. Extract meaningful widgets into separate files.
7. Separate callbacks and validation logic.
8. Apply the existing theme and centralized colors.
9. Implement the requested state management approach.
10. Format and analyze the modified code.
11. Review the final implementation for code quality and consistency.

## 10. Strict Widget and File Separation

This is a mandatory project convention.

### Separate Files for Extracted Widgets

- Whenever a meaningful widget is extracted from a screen or another widget, it MUST be placed in its own Dart file.
- Do not place multiple independently extracted widget classes in one Dart file.
- Do not group multiple widget classes together simply because they belong to the same screen.
- Organize related widgets into feature-specific folders.
- Small, trivial UI elements that do not justify independent extraction may remain within their parent widget's file.

### Screen Responsibilities

- Screens are responsible for coordinating their UI and initiating screen-level actions.
- Screen-level actions such as opening dialogs, navigating to other screens and initiating workflows should be triggered from the screen.
- Do not unnecessarily place screen-level orchestration functions inside unrelated child widgets.
- Dialog implementations must remain separate from the screens that invoke them.

### Dialog Responsibilities

- Each meaningful dialog should have its own widget implementation file.
- The screen that needs the dialog should initiate it.
- Dialog-specific UI, local state and interactions should belong to the dialog.
- Dialog-specific helper widgets should be extracted into separate files when they have meaningful responsibilities.
- Do not place an entire dialog implementation inside its parent screen.

### Function Responsibilities

- Keep event handlers in the widget responsible for the interaction.
- Keep validation functions with the relevant form or field component.
- Keep business logic outside UI composition.
- Avoid large helper methods that construct entire sections of UI when those sections should be independent widgets.
- Do not extract every small function into a separate file unnecessarily.

### Mandatory Verification

Before completing an implementation:

1. Inspect every newly created Dart file.
2. Verify that meaningful extracted widgets have their own files.
3. Verify that screens do not contain unrelated dialog implementations.
4. Verify that screen-level actions are initiated from their respective screens.
5. Verify that widget responsibilities are clearly separated.

## Final Principle

Prioritize maintainability, readability, modularity and visual quality.

The objective is not simply to make the UI work. The objective is to produce clean, well-structured Flutter code that is easy to understand, extend, maintain and refactor.
