# Concurrent Flight Control System (Ada)

## Overview

This project is a simulation of a real-time flight control system implemented in Ada. It models key components of an aircraft’s control architecture, including sensor input, fault-tolerant data processing, autopilot logic, and persistent logging.

The system leverages Ada’s concurrency features (tasks and protected objects) to simulate parallel subsystems interacting through shared state in a thread-safe manner.

---

## Features

### Multi-Threaded Architecture

* Independent Ada tasks simulate:

  * 5 altitude sensors
  * Autopilot controller
  * Flight dynamics (altitude, velocity)
  * Coordinate updates (navigation)
  * Logging subsystems
* Tasks run concurrently and interact through a synchronized shared state.

### Fault-Tolerant Sensor Fusion

* Implements a voting system across 5 simulated sensors
* Detects and rejects outliers using threshold-based logic
* Produces a reliable “voted altitude” used by the autopilot

### Autopilot System

* Phase-based flight control:

  * Grounded → Takeoff → Climb → Cruise → Descent → Landing
* Dynamically adjusts engine power based on:

  * Altitude error
  * Flight phase
  * Distance to destination

### Navigation & Movement

* Simulates aircraft movement using trigonometric calculations
* Updates latitude/longitude toward a randomly generated destination
* Velocity-dependent position updates

### Dual Black Box Logging

* **CSV Logger (`data.csv`)**

  * Human-readable flight data
  * Useful for debugging and visualization

* **Binary Logger (`data.dat`)**

  * Efficient binary format for structured querying
  * Mimics real-world flight data recorders

### Thread-Safe Shared State

* Centralized `Flight_Data` protected object:

  * Ensures safe concurrent reads/writes
  * Stores all flight state (altitude, velocity, sensors, phase, etc.)

---

## Technologies

* Ada (GNAT toolchain)
* Alire (package/build manager)
* Concurrency: Tasks & Protected Objects

---

## Project Structure

```
flight-simulator/
│
├── src/
│   ├── flight_controller.adb
│   ├── flight_logic.ads
│   ├── flight_logic.adb
│
├── alire.toml
├── flight_simulator.gpr
├── README.md
└── .gitignore
```

---

## How to Build and Run

Make sure you have Alire installed.

```bash
alr build
alr run
```

---

## Example Output

During execution, the system prints:

* Flight phase
* Altitude (raw and voted)
* Velocity
* Power level
* Coordinates

It also generates:

* `data.csv` → human-readable logs
* `data.dat` → binary logs for efficient processing

---

## Key Concepts Demonstrated

* Concurrent programming in Ada
* Fault-tolerant system design
* Real-time simulation
* Data logging (text vs binary formats)
* Encapsulation with protected objects
* Basic flight dynamics modeling

---

## Future Improvements

* Modularize tasks into separate packages
* Add visualization for flight path (e.g., plotting CSV data)
* Introduce more realistic physics (lift, drag, fuel consumption)
* Expand binary log querying tools
