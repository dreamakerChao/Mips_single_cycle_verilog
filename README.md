# Mips_single_cycle_verilog
A simple implement Mips processer in verilog

Below are a circuit structure look like (picture from https://cseweb.ucsd.edu/~j2lau/cs141/single_cycle_cpu_datapath.png).

<div style="text-align:center;">
    <img src="https://cseweb.ucsd.edu/~j2lau/cs141/single_cycle_cpu_datapath.png" alt="Factorial Test Wave" />
</div>


## factorial program
This program use $a0 as argument of factorial, and the result in $v0
souce code from : https://blueskyson.github.io/2020/04/05/mips-factorial-and-fibonacii/

<div style="text-align:center;">
    <img src="https://github.com/dreamakerChao/Mips_single_cycle_verilog/blob/main/test_result_pic/factorial_test_wave.png" alt="Factorial Test Wave" />
</div>

<div style="text-align:center;">
    <img src="https://github.com/dreamakerChao/Mips_single_cycle_verilog/blob/main/test_result_pic/factorial_test_inst_mem.png" alt="Factorial Test Instruction Memory" />
</div>

<div style="text-align:center;">
    <img src="https://github.com/dreamakerChao/Mips_single_cycle_verilog/blob/main/test_result_pic/factorial_test_regarray.png" alt="Factorial Test Register Array" />
</div>

<div style="text-align:center;">
    <img src="https://github.com/dreamakerChao/Mips_single_cycle_verilog/blob/main/test_result_pic/factorial_test_data_mem.png" alt="Factorial Test Data Memory" />
</div>


## Hello world program
This program can read the string "\nHello World!\n" in top of the data_memory and add the ascii code 1 and then store in data_memory from 1st -14st byte place.

<div style="text-align:center; display:inline-block; margin-right:20px;">
    <img src="https://github.com/dreamakerChao/Mips_single_cycle_verilog/blob/main/test_result_pic/helloworld_test_wave.png" alt="Hello World Test Wave" style="max-width:100%; height:auto;"/>
</div>

<div style="text-align:center; display:inline-block; margin-right:20px;">
    <img src="https://github.com/dreamakerChao/Mips_single_cycle_verilog/blob/main/test_result_pic/helloworld_inst_mem.png" alt="Hello World Test Instruction Memory" />
</div>

<div style="text-align:center; display:inline-block; margin-right:20px;">
    <img src="https://github.com/dreamakerChao/Mips_single_cycle_verilog/blob/main/test_result_pic/hello_world_test_regarray.png" alt="Hello World Test Register Array" />
</div>

<div style="text-align:center; display:inline-block; margin-right:20px;">
    <img src="https://github.com/dreamakerChao/Mips_single_cycle_verilog/blob/main/test_result_pic/hello_world_test_data_mem1.png" alt="Hello World Test Data Memory 1" />
</div>

<div style="text-align:center; display:inline-block; margin-right:20px;">
    <img src="https://github.com/dreamakerChao/Mips_single_cycle_verilog/blob/main/test_result_pic/hello_world_test_data_mem2.png" alt="Hello World Test Data Memory 2" />
</div>


