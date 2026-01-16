# Advent of FPGA 2025

A Jane Street challenge: \
https://blog.janestreet.com/advent-of-fpga-challenge-2025/

Written in Hardcaml \
Docs: https://www.janestreet.com/web-app/hardcaml-docs/introduction/why

Targeting AMD Artix 7 FPGA (XC7A50T-1FGG484C)

| | |
|---|---|
| **Logic Cells** | 52K |
| **LUTs / FFs** | 32.6K / 65.2K |
| **Block RAM** | 2.7 Mb (75× 36Kb) |
| **DSP Slices** | 120 (25×18 MAC) |
| **User I/O** | 250 |
| **GTP Transceivers** | 4 (up to 3.75 Gb/s) |
| **PCIe** | Gen2 ×4 |

### Day 7 - Bridge Repair | [day07.ml](day07/src/day07.ml)

The solution processes a 2D grid stream to determine bridge connectivity. To handle the vertical dependencies inherent in grid navigation without the high resource cost of a full frame buffer, the design utilizes a **Circular Buffer** to create a configurable delay line.

For each incoming byte, the hardware maintains a sliding window of the current and preceding characters. To check the neighbor in the row directly above, the design feeds the previous row's results into a circular buffer implemented using **Block RAM**. The buffer's delay is set to match the grid's row width (e.g., 141 cycles), ensuring that the neighbor from the row above is read out at the exact moment the current character's column is processed.



The core logic uses parallel combinational paths to evaluate neighbors (left, right, and above) and update path counts. These results are accumulated into 64-bit registers to provide the final answers for Part 1 and Part 2. By using a single-cycle-per-character architecture, the design achieves high throughput limited only by the FPGA's clock frequency.

| Area (LUTs) | Latency (ns) | Freq (MHz) | Power (W) | Cycles/Char | Throughput (Ch/s) | Completion (us) |
|------------:|-------------:|-----------:|----------:|------------:|------------------:|----------------:|
| 178 (0.55%) | 10.000       | 100.00     | -         | 1           | 100M              | 204.62          |


#### Hardware Utilization
* **Logic**: The core algorithm is highly optimized, requiring only **178 LUTs** (0.55% utilization).
* **Memory**: **5.5 Block RAM Tiles** (7.33% utilization) are used to implement the row-to-row delay lines.
* **Registers**: **272 Slice Registers** manage the pipeline stages and 64-bit accumulators for the puzzle results.
* **I/O**: **140 Bonded IOBs** are utilized, primarily for the 64-bit results and 8-bit streaming input.