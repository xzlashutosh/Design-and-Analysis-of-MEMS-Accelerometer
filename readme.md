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
1.  [Abstract](#abstract)
2.  [Introduction](#introduction)
3.  [Background](#background)
4.  [Reduced Order Modeling of the MEMS Device](#reduced-order-modeling-of-the-mems-device)
    -   [Simulation Outline](#simulation-outline)
    -   [Material Properties](#material-properties)
    -   [Geometry](#geometry)
    -   [Meshing](#meshing)
5.  [Analog Circuit Design](#analog-circuit-design)
    -   [Comparison of Topologies](#comparison-of-topologies)
    -   [Description of Selected Topologies](#description-of-selected-topologies)
    -   [Hand Calculation](#hand-calculation)
    -   [Cadence Schematics](#cadence-schematics)
    -   [DC Analysis](#dc-analysis)
    -   [AC Analysis](#ac-analysis)
    -   [Stability Analysis](#stability-analysis)
    -   [PVT](#pvt)
    -   [Monte Carlo Simulation](#monte-carlo-simulation)
    -   [Transient Analysis](#transient-analysis)
    -   [DC Response](#dc-response)
    -   [System Integration with ROM Model](#system-integration-with-rom-model)
6.  [Digital Design](#digital-design)
7.  [Conclusion](#conclusion)

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

---

## Analog Circuit Design
- **Capacitance-to-voltage conversion circuit** implemented in LTSpice.  
- **Amplifier design** using Cadence Virtuoso with 120 dB gain.  
- **Voltage-controlled oscillator (VCO)** for frequency-based output.

An analog circuit is required to convert, read, and co-relate the capacitance change occurring due to acceleration on the accelerometer system. The circuit can be broadly understood using the block diagram shown in Figure 1.

![Analog Circuit Block Diagram](https://github.com/xzlashutosh/Design-and-Analysis-of-MEMS-Accelerometer/blob/main/Analog%20Circuit%20Design/acd.png)  
**Figure 1:** Analog Circuit Block Diagram

The circuit shown in Figure 2 is designed for this purpose.

![Schematic for Capacitance to Voltage Conversion](https://github.com/xzlashutosh/Design-and-Analysis-of-MEMS-Accelerometer/blob/main/Analog%20Circuit%20Design/circuit%20schematic.png)  
**Figure 2:** Schematic for Capacitance to Voltage Conversion

**Key Components:**
- **Cₛ** and **Cᵣ**: Differential capacitance pair
- **Cₚ**: Parasitic capacitance
- **Cᵢ**: Op-amp input capacitance

The system uses:
- Two 90° phase-shifted voltage sources to drive electrodes
- Three stages:  
  1. Capacitance-to-voltage conversion  
  2. Signal amplification  
  3. Peak detection and DC conversion

**First Stage Output Equation**

$$
V_{s1} = \frac{(C_s - C_r) \cdot V_r}{C_s + C_r + C_i + C_p}
$$

![Capacitance to Voltage Conversion](https://github.com/xzlashutosh/Design-and-Analysis-of-MEMS-Accelerometer/blob/main/Analog%20Circuit%20Design/VampInput.png)  
**Figure 3:** First Stage Output (Vₛ₁)


**Performance Data**

| Acceleration (g) | Displacement (m) | C₁ (F)        | C₂ (F)        | Vₛ₁ (V)     |
|-------------------|-------------------|---------------|---------------|-------------|
| 4                 | 5.7433E-08       | 1.0418E-13    | 9.5244E-14    | 4.230E-03   |
| 3                 | 4.323E-08        | 1.0293E-13    | 9.6206E-14    | 3.220E-03   |
| 2                 | 2.8821E-08       | 1.0171E-13    | 9.722E-14     | 2.160E-03   |
| 1                 | 1.4275E-08       | 1.0054E-13    | 9.8265E-14    | 1.092E-03   |


**Amplification Stage**

$$
V_{s2} = A \cdot V_{s1}
$$

**Peak Detector Output**

$$
V_{s3} = \max(V_{s2})
$$

![Final Output Voltage](https://github.com/xzlashutosh/Design-and-Analysis-of-MEMS-Accelerometer/blob/main/Analog%20Circuit%20Design/output.png)  

**Simulation Output for Different Acceleration Values**

---

### Op-Amp Specifications
| Parameter                      | Value   | Units     |
|--------------------------------|---------|-----------|
| Open-Loop Gain (A_FB)          | 1000    | -         |
| Total-Loop Gain                | 1,000,000 | -       |
| Gain-Bandwidth Product (GBW)   | 5       | MHz       |
| Max Operating Frequency        | 5       | kHz       |
| Voltage Swing (V_pp)           | 3.3     | V         |
| Output Offset Voltage          | 0.1     | V         |
| Phase Margin                   | 30      | degrees   |
| Load Capacitance (C_L)         | 1       | pF        |

---

### Design Implementation Flow
1. **Topology Comparison** 
2. **Circuit Schematic Design**  
3. **Simulation Results**
   

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
A_v = -G_m.R_D = \frac{-g_m.R_D}{1 + g_m R_S}
$$

As evident, the values of $R_D$ and $R_S$ are set to obtain a gain of 20dB.  

After this, the selected two-stage op-amp stage is used to obtain the required further gain of 100dB. It consists of a differential amplifier, a gain stage followed by a voltage-controlled voltage source (VCVS) as the output stage. The differential stage amplifies the difference between two input signals. It also gives a high common-mode rejection ratio.  

The gain of this two-stage amplifier is expressed as:

$$
A_v = A_1.A_2
$$

where $A_1$ and $A_2$ are the gains of the individual stages of the two-stage op-amp. The output from this second stage is fed into a VCVS, allowing for handling the load stage.

### Hand Calculation

**Input Parameters for the Design**
| **Parameter**         | **Value**                 | **Description**                   |
|------------------------|---------------------------|-------------------------------------|
| $C_L$               | $10  \text{pF}$       | Load capacitance                   |
| $f_{\text{max}}$    | $5  \text{MHz}$       | Maximum operating frequency        |
| $V_{pp}$            | $3.3  \text{V}$       | Peak-to-peak voltage               |
| $V_{\text{on}}$     | $50  \text{mV}$       | Overdrive voltage                  |
| $V_{\text{thn}}$    | $0.50  \text{V}$      | NMOS threshold voltage             |
| $V_{\text{thp}}$    | $0.65  \text{V}$      | PMOS threshold voltage             |
| $K_n$               | $170  \mu\text{A}/\text{V}^2$ | NMOS process constant        |
| $K_p$               | $60  \mu\text{A}/\text{V}^2$  | PMOS process constant        |
| $\lambda$           | $0.05$                 | Channel length modulation parameter|
| $A_{FB}$            | $10^6$                 | Feedback gain (120 dB)             |
| $V_{\text{offset, out}}$| $0.1  \text{V}$   | Output offset voltage              |
| $A_{Vth}$           | $9.5  \text{mV}\cdot\mu\text{m}$| Matching parameter          |

**Key Equations for Two-Stage Op-Amp Design**

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

**The pre-amplifier stage**
![alt text](https://github.com/xzlashutosh/Design-and-Analysis-of-MEMS-Accelerometer/blob/main/OverallAnalogCircuitImages/pre-amp%20stage.png)

**The second stage - 2 Stage Differential Amplifier**
![alt text](https://github.com/xzlashutosh/Design-and-Analysis-of-MEMS-Accelerometer/blob/main/OverallAnalogCircuitImages/2stageOpAmp.png)

**Complete Op-Amp with a testbench**
![alt text](https://github.com/xzlashutosh/Design-and-Analysis-of-MEMS-Accelerometer/blob/main/OverallAnalogCircuitImages/opampMonte.png)

### DC Analysis

**DC Operating points for the MOSFETs**
![alt text](https://github.com/xzlashutosh/Design-and-Analysis-of-MEMS-Accelerometer/blob/main/OverallAnalogCircuitImages/DCOperatingPoints.png)
![alt text](https://github.com/xzlashutosh/Design-and-Analysis-of-MEMS-Accelerometer/blob/main/OverallAnalogCircuitImages/DCOperatingPoints_2.png)

### AC Analysis

![alt text](https://github.com/xzlashutosh/Design-and-Analysis-of-MEMS-Accelerometer/blob/main/OverallAnalogCircuitImages/AcOperatingPoints4.png)

AC response over the range of frequencies.
![alt text](https://github.com/xzlashutosh/Design-and-Analysis-of-MEMS-Accelerometer/blob/main/OverallAnalogCircuitImages/ACResponse.png)

### Stability Analysis
**Gain and Phase with $C_c$ = 20pF**


![alt text](https://github.com/xzlashutosh/Design-and-Analysis-of-MEMS-Accelerometer/blob/main/OverallAnalogCircuitImages/StabilityResponse20pF.png)

**Gain and Phase with $C_c$ = 40pF**


![alt text](https://github.com/xzlashutosh/Design-and-Analysis-of-MEMS-Accelerometer/blob/main/OverallAnalogCircuitImages/StabilityResponse40pF.png)

**Gain and Phase at 5kHz**


![alt text](https://github.com/xzlashutosh/Design-and-Analysis-of-MEMS-Accelerometer/blob/main/OverallAnalogCircuitImages/stabilityAt5KHz.png)

**Phase Margin vs $R_f$ with $C_c$ = 20pF**


![alt text](https://github.com/xzlashutosh/Design-and-Analysis-of-MEMS-Accelerometer/blob/main/OverallAnalogCircuitImages/PMvsRmiller20pF.png)

**Phase Margin vs $R_f$ with $C_c$ = 40pF**


![alt text](https://github.com/xzlashutosh/Design-and-Analysis-of-MEMS-Accelerometer/blob/main/OverallAnalogCircuitImages/PMvsRmiller40pF.png)



### PVT


| **Test**            | **Nominal**   | **Spec**   | **Pass/Fail** | **Min**       | **Max**       | **$R_f$**        | **$C_c$**    |
|----------------------|---------------|------------|---------------|---------------|---------------|------------------|--------------|
| TB:1 Gain           | 122.9 dB      | $> 80$     | pass          | 90.28 dB      | 123.3 dB      | 933.33 $\Omega$  | 40 pF        |
| TB:1 Phase Margin   | 55.4°         | $> 30$     | pass          | 51.77°        | 69.31°        | 933.33 $\Omega$  | 40 pF        |
| TB:2 Phase Margin   | 44.5°         | $> 30$     | pass          | 39.75°        | 49.17°        | 1.05 k$\Omega$   | 20 pF        |
| TB:2 Gain           | 122.9 dB      | $> 80$     | pass          | 90.28 dB      | 123.3 dB      | 1.05 k$\Omega$   | 20 pF        |

**PVT Test Validation in Cadence**


![alt text](https://github.com/xzlashutosh/Design-and-Analysis-of-MEMS-Accelerometer/blob/main/Analog%20Circuit%20Design/PVT_TestPassed.jpeg)

**Phase Margin and Gain variation with the changing supply and process parameters.**


![alt text](https://github.com/xzlashutosh/Design-and-Analysis-of-MEMS-Accelerometer/blob/main/OverallAnalogCircuitImages/PVTall.png)

**Gain and Phase Margin variation with the changing temperature and process parameters.**


![alt text](https://github.com/xzlashutosh/Design-and-Analysis-of-MEMS-Accelerometer/blob/main/OverallAnalogCircuitImages/PVT20pF_1.05kohm.png)



### Monte Carlo Simulation


**Monte Carlo Analysis**


![alt text](https://github.com/xzlashutosh/Design-and-Analysis-of-MEMS-Accelerometer/blob/main/OverallAnalogCircuitImages/MonteCarlo40pF_933.33ohm.png)



### Transient Analysis

**Transient Simulation with pulse voltages**


![alt text](https://github.com/xzlashutosh/Design-and-Analysis-of-MEMS-Accelerometer/blob/main/OverallAnalogCircuitImages/transientAnalysis.png)



### DC Response
  

**Amplification Test Circuit Simulation**

DC simulation is conducted to test the amplification of the op-amp by varying the input voltage from zero to 15mV. To perform this, DC voltage is applied at the non-inverting terminal of the op-amp. 

As shown in **Figure 1**, the amplifier response is illustrated. The amplifier is configured in a non-inverting amplifier configuration. The resistor values are in the ratio of 99k/1k, which results in a net amplification of 100, as visible in the figure.

The amplification is given by:

$$
\frac{V_o}{V_i} = 1 + \frac{R_2}{R_1}
$$

Here, the input of 15mV also becomes 30mV accordingly, verifying the correct operation of the designed op-amp.

![Amplification using non-inverting op-amp configuration](/OverallAnalogCircuitImages/DCResponse.png)
**Amplification using non-inverting op-amp configuration** 

Following rigorous hand calculations, schematic design, and various simulations, the design is finalized with the following specifications:

| **Parameter**                 | **Value**            |
|--------------------------------|----------------------|
| Gain Factor                   | 122.9364 dB         |
| Gain at 5 kHz                 | 95 dB               |
| Gain Bandwidth Product (GBW)  | 5000 kHz            |
| Cutoff Frequency              | 207 Hz              |
| Phase Margin                  | ~$45^\circ$          |
| Percentage Error (for 1mV signal) | 0.1%               |
| Input Offset Voltage          | 0.165 mV            |
| Output Referred Offset Voltage| 1.65 V              |


---

### System Integration with ROM Model


![ROM Integration](https://github.com/xzlashutosh/Design-and-Analysis-of-MEMS-Accelerometer/blob/main/Analog%20Circuit%20Design/ROMInputTOCap.png)  
**ROM Model Implementation** 
![alt text](https://github.com/xzlashutosh/Design-and-Analysis-of-MEMS-Accelerometer/blob/main/Analog%20Circuit%20Design/twinBuilder.png)
**ROM Model Simulation** 

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
**Ashutosh Sharma** 

BME, Hungary | USN, Norway | Aalto University, Finland 

Email: ashutosh.iiitk@gmail.com


## Links
Slide Deck - https://github.com/xzlashutosh/Design-and-Analysis-of-MEMS-Accelerometer/blob/main/MEMS_Accelerometer_Design_report.pdf

MEMS Accelerometer Design COMSOL Files-  https://drive.google.com/file/d/11caJSOxDjlSavZMevXnnpjdtpxdJjDQd/view?usp=drive_link

Damping Calculation Design - https://drive.google.com/file/d/1mVZ0J0S_J4V2JUlCTjnmJ0y24ogSPAOz/view?usp=drive_link
