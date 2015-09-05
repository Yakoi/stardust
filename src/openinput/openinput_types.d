/* Converted to D from openinput_types.h by htod */
module openinput.openinput_types;
/*
 * openinput_types.h : Basic type definitions
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

//C     #ifndef _OPENINPUT_TYPES_H_
//C     #define _OPENINPUT_TYPES_H_


/* ******************************************************************** */

/**
 * @ingroup PTypes
 * @defgroup PBool Tri-state type
 * @brief Enable, disable or query
 * @{
 */
enum oi_bool{
    OI_DISABLE                     = 0,    /**< False/disable */
    OI_ENABLE                      = 1,    /**< True/enable */
    OI_QUERY                       = 2     /**< Don't change, return current */
}                                  /**< Tri-state (bool + query) */
extern (C):
/** @} */


/**
 * @ingroup PTypes
 * @defgroup PWindow Window hook parameters
 * @brief Init string parameters for window_id
 * @{
 */
const char OI_I_CONN = 'c';/**< Server connection handle */
const char OI_I_SCRN = 's'; /**< Screen handle */
const char OI_I_WINID= 'w'; /**< Window handle */
/** @} */


/**
 * @ingroup PTypes
 * @defgroup PProvide Device provide flags
 * @brief Device provide flags
 * @{
 */
//C     #define OI_PRO_UNKNOWN              1 /**< Unknown/test type device */
//C     #define OI_PRO_WINDOW               2 /**< Window stuff (move/state/size) */
const OI_PRO_UNKNOWN = 1;
//C     #define OI_PRO_SYSTEM               4 /**< System events (segfault/interrupt/etc) */
const OI_PRO_WINDOW = 2;
//C     #define OI_PRO_KEYBOARD             8 /**< Keyboard input device */
const OI_PRO_SYSTEM = 4;
//C     #define OI_PRO_MOUSE               16 /**< Pointer input device (mouse) */
const OI_PRO_KEYBOARD = 8;
//C     #define OI_PRO_JOYSTICK            32 /**< Joystick input device */
const OI_PRO_MOUSE = 16;
/** @} */
const OI_PRO_JOYSTICK = 32;


/**
 * @ingroup PTypes
 * @defgroup PFocus Application focus flags
 * @brief Application activation
 * @{
 */
//C     #define OI_FOCUS_MOUSE              1 /**< Window has mouse focus */
//C     #define OI_FOCUS_INPUT              2 /**< Window has keyboard (input) focus */
const OI_FOCUS_MOUSE = 1;
//C     #define OI_FOCUS_VISIBLE            4 /**< Window is visible */
const OI_FOCUS_INPUT = 2;
/** @} */
const OI_FOCUS_VISIBLE = 4;


/**
 * @ingroup PTypes
 * @defgroup PFlags Library initilization flags
 * @brief Initialization flags
 * @{
 */
//C     #define OI_FLAG_NOWINDOW        1 /**< Do not hook into window */
/** @} */
const OI_FLAG_NOWINDOW = 1;


/**
 * @ingroup PTypes
 * @defgroup PErrors Error codes
 * @brief Error codes
 * @{
 */
//C     #define OI_ERR_OK               0 /**< All ok */
//C     #define OI_ERR_NO_DEVICE        1 /**< Wrong device */
const OI_ERR_OK = 0;
//C     #define OI_ERR_INDEX            2 /**< Index query out of bounds */
const OI_ERR_NO_DEVICE = 1;
//C     #define OI_ERR_NOT_IMPLEM       4 /**< Not implemented */
const OI_ERR_INDEX = 2;
//C     #define OI_ERR_DEV_EXIST        5 /**< Device already initialized */
const OI_ERR_NOT_IMPLEM = 4;
//C     #define OI_ERR_PARAM            6 /**< Invalid parameter */
const OI_ERR_DEV_EXIST = 5;
//C     #define OI_ERR_NO_NAME          7 /**< No such event name exists */
const OI_ERR_PARAM = 6;
//C     #define OI_ERR_INTERNAL         8 /**< Fatal internal error */
const OI_ERR_NO_NAME = 7;
//C     #define OI_ERR_DEV_BEHAVE       9 /**< Device programming error */
const OI_ERR_INTERNAL = 8;
/** @} */
const OI_ERR_DEV_BEHAVE = 9;

/* ******************************************************************** */

//C     #endif
