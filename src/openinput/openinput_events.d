/* Converted to D from openinput_events.h by htod */
module openinput.openinput_events;
/*
 * openinput_events.h : Event structure types
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

//C     #ifndef _OPENINPUT_EVENTS_H_
//C     #define _OPENINPUT_EVENTS_H_
//C     #include "openinput_keyboard.h"
import openinput.openinput_keyboard;


/**
 * @ingroup PTypes
 * @defgroup PEventStructs Event structures
 * @brief Event structures
 *
 * Depending on which device that generates an event, different
 * event structures are used. All events contain a "type" field,
 * but are otherwise different from each other.
 */
//C     typedef enum {
//C         OI_NOEVENT                    = 0,  /**< No event */
//C         OI_KEYUP                      = 1,  /**< Key released */
//C         OI_KEYDOWN                    = 2,  /**< Key pressed */
//C         OI_MOUSEMOVE                  = 3,  /**< Mouse motion */
//C         OI_MOUSEBUTTONUP              = 4,  /**< Button released */
//C         OI_MOUSEBUTTONDOWN            = 5,  /**< Button pressed */
//C         OI_ACTIVE                     = 6,  /**< App. focus gain/loss */
//C         OI_RESIZE                     = 7,  /**< App. window resize */
//C         OI_EXPOSE                     = 8,  /**< App. needs redraw */
//C         OI_QUIT                       = 9,  /**< Quit requested */
//C         OI_DISCOVERY                  = 10, /**< Device driver available */
//C         OI_ACTION                     = 11, /**< Action event (actionmap) */
//C         OI_JOYAXIS                    = 12, /**< Joystick axis */
//C         OI_JOYBUTTONUP                = 13, /**< Joystick button released */
//C         OI_JOYBUTTONDOWN              = 14, /**< Joystick button pressed */
//C         OI_JOYBALL                    = 15  /**< Joystick trackball */
//C     } oi_type;
enum oi_type
{
    OI_NOEVENT,
    OI_KEYUP,
    OI_KEYDOWN,
    OI_MOUSEMOVE,
    OI_MOUSEBUTTONUP,
    OI_MOUSEBUTTONDOWN,
    OI_ACTIVE,
    OI_RESIZE,
    OI_EXPOSE,
    OI_QUIT,
    OI_DISCOVERY,
    OI_ACTION,
    OI_JOYAXIS,
    OI_JOYBUTTONUP,
    OI_JOYBUTTONDOWN,
    OI_JOYBALL,
}
extern (C):


/**
 * @ingroup PTypes
 * @defgroup PEventmask Event masks
 * @brief Definition of event masks
 * @{
 */
int OI_EVENT_MASK(int x){return (1<<(x));}                                 /**< Mask generator */
//C     #define OI_MASK_ALL 0xffffffff                                    /**< Match all masks */
const OI_MASK_ALL = 0xffffffff;
const int OI_MASK_KEYUP = OI_EVENT_MASK(oi_type.OI_KEYUP);           /**< Key up */
const int OI_MASK_KEYDOWN = OI_EVENT_MASK(oi_type.OI_KEYDOWN);         /**< Key down */
const int OI_MASK_MOUSEMOVE       = OI_EVENT_MASK(oi_type.OI_MOUSEMOVE);       /**< Mouse motion */
const int OI_MASK_MOUSEBUTTONUP   = OI_EVENT_MASK(oi_type.OI_MOUSEBUTTONUP);   /**< Mouse button up */
const int OI_MASK_MOUSEBUTTONDOWN = OI_EVENT_MASK(oi_type.OI_MOUSEBUTTONDOWN); /**< Mouse button down */
const int OI_MASK_ACTIVE          = OI_EVENT_MASK(oi_type.OI_ACTIVE);          /**< Window focus */
const int OI_MASK_RESIZE          = OI_EVENT_MASK(oi_type.OI_RESIZE);          /**< Window resize */
const int OI_MASK_EXPOSE          = OI_EVENT_MASK(oi_type.OI_EXPOSE);          /**< Window show/update */
const int OI_MASK_DISCOVERY       = OI_EVENT_MASK(oi_type.OI_DISCOVERY);       /**< Device discovery */
const int OI_MASK_ACTION          = OI_EVENT_MASK(oi_type.OI_ACTION);          /**< Action map */
const int OI_MASK_QUIT            = OI_EVENT_MASK(oi_type.OI_QUIT);            /**< Application quit */
const int OI_MASK_WINDOW          = (OI_EVENT_MASK(oi_type.OI_ACTIVE) | OI_EVENT_MASK(oi_type.OI_RESIZE) | OI_EVENT_MASK(oi_type.OI_EXPOSE)); /**< Focus, resize, expose */
const int OI_MASK_MOUSE           = (OI_EVENT_MASK(oi_type.OI_MOUSEMOVE) | OI_EVENT_MASK(oi_type.OI_MOUSEBUTTONUP) | OI_EVENT_MASK(oi_type.OI_MOUSEBUTTONDOWN)); /**< Mouse button and motion */
const int OI_MASK_JOYSTICK        = (OI_EVENT_MASK(oi_type.OI_JOYAXIS) | OI_EVENT_MASK(oi_type.OI_JOYBUTTONUP) | OI_EVENT_MASK(oi_type.OI_JOYBUTTONDOWN) | OI_EVENT_MASK(oi_type.OI_JOYBALL)); /**< Joystick axes, buttons and trackballs */
/** @} */


