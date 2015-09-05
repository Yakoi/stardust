/* Converted to D from openinput_api.h by htod */
module openinput.openinput_api;
/*
 * openinput_api.h : Main API
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

//C     #ifndef _OPENINPUT_API_H_
//C     #define _OPENINPUT_API_H_
//C     #include "openinput_types.h"
import openinput.openinput_types;
//C     #include "openinput_events.h"
import openinput.openinput_events;
//C     #include "openinput_mouse.h"
import openinput.openinput_mouse;
//C     #include "openinput_joystick.h"
import openinput.openinput_joystick;
//C     #include "openinput_action.h"
import openinput.openinput_action;
import openinput.openinput_keyboard;


/* ******************************************************************** */

// Default initialization of all available devices (num_failed)
//C     extern  int  oi_init(char* window_id,
//C                                        unsigned int flags);
extern (C):
int  oi_init(char *window_id, uint flags);

// Shutdown all available devices (num_failed)
//C     extern  int  oi_close();
int  oi_close();

/* ******************************************************************** */

// Get device information (errorcode)
//C     extern  int  oi_device_info(unsigned char index,
//C                                               char **name,
//C                                               char **desc,
//C                                               unsigned int *provides);
int  oi_device_info(ubyte index, char **name, char **desc, uint *provides);

// Enable/disable device event pumping (state)
//C     extern  oi_bool  oi_device_enable(unsigned char index,
//C                                                     oi_bool q);
oi_bool  oi_device_enable(ubyte index, oi_bool q);

/* ******************************************************************** */

// Look at event without removing it from queue (number_returned)
//C     extern  int  oi_events_peep(oi_event *evts,
//C                                               int num);
int  oi_events_peep(oi_event *evts, int num);

// Add an event to the tail of the queue (number_added)
//C     extern  int  oi_events_add(oi_event *evts,
//C                                              int num);
int  oi_events_add(oi_event *evts, int num);

// Pump all device to transfer events into queue (n/a)
//C     extern  void  oi_events_pump();
void  oi_events_pump();

// Poll events (more_pending)
//C     extern  int  oi_events_poll(oi_event *evt);
int  oi_events_poll(oi_event *evt);

// Wait for an event (n/a)
//C     extern  void  oi_events_wait(oi_event *evt);
void  oi_events_wait(oi_event *evt);

// Set event type filter mask (n/a)
//C     extern  void  oi_events_setmask(unsigned int mask);
void  oi_events_setmask(uint mask);

// Get event type filter mask (event_mask)
//C     extern  unsigned int  oi_events_getmask();
uint  oi_events_getmask();

/* ******************************************************************** */

// Send events for down-state keys (errorcode)
//C     extern  int  oi_key_repeat(int delay,
//C                                              int interval);
int  oi_key_repeat(int delay, int interval);

// Get key state table and set num to number of elements (pointer)
//C     extern  char *  oi_key_keystate(unsigned char index,
//C                                                   int *num);
char * oi_key_keystate(ubyte index, int *num);

// Return modifier mask (modifier_mask)
//C     extern  unsigned int  oi_key_modstate(unsigned char index);
uint  oi_key_modstate(ubyte index);

// Get name of key (string)
//C     extern  char *  oi_key_getname(oi_key key);
char * oi_key_getname(oi_key key);

// Get key code given name (oi_key)
//C     extern  oi_key  oi_key_getcode(char *name);
oi_key  oi_key_getcode(char *name);

/* ******************************************************************** */

// Get absolute position of mouse (button_mask)
//C     extern  int  oi_mouse_absolute(unsigned char index,
//C                                                  int *x,
//C                                                  int *y);
int  oi_mouse_absolute(ubyte index, int *x, int *y);

// Get relative motion of mouse (button_mask)
//C     extern  int  oi_mouse_relative(unsigned char index,
//C                                                  int *x,
//C                                                  int *y);
int  oi_mouse_relative(ubyte index, int *x, int *y);

// Warp mouse cursor position (errorcode)
//C     extern  int  oi_mouse_warp(unsigned char index,
//C                                              int x,
//C                                              int y);
int  oi_mouse_warp(ubyte index, int x, int y);

// Get name of mouse button (string)
//C     extern  char *  oi_mouse_getname(oi_mouse button);
char * oi_mouse_getname(oi_mouse button);

// Get mouse-id given name (oi_mouse)
//C     extern  oi_mouse  oi_mouse_getcode(char *name);
oi_mouse  oi_mouse_getcode(char *name);

/* ******************************************************************** */

// Get absolute position of joystick axis (button_mask)
//C     extern  unsigned int  oi_joy_absolute(unsigned char index,
//C                                                         unsigned char axis,
//C                                                         int *value,
//C                                                         int *second);
uint  oi_joy_absolute(ubyte index, ubyte axis, int *value, int *second);

// Get relative motion of joystick axis (button_mask)
//C     extern  unsigned int  oi_joy_absolute(unsigned char index,
//C                                                         unsigned char axis,
//C                                                         int *value,
//C                                                         int *second);
uint  oi_joy_absolute(ubyte index, ubyte axis, int *value, int *second);

// Get name of joystick button/axis (string)
//C     extern  char *  oi_joy_getname(unsigned int code);
char * oi_joy_getname(uint code);

// Get mouse-id given name (oi_mouse)
//C     extern  unsigned int  oi_joy_getcode(char *name);
uint  oi_joy_getcode(char *name);

// Get basic information about a joystick device (errorcode)
//C     extern  int  oi_joy_info(unsigned char index,
//C                                            char **name,
//C                                            int *buttons,
//C                                            int *axes);
int  oi_joy_info(ubyte index, char **name, int *buttons, int *axes);

// Get advanced axes information for a joystick device (errorcode)
//C     extern  int  op_joy_axessetup(unsigned char index,
//C                                                 oi_joytype *type[],
//C                                                 unsigned char *pair[],
//C                                                 int *num);
int  op_joy_axessetup(ubyte index, oi_joytype **type, ubyte **pair, int *num);

/* ******************************************************************** */

// Get focus state of application (focus_mask)
//C     extern  unsigned int  oi_app_focus();
uint  oi_app_focus();

// Show/hide cursor (state)
//C     extern  oi_bool  oi_app_cursor(oi_bool q);
oi_bool  oi_app_cursor(oi_bool q);

// Grab/ungrab input (state)
//C     extern  oi_bool  oi_app_grab(oi_bool q);
oi_bool  oi_app_grab(oi_bool q);

/* ******************************************************************** */

// Install actionmap (errorcode)
//C     extern  int  oi_action_install(oi_actionmap *map,
//C                                                  int num);
int  oi_action_install(oi_actionmap *map, int num);

// Check/validate single actionmap structure (errorcode)
//C     extern  int  oi_action_validate(oi_actionmap *map);
int  oi_action_validate(oi_actionmap *map);

// Get action state table and set num to number of elements (pointer)
//C     extern  char *  oi_action_actionstate(int *num);
char * oi_action_actionstate(int *num);

/* ******************************************************************** */

//C     #endif
