# gpu-programming-journal

N days of GPU programming

Inspired by this [repository](https://github.com/julienokumu/100DaysOfGPUProgramming)

# What, Why, How?

I am interested in game dev, and anytime I need to use/create shaders I feel a bit lost. At the same time, every time the result is satisfying, and it makes me want to learn more about the topic. Ironically, there won't be much shader programming here, I am not exactly sure where this will lead. So far my _rough_ plan is:

0. Learn the basics of GPU programming  
   Mostly start with reading this [book](https://www.amazon.com/Programming-Massively-Parallel-Processors-Hands/dp/0323912311) and this [guide](https://docs.nvidia.com/cuda/cuda-c-programming-guide/contents.html) (also recommended by the same [person](https://x.com/sadernoheart/status/1976364231332397425)).

1. Learn visual shaders  
   Lighting, post-processing shaders, ...

2. Learn simulations  
   Fluid simulations

3. Learn AI & related compute  
   Tensor operations, PyTorch, ...

This may be too much content, and I might cut parts out, or spend more time on other parts. We'll see how it goes.

<!-- may follow the daily structure of (1) what I learn, (2) challenges faced, (3) observations & thoughts -->

## Day 0

Read Chapter 1 of the PMPP book. Takeaways:

-   Both CPUs and GPUs have been increasing their number of cores. GPUs have a lot more cores, use more energy, and have a larger focus on multi-threaded parallel programming.
-   GPUs shine in video-games (require massive amounts of floating point operations), but there are still operations where CPUs are faster. Due to this, most processes either prefer the CPU or the GPU, usually not both.
-   The CUDA programming model is unique because it supports "join CPU/GPU execution".
-   Interesting point: When developers are choosing processors they focus on large presence in the marketplace. Apps that will run on a processsor with small market share won't be used, therefore it won't be created. As GPUs became more mainstream, it allowed developers to create apps that would run on the GPU.
-   Initially it wasn't easy to program on the GPU since you dependend on APIs (OpenGL, Direct3D, etc.). But CUDA allowed interacting without using APIs, while using languages that people are familiar with (C/C++).

I want to write _at least some code_ for each day. So I will try to run any script that would run on the GPU. I have been reading on my mac, and turns out I can't run CUDA (`.cu`) files on here, I will write a script that uses Metal for today.

First tried to run simple Metal code, but now I think it is wasteful to try to learn that. Instead I will use the [LeetGPU Playground](https://leetgpu.com/playground).

The playground does come with a "starter" script, so I will try to understand what happens in there.

### What did I learn?

-   Basic differences between CPU & GPU. GPUs are meant for highly parallel but simple mathmetical operations. Multi-threaded and parallelism are key.
-   CUDA lets you write code that run on both CPU & GPU, the unique part is it lets you interface with the GPU without an API.
-   (This might sound dumb later but) It seems like CUDA scripts are meant to (1) use your CPU to instruct the GPU, (2) the GPU copies over some data, or does some simple operation (but a lot of them...), (3) then sends the results back to the CPU.

### TODO:

-   Found this [CUDA C++ coding video playlist](https://www.youtube.com/playlist?list=PL5B692fm6--vWLhYPqLcEu6RF3hXjEyJr), might be worth checking out.
