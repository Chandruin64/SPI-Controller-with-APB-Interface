# SPI Controller with APB Interface — UVM Verification

## Overview

This project implements and verifies a configurable **SPI Controller with an APB interface** using **SystemVerilog and UVM**.

The APB interface is used for processor-style configuration and register access, while the SPI interface handles serial data communication with an external SPI device. The verification environment uses reusable UVM components, Register Abstraction Layer (RAL), constrained-random stimulus, functional coverage, and assertions to verify protocol and functional behavior.

## DUT Features

* APB-based register interface for configuration and data access
* SPI Master interface
* Configurable SPI clock generation
* Programmable CPOL and CPHA modes
* MSB-first and LSB-first data transfer
* TX/RX shift registers
* Slave-select control
* Interrupt generation
* Low-power/idle behavior
* Configurable SPI transfer parameters

## Verification Environment

The testbench is developed using a layered UVM architecture with separate APB and SPI agents.

```text
                              +----------------------+
                              |       UVM TEST       |
                              +----------+-----------+
                                         |
                                         v
                    +-------------------------------------------+
                    |                ENVIRONMENT                |
                    |                                           |
                    |  +------------------+  +----------------+ |
                    |  | Virtual          | | Register Model  | |
                    |  | Sequencer        | |     (RAL)       | |
                    |  +------------------+  +----------------+ |
                    |                                           |
                    |              +------------------+         |
                    |              |    Scoreboard    |         |
                    |              |                  |         |
                    |              |     APB FIFO     |         |
                    |              |     SPI FIFO     |         |
                    |              |        |         |         |
                    |              |     Compare      |         |
                    |              +------------------+         |
                    +------------------+------------------------+
                                       |
                     +-----------------+-----------------+
                     |                                   |
                     v                                   v
            +-------------------+               +-------------------+
            |     APB AGENT     |               |     SPI AGENT     |
            |                   |               |                   |
            |     Sequencer     |               |     Sequencer     |
            |        |          |               |        |          |
            |      Driver       |               |      Driver       |
            |        |          |               |        |          |
            |      Monitor      |               |      Monitor      |
            +---------+---------+               +---------+---------+
                      |                                   |
                      +-----------------+-----------------+
                                        |
                                        v
                 +------------------------------------------------+
                 |                      DUT                       |
                 |                                                |
                 |               SPI Controller                   |
                 |                                                |
                 |                                                |
                 +------------------------------------------------+

```

## Testbench Components

### APB Agent

The APB agent drives and monitors APB transactions used to configure and access the SPI controller.

**Components:**

* APB Sequencer
* APB Driver
* APB Monitor
* APB Transaction
* APB Sequences

### SPI Agent

The SPI agent generates and monitors SPI-side transactions for verifying serial communication.

**Components:**

* SPI Sequencer
* SPI Driver
* SPI Monitor
* SPI Transaction
* SPI Sequences

### Virtual Sequencer

The virtual sequencer coordinates APB and SPI sequences when stimulus needs to be synchronized across both interfaces.

Virtual sequences are used to control transactions through the APB and SPI sequencers from a common test-level sequence.

### Register Model

A UVM RAL-based register model is implemented to provide an abstract representation of the DUT's programmable registers.

The register model is built and connected to the verification environment during the testbench configuration phase.

### Scoreboard

The scoreboard receives transactions from the APB and SPI monitors through analysis connections and performs self-checking comparisons to verify expected DUT behavior.

### Assertions

SystemVerilog Assertions are used at the interface level to check protocol-related conditions and identify invalid behavior during simulation.

### Functional Coverage

Functional coverage is used to measure verification progress across important SPI configurations and scenarios, including:

* CPOL configurations
* CPHA configurations
* MSB-first / LSB-first operation
* SPI transfer configurations
* APB register accesses
* Cross coverage of SPI operating modes

## Test Scenarios

The test suite covers all four standard SPI operating modes in both MSB-first and LSB-first configurations.

| Test                      | CPOL | CPHA | Bit Order |
| ------------------------- | ---: | ---: | --------- |
| `cpol0_cpha0_lsbfe0_test` |    0 |    0 | MSB-first |
| `cpol0_cpha1_lsbfe0_test` |    0 |    1 | MSB-first |
| `cpol1_cpha0_lsbfe0_test` |    1 |    0 | MSB-first |
| `cpol1_cpha1_lsbfe0_test` |    1 |    1 | MSB-first |
| `cpol0_cpha0_lsbfe1_test` |    0 |    0 | LSB-first |
| `cpol0_cpha1_lsbfe1_test` |    0 |    1 | LSB-first |
| `cpol1_cpha0_lsbfe1_test` |    1 |    0 | LSB-first |
| `cpol1_cpha1_lsbfe1_test` |    1 |    1 | LSB-first |