/**
 * @ingroup PEventStructs
 * @brief Device discovery event
 *
 * Sent when device drivers are registered and ready for use
 */
//C     typedef struct oi_discovery_event {
//C         unsigned char type;              /**< OI_DISCOVERY  */
//C         unsigned char device;            /**< Device index  */
//C         char *name;                      /**< Short name  */
//C         char *description;               /**< Long description  */
//C         unsigned int provides;           /**< Provide mask  */
//C     } oi_discovery_event;
struct oi_discovery_event
{
    ubyte type;
    ubyte device;
    char *name;
    char *description;
    uint provides;
}


/**
 * @ingroup PEventStructs
 * @brief Application visibility event
 *
 * Sent when applicaiton loses or gains focus, see
 * @ref PFocus
 */
//C     typedef struct oi_active_event {
//C         unsigned char type;              /**< OI_ACTIVE  */
//C         unsigned char device;            /**< Device index  */
//C         char gain;                       /**< Focus was 0:lost 1:gained */
//C         unsigned int state;              /**< Bitmask of focus state  */
//C     } oi_active_event;
struct oi_active_event
{
    ubyte type;
    ubyte device;
    char gain;
    uint state;
}


/**
 * @ingroup PEventStructs
 * @brief Keyboard event
 *
 * Sent when keyboard keys are pressed or released
 */
//C     typedef struct oi_keyboard_event {
//C         unsigned char type;              /**< OI_KEYUP or OI_KEYDOWN  */
//C         unsigned char device;            /**< Device index  */
//C         oi_keysym keysym;                /**< Key symbol  */
//C     } oi_keyboard_event;
struct oi_keyboard_event
{
    ubyte type;
    ubyte device;
    oi_keysym keysym;
}


/**
 * @ingroup PEventStructs
 * @brief Mouse move event
 *
 * Sent when the mouse moves
 */
//C     typedef struct oi_mousemove_event {
//C         unsigned char type;              /**< OI_MOUSEMOVE */
//C         unsigned char device;            /**< Device index */
//C         unsigned int state;              /**< Button state bitmask */
//C         int x;                           /**< Absolute x coordinate */
//C         int y;                           /**< Absolute y coordinate */
//C         int relx;                        /**< Relative x movement */
//C         int rely;                        /**< Relative y movement */
//C     } oi_mousemove_event;
struct oi_mousemove_event
{
    ubyte type;
    ubyte device;
    uint state;
    int x;
    int y;
    int relx;
    int rely;
}


/**
 * @ingroup PEventStructs
 * @brief Mouse button event
 *
 * Sent when mouse buttons are pressed or released
 */
//C     typedef struct oi_mousebutton_event {
//C         unsigned char type;              /**< OI_MOUSEBUTTONUP or OI_MOUSEBUTTONDOWN */
//C         unsigned char device;            /**< Device index */
//C         unsigned char button;            /**< Mouse button index */
//C         unsigned int state;              /**< Button state bitmask */
//C         int x;                           /**< Absolute x coordinate at event time */
//C         int y;                           /**< Absolute y coordinate at event time */
//C     } oi_mousebutton_event;
struct oi_mousebutton_event
{
    ubyte type;
    ubyte device;
    ubyte button;
    uint state;
    int x;
    int y;
}


/**
 * @ingroup PEventStructs
 * @brief Application window resize event
 *
 * Sent when the size of the application window changes
 */
//C     typedef struct oi_resize_event {
//C         unsigned char type;              /**< OI_RESIZE */
//C         unsigned char device;            /**< Device index */
//C         int width;                       /**< New window width */
//C         int height;                      /**< New window height */
//C     } oi_resize_event;
struct oi_resize_event
{
    ubyte type;
    ubyte device;
    int width;
    int height;
}


/**
 * @ingroup PEventStructs
 * @brief Application window needs redraw
 *
 * Sent when application window is shown
 */
//C     typedef struct oi_expose_event {
//C         unsigned char type;              /**< OI_EXPOSE */
//C     } oi_expose_event;
struct oi_expose_event
{
    ubyte type;
}


/**
 * @ingroup PEventStructs
 * @brief Quit event
 *
 * Sent when your application should shutdown.
 * This usually happens when the user closes the
 * window, or when system error occurs
 */
