# 32-bit-square-root-calculator
Algorithm: Non restoring square root extraction
This project implements a 32-bit square root calculator designed using Verilog. It takes a 32-bit unsigned integer as input and returns its square root as a 16-bit result. The design is optimized for digital hardware, suitable for integration into larger FPGA or ASIC systems.

🧠 Features
Accepts a 32-bit unsigned integer as input.

Outputs a 16-bit integer square root (no decimal).

Designed using combinational and/or sequential logic.

Testbench included for verification with various test cases.

📁 Project Structure
```
├── src/
│   ├── sqrt_calculator.v         # Main module
│   └── sqrt_calculator_tb.v      # Testbench for simulation
├── README.md
```
⚙️ How It Works
The calculator uses a non-restoring algorithm or binary search method (depending on the design) to compute the square root efficiently in hardware. It iteratively evaluates the bits of the square root from MSB to LSB.

🧪 Testbench
The testbench verifies correctness for a range of values:

Edge cases like 0 and 1

Perfect squares (e.g., 4, 9, 16, 25)

Non-perfect squares

Maximum input value (32'hFFFFFFFF)

🔧 Requirements
Verilog simulation tool (ModelSim, Icarus Verilog, etc.)

Optional: FPGA development board for hardware implementation

📌 Applications
Embedded digital math processors

Signal processing units

Scientific and engineering calculators

Hardware-accelerated algorithms