Additional tests are included for:

* Low-power behavior
* APB register readback
* Status checking
* Virtual-sequence based verification

The virtual test variants use the environment's virtual sequencer to coordinate APB and SPI activity.

## UVM Test Flow

```text
Test
 |
 +--> Configure Environment
 |      |
 |      +--> APB Agent Configuration
 |      +--> SPI Agent Configuration
 |      +--> Register Model
 |
 +--> Start APB Sequence
 |
 +--> Start SPI Sequence
 |
 +--> DUT Processes APB/SPI Transactions
 |
 +--> Monitors Capture Activity
 |
 +--> Scoreboard Checks Results
 |
 +--> Functional Coverage Updated
 |
 +--> Assertions Check Protocol Behavior
 |
 +--> Test Completes
```

## Project Structure

```text
SPI_Controller/
│
├── rtl/
│   ├── apb_intf.sv
│   ├── apb_slave.sv
│   ├── baud_generator.sv
│   ├── shifter.sv
│   ├── spi_core.sv
│   ├── spi_intf.sv
│   ├── spi_slave_select.sv
│   └── spi.s
│
├── test/
│   ├── test.sv
│   └── pkg.sv
│
├── apb_agent/
│   ├── apb_config.sv
│   ├── apb_xtn.sv
│   ├── apb_seqs.sv
│   ├── apb_driver.sv
│   ├── apb_monitor.sv
│   ├── apb_sequencer.sv
│   ├── apb_agent.sv
│   └── apb_agt_top.sv
│
├── spi_agent/
│   ├── spi_config.sv
│   ├── spi_xtn.sv
│   ├── spi_seqs.sv
│   ├── spi_driver.sv
│   ├── spi_monitor.sv
│   ├── spi_sequencer.sv
│   ├── spi_agent.sv
│   └── spi_agt_top.sv
│
├── test/
│   ├── reg.sv
│   ├── reg_block.sv
│   ├── env_config.sv
│   ├── virtual_sequencer.sv
│   ├── virtual_seqs.sv
│   ├── scoreboard.sv
│   └── env.sv
│
└── sim/
    └── Makefile
```

## Simulation

The project supports simulation using:

* **Siemens QuestaSim**
* **Synopsys VCS**

The Makefile provides commands for compilation, individual test execution, waveform viewing, regression, and coverage reporting.

### QuestaSim

Compile the testbench:

```bash
make sv_cmp
```

Run an individual test:

```bash
make run_test
```

Run the complete regression:

```bash
make regress
```

Generate the merged coverage report:

```bash
make report
```

Open the coverage report:

```bash
make cov
```

### VCS

Compile the testbench:

```bash
make sv_cmp
```

Run an individual test:

```bash
make run_test
```

Run the complete regression:

```bash
make regress
```

Generate the merged coverage report:

```bash
make report
```

## Verification Methodology

The verification environment combines multiple UVM and SystemVerilog verification techniques:

* **UVM-based layered testbench architecture**
* **Constrained-random stimulus**
* **APB protocol verification**
* **SPI protocol verification**
* **Virtual sequences for multi-interface coordination**
* **UVM Register Abstraction Layer (RAL)**
* **Self-checking scoreboard**
* **SystemVerilog Assertions**
* **Functional coverage and cross coverage**
* **Directed configuration-based tests**
* **Low-power behavior verification**

## Key Verification Goals

The verification environment is designed to ensure:

1. Correct APB register access and configuration.
2. Correct SPI clock generation for different CPOL/CPHA combinations.
3. Correct serial data transmission and reception.
4. Correct MSB-first and LSB-first operation.
5. Correct interaction between APB configuration and SPI transfers.
6. Correct status and interrupt behavior.
7. Correct behavior during low-power/idle conditions.
8. Protocol violations are detected through assertions.
9. Functional scenarios are tracked through coverage.

## Tools and Technologies

* SystemVerilog
* UVM
* UVM RAL
* APB
* SPI
* SystemVerilog Assertions
* Functional Coverage
* QuestaSim
* Synopsys VCS
* Linux
* Makefile

## Author

**Chandirapriyan K**  
RTL Design | Design Verification

**Skills:** SystemVerilog, UVM, APB, SPI, RAL, SVA, Functional Coverage, Constrained-Random Verification, TLM, QuestaSim, Synopsys VCS, Linux
