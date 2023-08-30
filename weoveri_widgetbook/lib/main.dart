import 'package:weoveri_capsule_button/capsule_button.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

void main() {
  runApp(const WidgetbookApp());
}

class WidgetbookApp extends StatelessWidget {
  const WidgetbookApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Widgetbook.material(
      directories: [
        WidgetbookComponent(
          name: 'Capsule Button',
          isInitiallyExpanded: true,
          useCases: [
            WidgetbookUseCase(
              name: 'Without Knobs',
              builder: (context) {
                return MyCapsuleButton(
                  text: 'Without Knobs',
                  onTap: () {},
                );
              },
            ),
            WidgetbookUseCase(
              name: 'With Knobs',
              builder: (context) {
                return SizedBox(
                  width: context.knobs.double.input(
                    label: 'W Increment By',
                    initialValue: 140,
                  ),
                  child: MyCapsuleButton(
                    onTap: () {},
                    borderRadius: context.knobs.double.slider(
                      label: 'Border Radius',
                      // initialValue: 'With Knobs',
                      min: 0,
                      initialValue: 50,
                      max: 100,
                    ),
                    text: context.knobs.string(
                      label: 'Title',
                      initialValue: 'With Knobs',
                    ),
                    fillColor: context.knobs.color(
                      label: 'Color',
                      initialValue: Colors.black,
                    ),
                    heigth: context.knobs.double.input(
                      label: 'Height Increment By',
                      // min: 60,
                      initialValue: 50,
                      // max: 120,
                    ),
                    myIcon: const Icon(
                      Icons.link,
                      color: Colors.white,
                    ),
                    isRevresed: 'Start' ==
                            context.knobs.list(
                              label: 'Icon',
                              options: [
                                "Start",
                                "End",
                                "No Icon",
                              ],
                            )
                        ? false
                        : true,
                    showIcon: 'No Icon' !=
                        context.knobs.list(
                          label: 'Icon',
                          options: [
                            "Start",
                            "End",
                            "No Icon",
                          ],
                        ),
                    /* showToolTip: context.knobs.boolean(
                      initialValue: true,
                      label: 'Show Increment Tool Tip',
                      description: 'This is the tooltip that is displayed '
                          'when hovering over the increment button',
                    ), */
                  ),
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}
