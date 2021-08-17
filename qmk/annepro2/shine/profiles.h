#include "light_utils.h"
#include "matrix.h"
#include "settings.h"

/* Update ticks based on profile settings */
static inline void updateAnimationSpeed(void) {
  animationSkipTicks = profiles[currentProfile].animationSpeed[currentSpeed];
  animationTicks = 0;
}

void blue(led_t *currentKeyLedColors);
void cyan(led_t *currentKeyLedColors);
void fuchsia(led_t *currentKeyLedColors);
void green(led_t *currentKeyLedColors);
void orange(led_t *currentKeyLedColors);
void red(led_t *currentKeyLedColors);
void violet(led_t *currentKeyLedColors);
void white(led_t *currentKeyLedColors);
void yellow(led_t *currentKeyLedColors);
void colorBleed(led_t *currentKeyLedColors);
