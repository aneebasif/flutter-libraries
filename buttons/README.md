## A plugin for all of your material clean buttons


## Getting started

Import the plugin and call the `WoiCapsuleButton` and you are good to go... 🎉

Here are the list of all of the buttons present in the package:
### Capsule Buttons
`WoiCapsuleIconButton`
`WoiCapsuleGradientButton`
`WoiCapsuleLoadingButton`


```yaml
# add this line to your dependencies
weoveri_button: ^0.0.1
```

```dart
import 'package:weoveri_button/main.dart';
```

## Usage

As simple as using a TextButton widget just call the `WoiCapsuleButton`.

Although `text` and `onTap` is required to show the inital text of the button and tap action.


```dart
WoiCapsuleButton(
    text: 'Confirm',
    onTap: () {},
)
```

|Parameter|Description|
|-----------------------------------|--------------------------------------|
|textStyle   |is used to provide textStyle for the text used in button|
|borderColor    |By default the border color is black|
|backgroundColor      |The default value is black|
|borderRadius |Option to change the border radius, default value is 50|

## Additional information

Incase of any issues or assistance please reach out on [saad@we-over-i.com](mailto:saad@we-over-i.com) or [saadjavaidalvi@gmail.com](mailto:saadjavaidalvi@gmail.com)

Have Fun!