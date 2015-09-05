/* Converted to D from openinput_mouse.h by htod */
module openinput.openinput_mouse;
/*
 * openinput_mouse.h : Definitions for mouse interface
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

//C     #ifndef _OPENINPUT_MOUSE_H_
//C     #define _OPENINPUT_MOUSE_H_


/* ******************************************************************** */

/**
 * @ingroup PTypes
 * @defgroup PMousename Mouse button definitions
 * @brief Mouse buttons
 *
 * Mice typically have three buttons and a scroll-wheel.
 * Each of these are defined here with their human readable
 * string-counterpart.
 *
 * @{
 */
//C     typedef enum {
//C         OIP_UNKNOWN            = 0, /**< mouse_unknown */
//C         OIP_FIRST              = 0, /**< mouse_unknown */
//C         OIP_BUTTON_LEFT        = 1, /**< mouse_left */
//C         OIP_BUTTON_MIDDLE      = 2, /**< mouse_middle */
//C         OIP_BUTTON_RIGHT       = 3, /**< mouse_right */
//C         OIP_WHEEL_UP           = 4, /**< mouse_wheel_up */
//C         OIP_WHEEL_DOWN         = 5, /**< mouse_wheel_down */
//C         OIP_MOTION             = 6, /**< mouse_motion */
//C         OIP_LAST                    /**< mouse_unknown */
//C     } oi_mouse;                     /**< Mouse buttons */
enum oi_mouse
{
    OIP_UNKNOWN,
    OIP_FIRST = 0,
    OIP_BUTTON_LEFT,
    OIP_BUTTON_MIDDLE,
    OIP_BUTTON_RIGHT,
    OIP_WHEEL_UP,
    OIP_WHEEL_DOWN,
    OIP_MOTION,
    OIP_LAST,
}
extern (C):
/** @} */

/**
 * @ingroup PTypes
 * @defgroup PMouseMask Mouse button masks
 * @brief Definition of mouse button masks
 *
 * Mouse button bits used in state parameters.
 *
 * @{
 */
int OI_BUTTON_MASK(int x){return (1<<(x));}                                /**< Button bitmask generator */
const int OI_BUTTON_LEFTMASK= OI_BUTTON_MASK(oi_mouse.OIP_BUTTON_LEFT);   /**< Bitmask for left button */
const int OI_BUTTON_MIDMASK = OI_BUTTON_MASK(oi_mouse.OIP_BUTTON_MIDDLE); /**< Bitmask for middle button */
const int OI_BUTTON_RIGHTMASK = OI_BUTTON_MASK(oi_mouse.OIP_BUTTON_RIGHT);  /**< Bitmask for right button */
/** @} */

/* ******************************************************************** */

//C     #endif
