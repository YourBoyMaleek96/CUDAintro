# CUDA Device Properties Program

This program retrieves and displays detailed properties of CUDA-capable devices on your system. It handles cases with 0, 1, or multiple devices and uses proper error checking for CUDA API calls.

## Prerequisites

- NVIDIA GPU with CUDA support.
- CUDA Toolkit installed (ensure `nvcc` is available in your system PATH).
- Compatible GPU drivers installed.

## How to Compile

1. Open a terminal or command prompt.
2. Navigate to the directory containing the `device_properties.cu` file.
3. Run the following command to compile the program:
   ```bash
   nvcc device_properties.cu -o device_properties
