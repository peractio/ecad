#include "readWrite.h"
#define ROTARY_VALUE_SIZE 256
#define UPDATE_WINDOW 100

void debug_print(int value)
{
	asm ("csrw	0x7B2, %0" : : "r" (value) );
}

int bound(int val, int low, int high){
	if (val < low){
		return low;
	}
	else if (val > high) {
		return high;
	}
	else {
		return val;
	}
}

void clear_screen(){
	// clears in vertical strips, from the left to the right of the screen
	for(int i=0; i<DISPLAY_WIDTH; i++){
		for (int j=0; j<DISPLAY_HEIGHT; j++){
			vid_set_pixel(i, j, PIXEL_BLACK);
		}
	}
}

int main(void)
{
	// initialise in middle
	int x=DISPLAY_WIDTH/2, y=DISPLAY_HEIGHT/2;
	int left, right, buttons;
	int left_prev=0, right_prev=0;
	int left_change, right_change;

	// while loop
	while(1){
		// read left dial position, left arrow decrements left
		left = avalon_read(PIO_ROTARY_L);
		// read right dial position, up arrow decrements right
		right = avalon_read(PIO_ROTARY_R);

		left_change = left - left_prev;
		right_change = right - right_prev;
		// if there's a change in left or right dial rotation, update pixel
		if (left_change || right_change){
			if (left_change > UPDATE_WINDOW){
				left_change -= ROTARY_VALUE_SIZE;
			}
			else if (left_change < -UPDATE_WINDOW){
				left_change += ROTARY_VALUE_SIZE;
			}

			if (right_change > UPDATE_WINDOW){
				right_change -= ROTARY_VALUE_SIZE;
			}
			else if (right_change < -UPDATE_WINDOW){
				right_change += ROTARY_VALUE_SIZE;
			}

			x += left_change;
			y += right_change;

			left_prev = left;
			right_prev = right;

			// bound within display
			x = bound(x, 0, DISPLAY_WIDTH-1);
			y = bound(y, 0, DISPLAY_HEIGHT-1);
			
			vid_set_pixel(x, y, PIXEL_WHITE);
		}

		// clear screen if left or right dial is clicked
		buttons = avalon_read(PIO_BUTTONS);
		if (buttons == BUTTONS_MASK_DIALL_CLICK || buttons == BUTTONS_MASK_DIALR_CLICK){
			clear_screen();
		}
	}

	return 0;
}
