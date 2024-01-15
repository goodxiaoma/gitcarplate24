/*
 * openmv.h
 *
 *  Created on: Dec 17, 2023
 *      Author: 16486
 */

#ifndef SRC_OPENMV_H_
#define SRC_OPENMV_H_



#include "CH57x_common.h"
extern uint8_t my_re_buf1[20];
extern uint8_t openmvdata[9];
extern uint8_t pt_w1;

extern uint8_t suma;
extern uint8_t sumb;
extern uint8_t plate_firstMark[2];


void OpmvDataGet(uint8_t data);


#endif /* SRC_OPENMV_H_ */
