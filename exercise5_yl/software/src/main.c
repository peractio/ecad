#include "asmfunctions.h"

int myfunction(int x, int y) // function for testing
{
	return x+y;
}

void hex_output(int value)
{
	int *hex_leds = (int *) 0x04000080;  // define a pointer to the register
	*hex_leds = value;                   // write the value to that address
}

void debug_print(int value)
{
	asm ("csrw	0x7B2, %0" : : "r" (value) );
}

int main(void)
{
	// let the decimal representation be abcdef
	int a, b, c, d, e, f, t, temp, result;

	// print the time i times
	for (int i=0; i<10000; i++){
		// assuming 50 * 10**6 cycles in 1 sec
		// as the subsequent code assumes 1000 cycles, I will divide by 50 * 10**3 aka 50000
		t = div(get_time(), 50000);

		// from now on assuming 1000 cycles in 1 sec
		temp = div(t, 1000*60);
		a = div(temp, 10);
		b = rem(temp, 10);

		temp = div(t, 1000);
		c = div(rem(temp, 60), 10);
		d = rem(temp, 10);

		temp = rem(t, 1000);
		e = div(temp, 100);
		f = div(rem(temp, 100), 10);

		// bit shifts to represent decimal in hexadecimal print
		result = f;
		result += e << 4;
		result += d << (4*2);
		result += c << (4*3);
		result += b << (4*4);
		result += a << (4*5);

		debug_print(result);
	}

	return result;
}
