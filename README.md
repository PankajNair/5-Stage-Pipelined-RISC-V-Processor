# 5 Stage Pipelined RISC-V Processor
My implementation of a 5-stage pipelined RV32IM processor based on the Textbook - Digital Design and Computer Architecture: RISC-V Edition by Sarah Harris and David Harris.

## Features
* 32-bit Instruction Format
* 5 Stage Pipeline Design
* Implemented 41 instructions for the RV32IM core 
* Hazard Handling

## Hazard Handling
Occurs when an instruction depends on the results of the previous instruction which is not yet completed.

* Data Hazards

** Forwarding - Forward the result from the Memory Stage and the WriteBack stage to the Execute stage.
** Stalling - Used for Load instructions. Stalling the next instructions and forwarding the memory data from WriteBack stage as data read from memory is available only at the end of the clock cycle.

* Control Hazards

** Flushing - Used for Branch instructions. When taking a branch in the Execute stage, flush the next two instructions (Decode and Fetch Stages).
