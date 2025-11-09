//  input/output library to print stuff
//? GPUs can't really console log things, so in this script we copy a string from CPU to GPU, 
//? then a kernel runs to copy the data between constant & regular GPU memory,
//? then it is copied back to the CPU and print it.
#include <iostream>
// CUDA runtime library (for CUDA functions)
#include <cuda_runtime.h>

// Declares a constant memory array on the GPU
// Constant means memory is read-only for GPU threads. It resides in the fast-constant memory.
// The size is 20 bytes
__constant__ char d_message[20];

// Declaration of a CUDA kernel.
//? KERNEL - is a function that runs on the GPU.
// __global__ means it runs on the GPU but called from the CPU.
__global__ void welcome(char* msg) {
    // Calculates the thread index.
    // threadIdx.x → thread index inside the block.
    // blockIdx.x * blockDim.x → offset for the block.
    //? BLOCK - is a group of threads that can share data and synchronize
    int idx = blockIdx.x * blockDim.x + threadIdx.x;

    // Copies one character from constant memory (d_message) to device memory (msg) 
    // at the position corresponding to the thread index.
    msg[idx] = d_message[idx];
}

int main() {
    // pointer for device memory to hold the message.
    //? DEVICE - GPU and its memory
    char* d_msg;

    // pointer for host memory to receive the message from the GPU.
    //? HOST - CPU and its memory
    char* h_msg;

    // message on the host.
    const char message[] = "Welcome to LeetGPU!";

    // length, + 1 for the null terminator.
    const int length = strlen(message) + 1;

    // Allocate host and device memory
    //? malloc() - allocates memory on the host (CPU RAM)
    h_msg = (char*)malloc(length * sizeof(char));

    //? cudaMalloc() - allocates memory on the device (GPU RAM)
    cudaMalloc(&d_msg, length * sizeof(char));
    
    // Copy message to constant memory
    //? cudaMemcpy() - copies data between host & device memory
    //? cudaMemcpyToSymbol() - copies data from host to SYMBOL (constant -> __constant__) memory
    cudaMemcpyToSymbol(d_message, message, length);
    
    // Launch welcome kernel
    welcome<<<1, length>>>(d_msg);
    
    // Copy result back to host
    cudaMemcpy(h_msg, d_msg, length * sizeof(char), cudaMemcpyDeviceToHost);
    h_msg[length-1] = '\0';

    std::cout << h_msg << "\n";
    
    // Cleanup
    //? frees memory on the host & device memories
    free(h_msg);
    //? cudaFree() - this one is for the device (GPU)
    cudaFree(d_msg);
    
    return 0;
}
