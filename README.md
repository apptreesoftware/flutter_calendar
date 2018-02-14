# flutter_calendar

A calendar for Flutter apps.

## You got options:

### Just Render it

```dart
new Calendar()
```

gives you:

![standard view](http://res.cloudinary.com/ericwindmill/image/upload/c_scale,h_500/v1518649521/flutter_calendar_standard_lu6l9i.gif)

***

### Make it Expandable

```dart
new Calendar(
  isExpandable: true;
)
```

gives you:

![expanded view](http://res.cloudinary.com/ericwindmill/image/upload/c_scale,h_500/v1518649515/flutter_calendar_expanded_d6gi9n.gif)

***

### Customize It (Standard or Expandable)

```dart
new Calendar(
  // A builder function that renders each calendar tile how you'd like.
  dayBuilder: new Text('!')
)
```

gives you:

![day builder](http://res.cloudinary.com/ericwindmill/image/upload/c_scale,h_500,w_231/v1518649516/Simulator_Screen_Shot_-_iPhone_X_-_2018-02-14_at_15.04.04_jtranm.png)