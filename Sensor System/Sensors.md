---
date: 13-10-2026
subject: Sensor System
description:
---

# Transducer

**Transducer**: transform energy from one type to another 
	Typical domains: mechanical, electrical, chemical, magnetic, optical and thermal.

subdivided in: 
- **Sensors:** monitor a parameter of a system
- **Actuator:** component that make the system interact with the world

![[Sensors-1791907985501.webp|405]]

# Classification

- Physical phenomena
	- Optical
	- Thermal
	- Magnetic
	- Chemical
- Sensing Mechanism
	- Resistive
	- Capacitive
	- Inductive
	- Piezoelectricity
	- MEMs
![[Sensors-1791908298449.webp|528]]

# Characteristics

- Sensitivity: Slope of the input-output fit line
$$S=\frac{\delta\ out}{\delta \ in}$$
- Resolution(LSB): Smallest increment of measure of  the device
- Full scale Range(FSR): maximum mintervall of measuse
- Number of bits(n): $$2^n=\frac{FSR}{LSB}$$
- Accuracy: error between a measurment and the actual value
- Repeatability/Precision: ability of the sensor to repeat the exact same output
	![[Sensors-1791925614863.webp|508]]
- Linearity: deviation of the outpu from a best-fit-straigth linearity
	We can talk about Diffrerential Non-Linearity and Integral Non-Linearity: $$DNL(i)=\Delta in(i)-LSB\\ INL(i)=\sum^i_{k=1}DNL(k)$$
	![[Sensors-1791925826885.webp|402]]

- Transfer Function: Relationship between input and output.
	Can describe the hall sensor characteristics
- Bandwit: frequency range betweenlower and upper cutoff frequencies
- Noise: random measurment flurcctuation
	![[Sensors-1791926310050.webp|409]]
- Dynamic Range: ratio of the maximum to minimum recordable input amplitude$$DR=20*Log\left( \frac{\text{Input-Amplitude}|_{Max}}{\text{Input-Amplitude}|_{min}} \right),\ \text{in dB} $$
---
Related: [[_Sensor System MOC]]
Source: