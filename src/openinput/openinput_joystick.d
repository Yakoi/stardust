/* Converted to D from openinput_joystick.h by htod */
module openinput.openinput_joystick;
/*
 * openinput_joystick.h : Definitions for joystick interface
 *
 * This file is a part of the OpenInput library.
 * Copyright (C) 2005  Jakob Kjaer <makob@makob.dk>.
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
 */

/* ******************************************************************** */

//C     #ifndef _OPENINPUT_JOYSTICK_H_
//C     #define _OPENINPUT_JOYSTICK_H_


/* ******************************************************************** */

/**
 * @ingroup PTypes
 * @defgroup PJoyHats Joystick hat positions
 * @brief Joystick hat positions
 * @{
 */
//C     #define OI_HAT_CENTER      0                          /**< Center */
//C     #define OI_HAT_UP          1                          /**< Up */
const OI_HAT_CENTER = 0;
//C     #define OI_HAT_DOWN        2                          /**< Down */
const OI_HAT_UP = 1;
//C     #define OI_HAT_LEFT        4                          /**< Left */
const OI_HAT_DOWN = 2;
//C     #define OI_HAT_RIGHT       8                          /**< Right */
const OI_HAT_LEFT = 4;
//C     #define OI_HAT_UPLEFT      (OI_HAT_UP|OI_HAT_LEFT)    /**< Up + left */
const OI_HAT_RIGHT = 8;
//C     #define OI_HAT_UPRIGHT     (OI_HAT_UP|OI_HAT_RIGHT)   /**< Up + right */
//C     #define OI_HAT_DOWNLEFT    (OI_HAT_DOWN|OI_HAT_LEFT)  /**< Down + left */
//C     #define OI_HAT_DOWNRIGHT   (OI_HAT_DOWN|OI_HAT_RIGHT) /**< Down + right */
/** @} */


/**
 * @ingroup PJoyTypes
 * @brief Joystick entity classes
 *
 * Joysticks typically have different kinds ("types") of axes like
 * sticks, throttles and rudders. This enum is used both to
 * tell what kind an axis is, and to tell the difference between
 * axes and buttons in the unique joystick "code" used in
 * joystick events.
 */
//C     typedef enum {
//C         OIJ_NONE                = 0,      /**< Not an axis/button */
//C         OIJ_GEN_BUTTON          = 1,      /**< Generic button */
//C         OIJ_GEN_AXIS            = 2,      /**< Generic axis */
//C         OIJ_STICK               = 3,      /**< A classic stick (axis) */
//C         OIJ_HAT                 = 4,      /**< Positional button (axis) */
//C         OIJ_RUDDER              = 5,      /**< Yaw-stick (axis) */
//C         OIJ_THROTTLE            = 6,      /**< Throttle/trimmer (axis) */
//C         OIJ_BALL                = 7,      /**< Trackball (relative events, 2-axis) */
//C         OIJ_LAST                          /**< Last joystick class type */
//C     } oi_joytype;
enum
{
    OIJ_NONE,
    OIJ_GEN_BUTTON,
    OIJ_GEN_AXIS,
    OIJ_STICK,
    OIJ_HAT,
    OIJ_RUDDER,
    OIJ_THROTTLE,
    OIJ_BALL,
    OIJ_LAST,
}
extern (C):
alias int oi_joytype;


/**
 * @ingroup PTypes
 * @defgroup PJoyTypes Joystick definitions
 * @brief Joystick buttons and constants
 * @{
 */
//C     #define OI_JOY_NUM_DEVS      32       /**< Maximum number of joysticks */
//C     #define OI_JOY_NUM_AXES      16       /**< Maximum buttons/axes */
const OI_JOY_NUM_DEVS = 32;
//C     #define OI_JOY_AXIS_MIN     -32768    /**< Minimum axis value */
const OI_JOY_NUM_AXES = 16;
//C     #define OI_JOY_AXIS_MAX      326767   /**< Maximum axis value */
const OI_JOY_AXIS_MIN = -32768;
const OI_JOY_AXIS_MAX = 326767;
int OI_JOY_ENCODE_TYPE(int t){return (0x0000ffff & (t));}        /**< Make the type-part of a joystick code */
int OI_JOY_DECODE_TYPE(int t){return (0x0000ffff & (t));}        /**< Get the type-part of a joystick code */
int OI_JOY_ENCODE_INDEX(int i){return (0xffff0000 & ((i) <<16));} /**< Make the index-part of a joystick code */
int OI_JOY_DECODE_INDEX(int i){return ((0xffff0000 & (i)) >>16);} /**< Get the index-part of a joystick code */
int OI_JOY_MAKE_CODE(int t,int i){return (OI_JOY_ENCODE_TYPE((t)) + OI_JOY_ENCODE_INDEX((i)));} /**< Make joystick code given type and index (in that order) */
const int OI_JOY_NONE_CODE = OI_JOY_MAKE_CODE(OIJ_NONE, 0);   /**< The 'none' code that never matches */
/** @} */

/* ******************************************************************** */

//C     #endif