//C     typedef struct oi_quit_event {
//C         unsigned char type;              /**< OI_QUIT */
//C     } oi_quit_event;
struct oi_quit_event
{
    ubyte type;
}


/**
 * @ingroup PEventStructs
 * @brief Action event
 *
 * Sent when an action map has been triggered
 */
//C     typedef struct oi_action_event {
//C         unsigned char type;              /**< OI_ACTION */
//C         unsigned char device;            /**< Device index */
//C         unsigned int actionid;           /**< User-defined actionid */
//C         char state;                      /**< State (pressed:1/released:0) */
//C         int data1;                       /**< Default data slot   (1d device: x coord) */
//C         int data2;                       /**< Secondary data slot (2d device: y coord) */
//C         int data3;                       /**< Tertiary data slot  (3d device: z coord) */
//C     } oi_action_event;
struct oi_action_event
{
    ubyte type;
    ubyte device;
    uint actionid;
    char state;
    int data1;
    int data2;
    int data3;
}


/**
 * @ingroup PEventStructs
 * @brief Joystick axis event
 *
 * Sent when an axis (stick/throttle/whatever)
 * changes position. Use the "code" to get the axis index and type.
 */
//C     typedef struct oi_joyaxis_event {
//C         unsigned char type;              /**< OI_JOYAXIS */
//C         unsigned char device;            /**< Device index */
//C         unsigned int code;               /**< Joystick code see @ref PJoyTypes */
//C         int abs;                         /**< Absolute axis position */
//C         int rel;                         /**< Relative axis motion */
//C     } oi_joyaxis_event;
struct oi_joyaxis_event
{
    ubyte type;
    ubyte device;
    uint code;
    int abs;
    int rel;
}


/**
 * @ingroup PEventStructs
 * @brief Joystick button event
 *
 * Sent when a button on a joystick
 * is pressed or released. Use the "code" to get the button index.
 */
//C     typedef struct oi_joybutton_event {
//C         unsigned char type;              /**< OI_JOYBUTTONUP or OI_JOYBUTTONDOWN */
//C         unsigned char device;            /**< Device index */
//C         unsigned int code;               /**< Joystick code see @ref PJoyTypes */
//C         unsigned int state;              /**< Buttons state bitmask */
//C     } oi_joybutton_event;
struct oi_joybutton_event
{
    ubyte type;
    ubyte device;
    uint code;
    uint state;
}


/**
 * @ingroup PEventStructs
 * @brief Joystick trackball event
 *
 * Sent when an joystick trackball moves
 */
//C     typedef struct oi_joyball_event {
//C         unsigned char type;              /**< OI_JOYBALL */
//C         unsigned char device;            /**< Device index */
//C         unsigned int code;               /**< Joystick code see @ref PJoyTypes */
//C         int relx;                        /**< Relative x movement */
//C         int rely;                        /**< Relative y movement */
//C     } oi_joyball_event;
struct oi_joyball_event
{
    ubyte type;
    ubyte device;
    uint code;
    int relx;
    int rely;
}


/**
 * @ingroup PEventStructs
 * @brief Event union
 *
 * The combined event union. Check the "type" variable
 * to determine what kind of event you're dealing with.
 */
//C     typedef union {
//C         unsigned char type;               /**< Event type */
//C         oi_active_event active;           /**< OI_ACTIVE */
//C         oi_keyboard_event key;            /**< OI_KEYUP or OI_KEYDOWN */
//C         oi_mousemove_event move;          /**< OI_MOUSEMOVE */
//C         oi_mousebutton_event button;      /**< OI_MOUSEBUTTONUP or OI_MOUSEBUTTONDOWN */
//C         oi_resize_event resize;           /**< OI_RESIZE */
//C         oi_expose_event expose;           /**< OI_EXPOSE */
//C         oi_quit_event quit;               /**< OI_QUIT */
//C         oi_discovery_event discover;      /**< OI_DISCOVERY */
//C         oi_action_event action;           /**< OI_ACTION */
//C         oi_joyaxis_event joyaxis;         /**< OI_JOYAXIS */
//C         oi_joybutton_event joybutton;     /**< OI_JOYBUTTONUP or OI_JOYBUTTONDOWN */
//C         oi_joyball_event joyball;         /**< OI_JOYBALL */
//C     } oi_event;
union oi_event
{
    ubyte type;
    oi_active_event active;
    oi_keyboard_event key;
    oi_mousemove_event move;
    oi_mousebutton_event button;
    oi_resize_event resize;
    oi_expose_event expose;
    oi_quit_event quit;
    oi_discovery_event discover;
    oi_action_event action;
    oi_joyaxis_event joyaxis;
    oi_joybutton_event joybutton;
    oi_joyball_event joyball;
}


/* ******************************************************************** */

//C     #endif
