# Design and Analysis of a Single Axis Capacitive Accelerometer Sensor for Range of Motion Applications  

## Abstract
This report presents the development and analysis of a single-axis capacitive accelerometer, designed for Range of Motion (ROM) monitoring in rehabilitation. The sensor is based on MEMS technology and operates with differential capacitance created by the displacement of a proof mass, changing the capacitances between electrodes. The sensor is designed to measure accelerations from **-4g to +4g** with a minimum bandwidth of **5 kHz**, ensuring high sensitivity and adaptability to low-frequency motion tracking.
**Keywords:** FEM, Linear Perturbation Analysis, Cadence Virtuoso, Reduced Order Modeling, Digital Twin, Therapy Monitoring.

A structured methodology was followed:  
- **Finite element simulations** in ANSYS Workbench to model mechanical and electrostatic behaviors.  
- **Modal and linear perturbation analyses** to confirm stable performance and avoid resonance.  
- **System-level integration** using Reduced Order Modeling (ROM) and Twin Builder.  
- **Analog circuit design** using Twin Builder and LTSpice for voltage conversion.  
- **Digital implementation** using Cadence Virtuoso to achieve 120 dB system gain.  
- **Voltage-controlled oscillator (VCO)** for real-time frequency measurement.  

This design enables **real-time, data-driven** monitoring and feedback, enhancing remote and personalized rehabilitation therapy.

---

## Table of Contents
1. [Introduction](#introduction)  
2. [Background](#background)  
3. [Reduced Order Modeling of the MEMS Device](#reduced-order-modeling-of-the-mems-device)  
   - [Simulation Outline](#simulation-outline)  
   - [Material Properties](#material-properties)  
   - [Geometry](#geometry)  
   - [Meshing](#meshing)  
   - [Test Load Simulation](#test-load-simulation)  
   - [Sensitivity Analysis](#sensitivity-analysis)  
   - [Modal Analysis](#modal-analysis)  
   - [ROM Generation and Usage](#rom-generation-and-usage)  
4. [Analog Circuit Design](#analog-circuit-design)  
5. [Digital Design](#digital-design)  
6. [Conclusion](#conclusion)  

---

## Introduction
Accelerometers are widely used in consumer electronics, automotive applications, and rehabilitation monitoring. Tracking the **range of motion (ROM)** is crucial in rehabilitation to prevent muscle and joint stiffness, restore flexibility, and improve therapy effectiveness. However, traditional ROM measurement methods are prone to **human error, inconsistency, and lack of real-time feedback**.  

This project aims to develop a **comprehensive system-level capacitive accelerometer** for accurate ROM monitoring, integrating:  
1. **Finite element modeling** in ANSYS for mechanical analysis.  
2. **Twin Builder simulations** for dynamic and circuit-level behavior.  
3. **Analog & digital circuit implementation** for robust data processing.  

---

## Background
The capacitive accelerometer operates on the **differential capacitance principle**, where the displacement of a proof mass alters the capacitance between fixed electrodes. The capacitance changes are governed by the equation:

$$
\
C = \frac{\varepsilon A}{d}
\
$$

where:  
- **C** is capacitance,  
- **ε** is permittivity,  
- **A** is the overlap area,  
- **d** is the distance between electrodes.

The proof mass displacement causes variations in **C1** and **C2**, leading to a net capacitance change:
For small displacements, the differential capacitance is given by:

$$
\Delta C = \frac{2\varepsilon A x}{d^2 - x^2}
$$

Using the **small displacement approximation**, we obtain the linearized capacitance equation:

$$
\Delta C = \frac{2\varepsilon A x}{d^2}
$$

The accelerometer's inertial response, based on **Hooke’s Law**, is given by:

$$
x = \frac{ma}{k}
$$

where:
- \( x \) is the displacement of the proof mass,
- \( m \) is the mass of the proof mass,
- \( a \) is the acceleration,
- \( k \) is the spring constant.
---
![Electrodes and Fingers as differential capacitors] (Digital Design - VCO and frequency counter/Differential_capacitance_DX.png)

## Reduced Order Modeling of the MEMS Device

### Simulation Outline
- **Finite Element Modeling (FEM):** ANSYS simulations for deflection under acceleration.  
- **Electrostatic Analysis:** Studying mechanical and electrostatic forces on the sensor.  
- **Modal Analysis:** Ensuring the sensor’s resonance frequency does not interfere with motion tracking.  
- **Linear Perturbation Analysis:** Handling real-world non-linearities.  
- **ROM Generation & Analysis:** Using ANSYS Twin Builder for efficient modeling.  

### Material Properties
| Property      | Polysilicon  | Air  |
|--------------|-------------|------|
| Density (kg/m³) | 2330 | 1.23 |
| Young’s Modulus (GPa) | 160 | 9.96E-11 |
| Poisson’s Ratio | 0.22 | 0 |

### Geometry
The sensor design includes:  
- **Proof mass:** 448 µm × 100 µm × 2 µm  
- **54 sensing fingers:** 4 µm width, 114 µm length  
- **Capacitance gap:** 1 µm  
- **Spring beams:** 210 µm length, 2 µm width  

---

## Analog Circuit Design
- **Capacitance-to-voltage conversion circuit** implemented in LTSpice.  
- **Amplifier design** using Cadence Virtuoso with 120 dB gain.  
- **Voltage-controlled oscillator (VCO)** for frequency-based output.  

### Key Specifications
| Parameter | Value |
|-----------|-------|
| Gain | 120 dB |
| Bandwidth | 5 MHz |
| Output Swing | 3.3V |
| Phase Margin | 30° |

---

## Digital Design
- **FPGA-based implementation** in VHDL.  
- **Frequency measurement using edge counters** for voltage-to-frequency conversion.  
- **Acceleration calculation circuit** based on measured frequency.  

### FPGA Resource Utilization
| Resource | Usage |
|----------|-------|
| Logic Elements | <1% |
| Registers | <1% |
| Total Pins | 37/347 (11%) |

---

## Conclusion
This project successfully designed a **capacitive MEMS accelerometer** for **range of motion monitoring** using **finite element analysis, reduced order modeling, analog/digital circuit design, and FPGA-based implementation**. The system achieves **real-time, high-sensitivity measurements**, ensuring effective rehabilitation monitoring.  

### Future Work:
- **Fabrication & experimental validation** of the designed sensor.  
- **Optimization for power efficiency & wireless communication integration.**  
- **Clinical trials to validate real-world effectiveness.**  

## Authors
**Ashutosh Sharma** BME, Hungary ; USN, Norway; Aalto University, Finland
   Email: ashutosh.iiitk@gmail.com


## Links
Slide Deck - 
MEMS Accelerometer Design COMSOL -  https://drive.google.com/file/d/11caJSOxDjlSavZMevXnnpjdtpxdJjDQd/view?usp=drive_link
Damping Calculation Design - https://drive.google.com/file/d/1mVZ0J0S_J4V2JUlCTjnmJ0y24ogSPAOz/view?usp=drive_link
