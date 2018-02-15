# flutter_calendar

A calendar widget for Flutter Apps.

Borrowed DateTime util functions from the (Tzolkin Web Calendar Element)[https://github.com/apptreesoftware/tzolkin].

## Usage

Add to your pubspec dependencies:
```dart
    flutter_calendar: ^0.0.1
```

Render the map with one of three options:

#### 1. Default, Material Design

```dart
new Calendar()
```

![standard view](http://res.cloudinary.com/ericwindmill/image/upload/c_scale,h_500/v1518649521/flutter_calendar_standard_lu6l9i.gif)

***

#### 2. An Expandable Map 

```dart
new Calendar(
  isExpandable: true;
)
```

![expanded view](http://res.cloudinary.com/ericwindmill/image/upload/c_scale,h_500/v1518649515/flutter_calendar_expanded_d6gi9n.gif)

***

#### 3. Customize It (Standard or Expandable)

```dart
new Calendar(
  // A builder function that renders each calendar tile how you'd like.
  dayBuilder: new Text('!')
)
```

gives you:

![day builder](http://res.cloudinary.com/ericwindmill/image/upload/c_scale,h_500,w_231/v1518649516/Simulator_Screen_Shot_-_iPhone_X_-_2018-02-14_at_15.04.04_jtranm.png)

***

### API
```dart
// Three optional params:
final VoidCallback onDateSelected;
final bool isExpandable;
final Widget dayBuilder;
```
  