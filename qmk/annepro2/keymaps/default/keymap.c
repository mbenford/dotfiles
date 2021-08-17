#include <stdint.h>
#include "annepro2.h"
#include "qmk_ap2_led.h"
#include "config.h"

enum anne_pro_layers {
  _BASE_LAYER,
  _FN1_LAYER,
  _FN2_LAYER,
};

const uint16_t keymaps[][MATRIX_ROWS][MATRIX_COLS] = {
	/*
	* Base layer
	*/
	[_BASE_LAYER] = KEYMAP(
    KC_GRV, KC_1, KC_2, KC_3, KC_4, KC_5, KC_6, KC_7, KC_8, KC_9, KC_0, KC_MINS, KC_EQL, KC_BSPC,
    KC_TAB, KC_Q, KC_W, KC_E, KC_R, KC_T, KC_Y, KC_U, KC_I, KC_O, KC_P, KC_LBRC, KC_RBRC, KC_BSLS,
    MO(_FN1_LAYER), KC_A, KC_S, KC_D, KC_F, KC_G, KC_H, KC_J, KC_K, KC_L, KC_SCLN, KC_QUOT, KC_ENT,
    KC_LSFT, KC_Z, KC_X, KC_C, KC_V, KC_B, KC_N, KC_M, KC_COMM, KC_DOT, KC_SLSH, KC_RSFT,
    KC_LCTL, KC_LALT, KC_LGUI, KC_SPC, OSM(MOD_RALT), KC_RCTL, MO(_FN1_LAYER), MO(_FN2_LAYER)
	),

	/*
	* FN1 layer
	*/
	[_FN1_LAYER] = KEYMAP(
    KC_ESC, KC_F1, KC_F2, KC_F3, KC_F4, KC_F5, KC_F6, KC_F7, KC_F8, KC_F9, KC_F10, KC_F11, KC_F12, KC_DEL,
    _______, _______, _______, KC_ESC, _______, _______, _______, _______, KC_HOME, KC_END, _______, _______, _______, KC_CAPS,
    _______, KC_LALT, KC_LSFT, KC_LCTL, _______, _______, KC_LEFT, KC_DOWN, KC_UP, KC_RIGHT, KC_BSPC, KC_DEL, KC_PSCR,
    _______, _______, S(KC_DEL), C(KC_INS), S(KC_INS), KC_MEDIA_PLAY_PAUSE, KC_MPRV, KC_MNXT, KC_VOLD, KC_VOLU, KC_MUTE, _______,
    _______, _______, _______, KC_ENT, _______, _______, _______, _______
	),

	/*
	* FN2 layer
	*/
	[_FN2_LAYER] = KEYMAP(
    _______, KC_AP2_BT1, KC_AP2_BT2, KC_AP2_BT3, KC_AP2_BT4, _______, _______, _______, _______, _______, _______, KC_AP_LED_SPEED, KC_AP_LED_NEXT_INTENSITY, KC_AP_LED_ON,
    _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, KC_AP_LED_OFF,
    _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______,
    _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______,
    _______, _______, _______, _______, _______, _______, _______, _______
	),
};
const uint16_t keymaps_size = sizeof(keymaps);

void matrix_init_user(void) {
}

void matrix_scan_user(void) {
}

void keyboard_post_init_user(void) {
		annepro2LedEnable();
}

layer_state_t layer_state_set_user(layer_state_t layer) {
    return layer;
}
