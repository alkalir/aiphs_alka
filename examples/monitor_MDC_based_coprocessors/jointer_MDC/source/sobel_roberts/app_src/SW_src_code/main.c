
#include <stdio.h>
#include <stdlib.h> // for abs
#include "platform.h"
#include "platform_config.h"
#include "sobel_bare.h" // for the input image
#include "mm_accelerator.h"// to use the accelerator APIs
#include "xtime_l.h"
#include "xil_cache.h"
#include "monitor.h"


//#define EXPORT_RESULT // comment to export results via uart
//#define MON2 // comment to use the second level monitor
//#define MON2_3 // comment to use both the second and third level monitors

#define SIZE 32 // value of the side of the output
#define DETECTOR ROBERTS
#define SOBEL 0
#define ROBERTS 1

#ifdef EXPORT_RESULT
void create_python(int imm[512][512], char[]);
#endif

/* SW implementation of sobel */
void sobel_filter(int img[SIZE+2][SIZE+2], int edge[SIZE][SIZE])
{
	int gx, gy, sum;
	int i,j;
	for(i=1;i<=SIZE;i++){
		for(j=1;j<=SIZE;j++){
			gx = img[i-1][j-1] + 2*img[i][j-1] + img[i+1][j-1] \
					-(img[i-1][j+1] + 2*img[i][j+1] + img[i+1][j+1]);
			gy = img[i-1][j-1] + 2*img[i-1][j] + img[i-1][j+1] \
					-(img[i+1][j-1] + 2*img[i+1][j] + img[i+1][j+1]);
			sum = abs(gx) + abs(gy);
			if(sum>80){
				edge[i-1][j-1] = 255;
			}else{
				edge[i-1][j-1] = 0;
			}
		}
	}
}

void roberts_filter(int img[SIZE+1][SIZE+1], int edge[SIZE][SIZE])
{
	int gx, gy, sum;
	int i,j;
	for(i=1;i<=SIZE;i++){
		for(j=1;j<=SIZE;j++){
			gx = img[i-1][j-1] - img[i][j];
			gy = img[i-1][j] - img[i][j-1];
			sum = abs(gx) + abs(gy);
			if(sum>80){
				edge[i-1][j-1] = 255;
			}else{
				edge[i-1][j-1] = 0;
			}
		}
	}
}

#ifdef EXPORT_RESULT
// output for python script via uart
void create_python(int imm[512][512], char* str){
    printf("-----begin sobel_%s.png------------\n",str);
    printf("import png \n");
    int k, l;
    for (k=0; k<511;k++){
    	if (k==0){
    		printf("img = [[");
    	}
    	else{
    		printf("[");
    	}
    	for (l=0;l<511;l++){
    		if (l==510)
    			printf("%d ",imm[k][l]);
    		else
    			printf("%d, ",imm[k][l]);
    	}
    	if (k==510){
    		printf("]]\n");
    	}
    	else{
    		printf("],\n");
    	}
    }
    printf("png.from_array(img,'L').save(\"sobel_%s.png\")\n",str);
    printf("-----end sobel_%s.png-------\n",str);
}
#endif

