## GPU是什么？
GPU（Graphics Processing Unit，图形处理单元）是一种专用的处理器，用于处理图形和图像数据。它最初被设计用于加速图形渲染，提高计算机游戏和图形应用程序的性能。它在游戏、电影制作、虚拟现实（VR）和增强现实（AR）等领域发挥着重要作用。随着时间的推移，人们发现GPU也可以用于处理其他类型的计算任务，特别是需要大量并行计算的任务，例如科学模拟、深度学习、密码学等。

与传统的中央处理器（CPU）不同，GPU 的设计更加专注于并行处理。它包含大量的小处理单元，可以同时执行多个任务，特别适合处理需要大量并行计算的应用程序。在深度学习和人工智能领域，GPU 的并行计算能力被广泛应用于加速神经网络的训练和推断过程，使得这些任务可以更快地完成。

如下图中矩阵相乘的计算中，可以理解为5个元素相乘的操作分别由5个处理单元同时进行。

![矩阵乘MM计算](/assets/images/20231103104923.jpg)

CPU（中央处理器）的处理单元数量通常以“核心”来表示。每个CPU核心都可以独立地执行指令，因此它们可以被认为是处理单元。现代的CPU可以具有单核、双核、四核、六核、八核，甚至更多核心，取决于制造商和型号。


GPU和显卡不是同一个东西，显卡不仅包括GPU，还有一些显存、VRM稳压模块、MRAM芯片、总线、风扇、外围设备接口等等。


## GPU vs CPU
矩阵相乘是一个常见的计算密集型任务，适合用来比较CPU和GPU的计算性能和并行处理能力。让我们以矩阵相乘为例，对比说明CPU和GPU计算的不同，解释它们的并行处理差异。

### CPU计算矩阵相乘：

在CPU上进行矩阵相乘通常采用基本的循环嵌套方法。例如，对于两个矩阵 A 和 B 的相乘，可以使用以下的伪代码来表示：

```python
for i from 0 to N:
    for j from 0 to N:
        C[i][j] = 0
        for k from 0 to N:
            C[i][j] += A[i][k] * B[k][j]
```

在这种方法下，计算是按顺序进行的，每一步的结果都依赖于前一步的计算结果。这种方式难以实现高度的并行化，因为每次计算都依赖于前一次的结果。在CPU上，通常会利用指令级并行（ILP，Instruction-Level Parallelism）和流水线技术来提高性能，但是这些技术有限制，无法完全发挥大规模并行计算的优势。

### GPU计算矩阵相乘：

在GPU上，矩阵相乘可以高度并行化执行。GPU内部有大量的小处理单元（CUDA核心或流处理器），每个处理单元可以独立地执行乘法和累加操作。对于矩阵相乘，可以将矩阵的每个元素的乘法和累加操作分配给不同的处理单元，从而实现高度的并行计算。这种并行计算方式称为数据并行性。

例如，对于两个矩阵 A 和 B 的相乘，在GPU上可以将每个元素的计算分配给一个不同的处理单元，形成一个大规模的并行计算：

```python
// 在GPU上的并行计算
global_id_x = 获取当前线程的横坐标
global_id_y = 获取当前线程的纵坐标

C[global_id_x][global_id_y] = 0
for k from 0 to N:
    C[global_id_x][global_id_y] += A[global_id_x][k] * B[k][global_id_y]
```

在GPU上，这些并行计算可以在同一时刻进行，大大提高了矩阵相乘的计算速度。

综上所述，GPU通过大规模的并行计算单元和数据并行性，能够高效地执行矩阵相乘等计算密集型任务，而CPU则在ILP和流水线等技术的辅助下，提高了单个核心的性能，但相对于GPU，在处理大规模并行任务时性能有限。

### 结构组成
CPU和GPU都是运算的处理器，在架构组成上都包括3个部分：运算单元ALU、控制单元Control和缓存单元Cache。

芯片内部的面积比例上看:

- 在CPU中缓存单元大概占50%，控制单元25%，运算单元25%

- 在GPU中缓存单元大概占5%，控制单元5%，运算单元90%

![GPU vs CPU](/assets/images/gpu-vs-cpu.png)

以Hopper架构为例自顶向下介绍一下GPU

[![GPU vs CPU](/assets/images/Hopper-H100.png)](/assets/images/Hopper-H100.png)

1. GPC(Graphics Processing Clusters)：GPC负责处理图形渲染和计算任务。每个GPC包含多个TPC，以及与其相关的专用硬件单元和缓存。

2. TPC(Texture Processing Clusters)：TPC负责执行纹理采样和滤波操作，以从纹理数据中获取采样值，并应用于图形渲染中的相应像素。在CUDA计算中，每个TPC有两个SM处理计算任务。

3. HBM（High-Bandwidth Memory）：HBM是高带宽内存，也就是我们常说的显存。它通过将内存芯片直接堆叠在逻辑芯片上，提供了极高的带宽和更低的能耗，从而实现了高密度和高带宽的数据传输。

4. L2 Cache：L2 Cache是GPU中更大容量的高速缓存层，它位于多个流多处理器（SM）之间共享。L2 Cache还可以用于协调SM之间的数据共享和通信。

#### H100 SM 架构

[![GH100 streaming multiprocessor](/assets/images/H100-Streaming-Multiprocessor-SM-1104x1536.png)](/assets/images/H100-Streaming-Multiprocessor-SM-1104x1536.png)

1. SM(Streaming Multiprocessor)：SM是GPU的主要计算单元，负责执行并行计算任务。每个SM都包含多个流多处理器（CUDA核心），可以同时执行多个线程块中的指令。SM通过分配线程、调度指令和管理内存等操作，实现高效的并行计算。
2. WARP(Wavefront Parallelism)：WARP指的是一组同时执行的Thread。一个Warp 包含32个并行Thread，这32个Thread 执行于SIMT模式。也就是说所有Thread 以锁步的方式执行同一条指令，但每个Thread会使用各自的Data 执行指令分支。
3. Dispatch Unit：从指令队列中获取和解码指令，协调指令的执行和调度，将其分派给适当的执行单元，以实现高效的并行计算。
4. L1 Cache/SMEM：L1 Cache包含指令缓存(Instruction Cache)和数据缓存（Data Cache），在SM内部存储最常用的指令和数据，每个SM独享一个L1 Cache，提供低延迟和高带宽的访问。
5. Register File: 用于存储临时数据、计算中间结果和变量。离计算单元最近，访问速度非常快。
6. SFU(Special Function Unit)：SFU在GPU中用于加速特定类型的计算操作。如三角函数等。





