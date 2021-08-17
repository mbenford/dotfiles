#include "profiles.h"
#include "miniFastLED.h"
#include "string.h"

void blue(led_t *currentKeyLedColors) {
  setAllKeysColor(currentKeyLedColors, naiveDimRGB(0x0000ff));
}

void cyan(led_t *currentKeyLedColors) {
  setAllKeysColor(currentKeyLedColors, naiveDimRGB(0x00ffff));
}

void fuchsia(led_t *currentKeyLedColors) {
  setAllKeysColor(currentKeyLedColors, naiveDimRGB(0xff00ff));
}

void green(led_t *currentKeyLedColors) {
  setAllKeysColor(currentKeyLedColors, naiveDimRGB(0x00ff00));
}

void orange(led_t *currentKeyLedColors) {
  setAllKeysColor(currentKeyLedColors, naiveDimRGB(0xffa500));
}

void red(led_t *currentKeyLedColors) {
  setAllKeysColor(currentKeyLedColors, naiveDimRGB(0xff0000));
}

void violet(led_t *currentKeyLedColors) {
  setAllKeysColor(currentKeyLedColors, naiveDimRGB(0x6900cc));
}

void white(led_t *currentKeyLedColors) {
  setAllKeysColorHSV(currentKeyLedColors, 63, 125, 255);
}

void yellow(led_t *currentKeyLedColors) {
  setAllKeysColor(currentKeyLedColors, naiveDimRGB(0xffff00));
}
