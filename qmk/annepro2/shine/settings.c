#include "settings.h"
#include "profiles.h"

/*
 * Active profiles
 * Add profiles from source/profiles.h in the profile array
 */
profile profiles[] = {
    /* {colorBleed, {0, 0, 0, 0}, NULL, NULL}, */
    {blue, {0, 0, 0, 0}, NULL, NULL},
    {cyan, {0, 0, 0, 0}, NULL, NULL},
    {fuchsia, {0, 0, 0, 0}, NULL, NULL},
    {green, {0, 0, 0, 0}, NULL, NULL},
    {orange, {0, 0, 0, 0}, NULL, NULL},
    {red, {0, 0, 0, 0}, NULL, NULL},
    {violet, {0, 0, 0, 0}, NULL, NULL},
    {white, {0, 0, 0, 0}, NULL, NULL},
    {yellow, {0, 0, 0, 0}, NULL, NULL},
};

/* Set your defaults here */
uint8_t currentProfile = 0;
const uint8_t amountOfProfiles = sizeof(profiles) / sizeof(profile);
volatile uint8_t currentSpeed = 0;
uint8_t ledIntensity = 0;
