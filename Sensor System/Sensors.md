---
date: 13-10-2026
subject: Sensor System
description:
---

# 1. Transducer

**Transducer**: device which transforms energy from one type to another, even if both energy types are in the same domain.
Typical domains: mechanical, electrical, chemical, magnetic, optical and thermal.

Subdivided in:
- **Sensor:** device which monitors a parameter of a system, hopefully without disturbing that parameter. Input can be light, heat, motion, moisture, pressure, etc. Output is generally a signal converted to human-readable display or transmitted over a network for reading / further processing.
- **Actuator:** component of machines responsible for moving or controlling a mechanism or system.

![[Sensors-1791907985501.webp|405]]

# 2. Classification

## By physical phenomena

- Optical: visible / IR light (photodiode, CCD, CMOS APS, infrared sensor)
- Thermal: temperature (RTD, thermistor, thermocouple…)
- Magnetic: magnetic field (Hall effect sensor, magneto-resistive sensor)
- Mechanical: strain (strain gauge), force (piezo-electric sensor), displacement and distance (capacitive, inductive, acoustic, optical), acceleration and orientation (MEMS), viscosity, pressure, etc.
- Chemical: pH (pH-meter)

## By sensing mechanism

- Resistive
- Capacitive
- Inductive
- Piezoelectricity
- Hall Effect
- MEMS

| Physical phenomena | Sensor |
|---|---|
| Light and images | Photodiode, CCD, CMOS sensor |
| Temperature | RTD, Thermistors (NTC and PTC), Thermocouple, Infrared thermometer |
| Magnetic field | Hall effect sensors, Magneto-resistances |
| Strain, force, pressure | Strain gauges, Piezoelectric sensors |
| Displacement, proximity, distance and rotation | Capacitive, Inductive, Acoustic, Optical sensors |
| Acceleration and orientation | Accelerometers (MEMS), Gyroscopes (MEMS) |
| Sound | Microphone |

# 3. Characteristics

- **Sensitivity**: ratio between change in output signal to small change in input physical signal. Slope of the input-output fit line:$$S = \frac{\partial out}{\partial in}$$
- **Resolution (LSB)**: smallest increment of measure that a device can make (Least Significant Bit)
- **Full Scale Range (FSR)**: maximum interval of measure that a device can cover
- **Number of bits (n)**: in sensors with digital output, $2^n$ is number of levels in which FSR is divided:$$2^n = \frac{FSR}{LSB}$$
- **Accuracy**: error between result of a measurement and true value being measured
- **Repeatability / Precision**: ability of sensor to output same value for same input over a number of trials
  > [!tip] Accuracy vs Precision
  > - Precise without accurate: repeated measurements clustered together but far from true value
  > - Accurate without precise: measurements centered on true value but spread out
  > - Precise and accurate: measurements clustered on true value
  ![[Sensors-1791925614863.webp|508]]
  >	
- **Linearity**: deviation of output from a best-fit straight line for a given range.
  Differential Non-Linearity (DNL) and Integral Non-Linearity (INL):$$DNL(i) = \Delta in(i) - LSB\\INL(i) = \sum_{k=1}^{i} DNL(k)$$
	- DNL: difference of real step compared to ideal one (i.e. 1 LSB)
	- INL: distance between real and ideal output voltage
	  ![[Sensors-1791925826885.webp|402]]

- **Transfer Function (Frequency Response)**: relationship between physical input signal and electrical output signal, which may constitute complete description of sensor characteristics as function of frequency. Can describe the whole sensor characteristics.
- **Bandwidth**: frequency range between lower and upper cutoff frequencies, within which sensor transfer function is at constant gain or linear
- **Noise**: random fluctuation in measured value. Quantified with its rms (root mean square) value.
  ![[Sensors-1791926310050.webp|409]]

- **Dynamic Range**: ratio of maximum recordable input amplitude to minimum input amplitude, in dB:$$DR = 20 \cdot \log\left( \frac{\text{Input-Amplitude}|_{Max}}{\text{Input-Amplitude}|_{min}} \right)$$
	- Min Input: typically noise
	- Max Input: typically FSR

# 4. Readout

## Analog sensor readout
- ADC + microcontroller: many microcontrollers have built-in ADC (typically 8-bit to 12-bit or even 16-bit)
- Data Acquisition Cards (DAQ):
  - PC card or external devices with analog and digital I/O
  - interface through LabVIEW or user-generated code

## Smart sensors readout

**Smart sensor** = sensor with built-in signal processing & communication (e.g. combining a "dumb sensor" and ADC / processing).

Digital output:
- parallel bus
- serial I/O
  - synchronous (with clock): SPI, I2C
    - Serial Peripheral Interface (SPI): 1 clock + 1 bidirectional data + 1 chip select / enable
    - Inter Integrated Circuit (I2C): 1 clock + 1 data
    - must match byte format, stop/start bits, parity check, etc.
  - asynchronous (no clock): one wire
    - Universal Asynchronous Receiver Transmitter (UART)
    - must match baud rate and bit width, transmission protocol, etc.

# Sensor Calibration

Sensors can exhibit non-ideal effects:
- **offset**: nominal output $\neq$ nominal parameter value, with fixed difference
- **nonlinearity**: output not linear with parameter changes
- **cross parameter sensitivity**: secondary output variation with other parameters (e.g. temperature drifts)

**Calibration** = adjusting output to match parameter:
- analog signal conditioning
- look-up table
- digital calibration: $T = a + bV + cV^2$
  - $T$ = temperature, $V$ = sensor voltage
  - $a,b,c$ = calibration coefficients

---
Related: [[_Sensor System MOC]]
Source: [[01 - Sensors.pdf]]
