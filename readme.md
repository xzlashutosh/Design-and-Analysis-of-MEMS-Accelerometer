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
4. [Analog Circuit Design](#analog-circuit-design)
      - 
6. [Digital Design](#digital-design)  
7. [Conclusion](#conclusion)  

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
<p align="center">
  <img width="400" height="400" src="https://github.com/xzlashutosh/Design-and-Analysis-of-MEMS-Accelerometer/blob/main/Digital%20Design%20-%20VCO%20and%20frequency%20counter/Differential_capacitance_DX.png"
</p>

Using the **small displacement approximation**, we obtain the linearized capacitance equation:

$$
\Delta C = \frac{2\varepsilon A x}{d^2}
$$

The accelerometer's inertial response, based on **Hooke’s Law**, is given by:

$$
x = \frac{ma}{k}
$$

where:
- x is the displacement of the proof mass,
- m is the mass of the proof mass,
- a is the acceleration,
- k is the spring constant.



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
![alt text](https://github.com/xzlashutosh/Design-and-Analysis-of-MEMS-Accelerometer/blob/main/Digital%20Design%20-%20VCO%20and%20frequency%20counter/Overall%20geometry.png)
---
### Meshing  
![alt text](https://github.com/xzlashutosh/Design-and-Analysis-of-MEMS-Accelerometer/blob/main/Digital%20Design%20-%20VCO%20and%20frequency%20counter/Meshing.JPG)
![alt text](https://github.com/xzlashutosh/Design-and-Analysis-of-MEMS-Accelerometer/blob/main/Digital%20Design%20-%20VCO%20and%20frequency%20counter/Fingers%20and%20Anchor%20meshing.png)
![alt text](https://github.com/xzlashutosh/Design-and-Analysis-of-MEMS-Accelerometer/blob/main/Digital%20Design%20-%20VCO%20and%20frequency%20counter/meshoverall.png)
![alt text](https://github.com/xzlashutosh/Design-and-Analysis-of-MEMS-Accelerometer/blob/main/Digital%20Design%20-%20VCO%20and%20frequency%20counter/overall%20mesh.png)

## Analog Circuit Design
- **Capacitance-to-voltage conversion circuit** implemented in LTSpice.  
- **Amplifier design** using Cadence Virtuoso with 120 dB gain.  
- **Voltage-controlled oscillator (VCO)** for frequency-based output.

An analog circuit is required to convert, read and co-relate
 the capacitance change occurring due to acceleration on the
 accelerometer system. The circuit can be broadly understood
 using the block diagram shown in Fig. 21. It consists of three
 major stages- capacitance to voltage conversion; amplification
 and peak detection. The circuit shown in Fig. 22 is designed
 for this. It consists of the changing capacitor Cs and Cr (the
 two capacitors in the differential capacitance). Two voltage
 sources with a phase difference of 90 degrees drive the
 two capacitors (i.e. electrodes). The Cp here stands for the
 capacitance due to parasitics and Ci is the input capacitance
 of the op-amp stage. Then this voltage is taken through Cs
 and Cr and brought to op-amp to be amplified. As the signal
 is amplified, it gives a similar output as the input but with an
 amplified amplitude. Since our driving was a sinusoidal input,
 it gave us a sinusoidal output. This is then given to a precision
 peak detector circuit, which feeds a DC voltage to a voltage
controlled oscillator to generate a frequency corresponding to
 the voltage input. This output frequency can be then measured
 by a digital circuit to display on a 7-segment display.
![alt text](https://github.com/xzlashutosh/Design-and-Analysis-of-MEMS-Accelerometer/blob/main/Analog%20Circuit%20Design/acd.png)
![alt text](https://github.com/xzlashutosh/Design-and-Analysis-of-MEMS-Accelerometer/blob/main/Analog%20Circuit%20Design/circuit%20schematic.png)
![alt text](https://github.com/xzlashutosh/Design-and-Analysis-of-MEMS-Accelerometer/blob/main/Analog%20Circuit%20Design/VampInput.png)
![alt text](https://github.com/xzlashutosh/Design-and-Analysis-of-MEMS-Accelerometer/blob/main/Analog%20Circuit%20Design/output.png)
![alt text](https://github.com/xzlashutosh/Design-and-Analysis-of-MEMS-Accelerometer/blob/main/Analog%20Circuit%20Design/ROMInputTOCap.png)

---


![alt text](https://github.com/xzlashutosh/Design-and-Analysis-of-MEMS-Accelerometer/blob/main/Analog%20Circuit%20Design/PVT_TestPassed.jpeg)
![alt text](https://github.com/xzlashutosh/Design-and-Analysis-of-MEMS-Accelerometer/blob/main/Analog%20Circuit%20Design/points.txt)
![alt text](https://github.com/xzlashutosh/Design-and-Analysis-of-MEMS-Accelerometer/blob/main/Analog%20Circuit%20Design/stage1.png)
![alt text](https://github.com/xzlashutosh/Design-and-Analysis-of-MEMS-Accelerometer/blob/main/Analog%20Circuit%20Design/stage2.png)
![alt text](https://github.com/xzlashutosh/Design-and-Analysis-of-MEMS-Accelerometer/blob/main/Analog%20Circuit%20Design/stage3.png)
![alt text](https://github.com/xzlashutosh/Design-and-Analysis-of-MEMS-Accelerometer/blob/main/Analog%20Circuit%20Design/twinBuilder.png)

---
### Comparison Of Topologies
| **Topology**         | **Gain** | **Bandwidth** | **Speed** | **Output Swing** |
|-----------------------|----------|---------------|-----------|-------------------|
| Two Stage            | High     | High          | Low       | Highest           |
| Telescopic cascode   | Medium   | Medium        | Highest   | Medium            |
| Folded cascode       | Medium   | Medium        | High      | Medium            |
| Regulated cascode    | High     | High          | Medium    | Medium            |

### Description of Selected Topologies
To achieve a closed-loop gain of 1000 (60 dB), the op-amp must have a sufficiently high open-loop gain to minimize gain error and maintain stability. For a gain error of 0.1\%, the open-loop gain needs to be 1,000,000 (120 dB). This is here realized using a two-stage op-amp: a high-gain first stage, followed by a second stage for further amplification and driving the load and a source-degenerated pre-amplifier stage providing an initial gain of 20 dB. This will improve linearity and input matching with a high-gain main amplifier stage to achieve the required total open-loop gain of 120 dB.

![alt text](https://github.com/xzlashutosh/Design-and-Analysis-of-MEMS-Accelerometer/blob/main/OverallAnalogCircuitImages/selectedTopologiesDesc/sourceDegeneration.png)

This is an amplifier where a resistor is placed in series with the source connecting two MOSFETs. This resistor reduces gain slightly but improves linearity, input impedance, and stability. It is used before a two-stage op-amp to provide an initial gain of 20 dB because it amplifies the input signal modestly with good linearity. It also improves input impedance for better signal matching, and reduces distortion for the main op-amp stages.  

Its gain is given by the formula:

$$
A_v = -G_m R_D = \frac{-g_m R_D}{1 + g_m R_S}
\label{degGain}
$$

As evident, the values of \( R_D \) and \( R_S \) are set to obtain a gain of 20dB.  

After this, the selected two-stage op-amp stage is used to obtain the required further gain of 100dB. It consists of a differential amplifier, a gain stage followed by a voltage-controlled voltage source (VCVS) as the output stage. The differential stage amplifies the difference between two input signals. It also gives a high common-mode rejection ratio.  

The gain of this two-stage amplifier is expressed as:

$$
A_v = A_1.A_2
$$

where \( A_1 \) and \( A_2 \) are the gains of the individual stages of the two-stage op-amp. The output from this second stage is fed into a VCVS, allowing for handling the load stage.

### Hand Calculation

### Key Equations for Two-Stage Op-Amp Design

| **Equation** | **Unit/Value** |
|-------------|--------------|
| $C_c = 0.2 \cdot C_L$ | 2.0 pF |
| $SR = 2 \pi f_{\text{max}} \cdot V_{\text{pp}}$ | 103.67 V/µs |
| $V_{\text{offset-in}} = \frac{V_{\text{offset-out}}}{A_{\text{FB}}}$ | 100 µV |
| $I_{\text{tail}} = 1.1 \cdot C_c \cdot SR$ | 207.34 µA |
| $g_m = \frac{2 \cdot (I_{\text{tail}} / 2)}{V_{\text{on}}}$ | 4.146 mA/V |
| $diff \frac{W}{L} = \frac{2 \cdot (I_{\text{tail}} / 2)}{K_n \cdot V_{\text{on}}^2}$ | 488.0 |
| $GBW = \frac{g_m}{C_c}$ | 2073.0 MHz |
| $W \cdot L = \left( \frac{A_{Vth}}{V_{\text{offset-out}} / AFB \cdot \sqrt{2}} \right)^2$ | 4689.6 |
| ${M3} \frac{W}{L}  = \frac{2 \cdot (I_{\text{tail}} / 2)}{K_p \cdot V_{\text{on3}}^2}$ | 154.0 |
| ${M7} \frac{W}{L} = \frac{2 \cdot I_{\text{tail}}}{K_n \cdot V_{\text{on}}^2}$ | 488.0 |
| ${M8} \frac{W}{L} = 3.5 \cdot \frac{W}{L}_{M_7}$ | 1708.0 |
| $r_{ds} = \frac{1}{\lambda \cdot I_{\text{tail}}}$ | 96.45 KΩ |
| $f_1 = \frac{1}{2 \pi r_{ds} C_c}$ | 6.47 KHz |
| $f_2 = \frac{g_m}{2 \pi C_c}$ | 518.36 MHz |
| $\text{UGB} = \frac{g_m}{2 \pi C_c}$ | 330 MHz |
| $\phi_m = 90^\circ - \tan^{-1}\left( \frac{\text{UGB}}{f_1} \right) \times \frac{180}{\pi} - \tan^{-1}\left( \frac{f_2}{\text{UGB}} \right) \times \frac{180}{\pi}$ | 57.52° |







### Cadence Schematics
### DC Analysis
### AC Analysis
### Stability Analysis
### PVT
### Monte Carlo Simulation
### Transient Analysis
### DCResponse
  

![alt text](https://github.com/xzlashutosh/Design-and-Analysis-of-MEMS-Accelerometer/blob/main/OverallAnalogCircuitImages/2stageOpAmp.png)
![alt text](https://github.com/xzlashutosh/Design-and-Analysis-of-MEMS-Accelerometer/blob/main/OverallAnalogCircuitImages/ACResponse.png)
![alt text](https://github.com/xzlashutosh/Design-and-Analysis-of-MEMS-Accelerometer/blob/main/OverallAnalogCircuitImages/AcOperatingPoints4.png)
![alt text](https://github.com/xzlashutosh/Design-and-Analysis-of-MEMS-Accelerometer/blob/main/OverallAnalogCircuitImages/DCOperatingPoints.png)
![alt text](https://github.com/xzlashutosh/Design-and-Analysis-of-MEMS-Accelerometer/blob/main/OverallAnalogCircuitImages/DCOperatingPoints_2.png)
![alt text](https://github.com/xzlashutosh/Design-and-Analysis-of-MEMS-Accelerometer/blob/main/OverallAnalogCircuitImages/DCResponse.png)
![alt text](https://github.com/xzlashutosh/Design-and-Analysis-of-MEMS-Accelerometer/blob/main/OverallAnalogCircuitImages/MonteCarlo40pF_933.33ohm.png)
![alt text](https://github.com/xzlashutosh/Design-and-Analysis-of-MEMS-Accelerometer/blob/main/OverallAnalogCircuitImages/PMvsRmiller20pF.png)
![alt text](https://github.com/xzlashutosh/Design-and-Analysis-of-MEMS-Accelerometer/blob/main/OverallAnalogCircuitImages/PMvsRmiller40pF.png)
![alt text](https://github.com/xzlashutosh/Design-and-Analysis-of-MEMS-Accelerometer/blob/main/OverallAnalogCircuitImages/PVT20pF_1.05kohm.png)
![alt text](https://github.com/xzlashutosh/Design-and-Analysis-of-MEMS-Accelerometer/blob/main/OverallAnalogCircuitImages/PVTall.png)
![alt text](https://github.com/xzlashutosh/Design-and-Analysis-of-MEMS-Accelerometer/blob/main/OverallAnalogCircuitImages/StabilityResponse20pF.png)
![alt text](https://github.com/xzlashutosh/Design-and-Analysis-of-MEMS-Accelerometer/blob/main/OverallAnalogCircuitImages/StabilityResponse40pF.png)
![alt text](https://github.com/xzlashutosh/Design-and-Analysis-of-MEMS-Accelerometer/blob/main/OverallAnalogCircuitImages/opampMonte.png)
![alt text](https://github.com/xzlashutosh/Design-and-Analysis-of-MEMS-Accelerometer/blob/main/OverallAnalogCircuitImages/pre-amp%20stage.png)
![alt text](https://github.com/xzlashutosh/Design-and-Analysis-of-MEMS-Accelerometer/blob/main/OverallAnalogCircuitImages/stabilityAt5KHz.png)
![alt text](https://github.com/xzlashutosh/Design-and-Analysis-of-MEMS-Accelerometer/blob/main/OverallAnalogCircuitImages/transientAnalysis.png)

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
