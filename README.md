# 32-bit Single-Cycle RISC-V Processor
 **Implementation of RV32I Architecture on Basys-3 FPGA**

---

### Team Members
* **Ayaan Niazi**
* **Tooba Zehra**
* **Ayub Ansari**

---

## Project Overview
We built a 32-bit single-cycle RISC-V processor on a Basys-3 FPGA. It implements the RV32I instruction set and executes every instruction in exactly one clock cycle. 

The Basys-3 board runs at 100 MHz, we divide the clock down to **10 MHz** for the processor logic to ensure signals remain stable and visible on the hardware. The 7-segment display multiplexer remains at 100 MHz to eliminate flickering.

## Architecture & Datapath
The datapath follows a standard textbook single-cycle design:
1. **Instruction Fetch:** The Program Counter (PC) fetches an instruction from memory.
2. **Decode:** The control unit decodes the opcode and sets all necessary signals.
3. **Execute:** The register file and ALU perform the computation.
4. **Memory Access:** Load instructions read from data memory; store instructions write to it.
5. **Write-Back:** The result is written back to the register file.

## Memory-Mapped I/O (MMIO)
We utilize memory-mapped I/O to interact with the FPGA's peripherals. A standard store instruction to these specific addresses writes to the peripheral instead of data memory:

| Peripheral | Memory Address |
| :--- | :--- |
| **LEDs** | `0x100` |
| **Switches** | `0x200` |
| **7-Segment Display** | `0x300` |

## How to Run the Program
 
To run different tasks on your RISC-V processor, follow these steps to configure the instruction memory and simulation environment.
 
### 1. Configure Instruction Memory
1. Open `instruction_memory.v`.
2. Locate the `$readmemh` line:
   ```verilog
   $readmemh("TaskC.mem", memory); // Loading instructions from a file
   ```
3. Change the filename inside the quotes to the desired task file.
### 2. File Compatibility
Ensure you select the appropriate memory file based on your environment:
 
| Task | FPGA-Compatible Files | Simulation-Only Files |
| :--- | :--- | :--- |
| Task A | `TaskA.mem` | `TaskA_sim.mem` |
| Task B | `TaskB.mem` | `TaskB_sim.mem` |
| Task C | `TaskC.mem` | Compatible with both |
 
> **Note:** Always ensure the corresponding testbench is set as the **Top Module** in your Simulation Sources.
 
### 3. Simulation Settings
If you are running a simulation, update the runtime settings:
1. In the Flow Navigator, right-click **Simulation Settings**.
2. Navigate to the **Simulation** tab.
3. Set `xsim.simulate.runtime` to `15ms`.
### 4. Clock Divider Adjustment
For hardware execution on the FPGA, match the clock divider to the task requirements in your top-level module:
 
* **Task A & B:** Use `DIVIDE_BY(50_000_000)`
* **Task C:** Use `DIVIDE_BY(100)`
