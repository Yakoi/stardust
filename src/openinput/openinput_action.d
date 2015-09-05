/* Converted to D from openinput_action.h by htod */
module openinput.openinput_action;
/*
 * openinput_action.h : Definitions for action mapper interface
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

//C     #ifndef _OPENINPUT_ACTION_H_
//C     #define _OPENINPUT_ACTION_H_


/* ******************************************************************** */

// Action map structure
/**
 * @ingroup PAction
 * @brief Action map structure
 *
 * This structure defines an action-map
 */
//C     typedef struct oi_actionmap {
//C         unsigned int actionid;         /**< User-defined id, the action */
//C         unsigned char device;          /**< Device index, 0 for all */
//C         char *name;                    /**< Trigger on this named event */
//C     } oi_actionmap;
struct oi_actionmap
{
    uint actionid;
    ubyte device;
    char *name;
}
extern (C):

/* ******************************************************************** */

//C     #endif