int main()
{

    init_platform();

    Xil_DCacheDisable(); // disable caches for better control

    XTime tStart_sw, tEnd_sw, ElapsedTime_sw;

    int i = 0;
    int j = 0;
 //   int edge[512][512]; // array to store the final filtered image
    int edge_sw[512][512]; // array to store the final filtered image
    int edge_hw[512][512]; // array to store the final filtered image

volatile int* config = (int*) XPAR_MM_ACCELERATOR_0_CFG_BASEADDR; // base of accelerator

    int offset;
    if(DETECTOR==SOBEL)
	offset = 2;
    else
	offset = 1;

    int size_dataout = SIZE*SIZE; // size of the output of the sobel. If the input
    							  // image size is equal to 34*34, the output is
    							  // 32*32, i.e. (side-2)*(side-2), where the
    							  // the side is the one of the input image.

    int dataout [size_dataout]; // array to store the data output from the Sobel

    volatile int size_datain = (SIZE+offset)*(SIZE+offset); // size of the input for the sobel.
    									// In this case, it is 34*34.

    volatile int size_image_sobel[1] = {SIZE+offset}; // array to store the size of the side
    									// of the input image
    									// sent to sobel.

    int datain[(SIZE+offset)*(SIZE+offset)]; // array to store the data input to be sent
    								// to the sobel.

    int row = 0;
    int col = 0;

    int edge_block[SIZE][SIZE]; // to store part of the sobel result

    int img_block[SIZE+offset][SIZE+offset]; // to store part of the input image


    // divide the image in parts of size (SIZE + offset) * (SIZE + offset)
	#ifdef EXPORT_RESULT
    char str[10] = "input";
    create_python(img, &str[0]);
	#endif

    printf("Sobel in software \n");

	for(i=0;i<16;i++){
		for(j=0;j<16;j++){
			for(row=-1;row<=SIZE-2+offset;row++){
				for(col=-1;col<=SIZE-2+offset;col++){
					if(i==0 && row ==-1){
						img_block[row+1][col+1] = 0;
					} else if(i==15 && row==32){
						img_block[row+1][col+1] = 0;
					} else {
						if(j==0 && col ==-1){
							img_block[row+1][col+1] = 0;
						} else if(j==15 && col==32){
							img_block[row+1][col+1] = 0;
						} else {
							img_block[row+1][col+1] = img[i*32+row][j*32+col];
						}
					}
				}
			}

			// send part of the image to sobel and result in edge_block
		    	XTime_GetTime((XTime *) &tStart_sw);
			if(DETECTOR==SOBEL)
				sobel_filter(img_block,edge_block);
			else
				roberts_filter(img_block,edge_block);
		
			XTime_GetTime((XTime *) &tEnd_sw);

			// tiling of filtered parts
			for(row=0;row<32;row++){
				for(col=0;col<32;col++){
					edge_sw[i*32+row][j*32+col] = edge_block[row][col];
				}
			}

		}
	}

	printf("end sobel in software\n");

	ElapsedTime_sw = (((tEnd_sw - tStart_sw)*1000000000) / (COUNTS_PER_SECOND));

	#ifdef EXPORT_RESULT
	char str1[10] = "outpSW";
	create_python(edge_sw, &str1[0]);
	#endif

//	// initialize monitor
//	initialize(322,0x0,0xFFFFFFFF);
//
//	//start monitor
//	start_monitor(290);

    /* Cycle to divide the image in 34*34 blocks
     * and send them to HW acc*/
    //Xil_DCacheFlush();
	printf("out from cycle size data in %d\n\r", size_datain);
	printf("out from cycle size image sobel %d\n\r", size_image_sobel[0]);

   	printf("\nStarting Sobel hardware...\n");
    for(i=0;i<16; i++){
    	for(j=0;j<16; j++){
    		for(row=-1;row<=SIZE-2+offset;row++){
    			for(col=-1;col<=SIZE-2+offset;col++){
    				if((i)==0 && row ==-1){
    					datain[(row+1)*(32+offset) +(col+1)] = 0;
    				} else if((i)==15 && row==32){
    					datain[(row+1)*(32+offset) +(col+1)] = 0;
    				} else {
    					if((j)==0 && col ==-1){
    						datain[(row+1)*(32+offset) +(col+1)] = 0;
    					}  else if((j)==15 && col==32){
    						datain[(row+1)*(32+offset) +(col+1)] = 0;
    					} else {
    						datain[(row+1)*(32+offset) +(col+1)] = img[(i)*32+row][(j)*32+col];
    					}
    				}
    			}
    		}

    		// send image of size (SIZE+2)(SIZE+2)
    		// to hardware sobel, by passing:
    	   	// ( output_array_size, output_array,
    	   	// input_array_size, input_array,
    	   	// side_array_size, side_variable)

			#if defined MON2 || defined MON2_3
    	    *(config + 5) = 0xFFFFFFFF;
    	    *(config + 5) = 0;
			#endif

			printf("size data in %d\n\r", size_datain);
			printf("size image sobel %d\n\r", size_image_sobel[0]);

		if(DETECTOR==SOBEL){

    	   	       mm_accelerator_sobel(
    	   	       	// port out_pel
    	   	    	size_dataout, dataout,
    	   	       	// port in_pel
    				size_datain, datain,
    	   	       	// port in_size
    	   	       	1, size_image_sobel
					);
		}
		else {
			mm_accelerator_roberts(
    	   	       	// port out_pel
    	   	    	size_dataout, dataout,
    	   	       	// port in_pel
    				size_datain, datain,
    	   	       	// port in_size
    	   	       	1, size_image_sobel
					);
		}

    				// tiling
    	   	       for(row=0;row<32;row++){
    	   	    	   for(col=0;col<32;col++){
    	   	    		   edge_hw[i*32+row][j*32+col] = dataout[row*32+col];
    	   	    	   }
    	   	       }
    	}
    }

	printf("end sobel in hardware \n");

//	// end monitor
//	stop_monitor(258);
//
//
//	//print monitor 1,2 and 3rd leve
//	print_monitor();

	// check results
	int count = 0;

//	for(row=0;row<32;row++){
//		for(col=0;col<32;col++){
//			if ((edge_sw[row][col] =! edge_hw[row][col]))
//				count++;
//		}
//	}
//
//	printf ("diff is %d", count);

	#ifdef EXPORT_RESULT
	char str2[10] = "outpHW";
   	create_python(edge_hw, &str2[0]);
	#endif

	printf("\nEnd Sobel...\n");
   	printf("time of sobel in sw %llu \n", ElapsedTime_sw);

   	#ifdef MON2
   	printf(" Monitor 2nd level result is %d \n\r", *(config + 6));
	#endif

	#ifdef MON2_3
   	printf(" Monitor 2nd level result is %d \n\r", *(config + 6));
   	printf(" Monitor 3rd level result is %x \n\r", *(config + 7));
	#endif

   	cleanup_platform();
    return 0;
}
