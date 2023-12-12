# Flutter Stateless && Stateful Widgets

## Stateless Widgets

Stateless widgets are widgets that do not change over time: They are immutable.
They get initialized once thru the `build()` method and they do not change over time.
We will use stateless widgets to create block pf the UI that do not change over time.

## Stateful Widgets

Stateful widgets are widgets that can change over time: They are mutable.
They have an associated State object that can change over time.
Each time the state changes the `build()` method is called again automatically to update the UI.
Changes to the state are done thru the `setState()` method.
That `setState()` method is the one which triggers the `build()` method to be called again.
We will use stateful widgets to create blocks of the UI that can change over time.