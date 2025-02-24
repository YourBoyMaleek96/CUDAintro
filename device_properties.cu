/*************************************************************************************************************************
* Name: Malik Freeman
* Date: 2/16/2025
* Course: SSE 662 - Design, Maintenance, and Quality
* Assignment: Module 3 Programming Task
* File Name: device_properties.cu
* Description: This file implements a program that retrieves and prints the properties of each available CUDA device.
*              The program uses the CUDA Runtime API to query the number of CUDA devices available on the system and
*              then retrieves the properties of each device. The program prints the device name, compute capability,
*              number of multiprocessors, maximum threads per multiprocessor, maximum threads per block, and clock rate
*              for each device. The program also handles the special case of devices with compute capability (9999, 9999).
*              The program uses the cudasafe function to check CUDA API call results and handle errors.
*
*************************************************************************************************************************/



#include <cuda.h>
#include <stdio.h>
#include <stdlib.h>
// Helper function to check CUDA API call results and handle errors
void cudasafe(cudaError_t error, const char* message, const char* file, int line) {
    if (error != cudaSuccess) {
        fprintf(stderr, "CUDA Error: %s : %i. In %s line %d\n", message, error, file, line); 
        exit(-1);
    }
}

int main(int argc, char ** argv) {
    int deviceCount; 

    // Check the number of CUDA devices available
    cudasafe(cudaGetDeviceCount(&deviceCount), "cudaGetDeviceCount", __FILE__, __LINE__); 

    printf("Number of CUDA devices: %d.\n", deviceCount); 

    // Handle the case of no CUDA devices
    if (deviceCount == 0) {
        printf("No CUDA devices found.\n");
        return -1;
    }

    // Loop through each available device and retrieve its properties
    for (int dev = 0; dev < deviceCount; dev++) {
        cudaDeviceProp deviceProp;

        // Retrieve device properties for each CUDA device
        cudasafe(cudaGetDeviceProperties(&deviceProp, dev), "cudaGetDeviceProperties", __FILE__, __LINE__);

        // Print detailed properties for the current device
        printf("\nFor device #%d:\n", dev); 
        printf("Device name:                %s\n", deviceProp.name); 
        printf("Compute capability (major): %d\n", deviceProp.major);
        printf("Compute capability (minor): %d\n", deviceProp.minor);        
        printf("Number of multiprocessors:   %d\n", deviceProp.multiProcessorCount);
        printf("Max threads per multiprocessor: %d\n", deviceProp.maxThreadsPerMultiProcessor);
        printf("Max threads per block:      %d\n", deviceProp.maxThreadsPerBlock);
        printf("Clock rate (kHz):           %d\n", deviceProp.clockRate);

        // Handle special case for devices with compute capability (9999, 9999)
        if (deviceProp.major == 9999 && deviceProp.minor == 9999) {
            printf("This device has an unknown compute capability.\n");
        }
    }

    // Pause the system to allow user to see output before exiting (for Windows)
    system("pause");
    return 0;
}
