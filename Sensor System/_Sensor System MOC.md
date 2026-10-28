---
subject: Sensor System
description: Map of content for the sensor system block — transducers and sensor specifications, photodiode physics and light detection, CCD versus CMOS image sensors, and thermal transducers (RTDs, thermistors and thermocouples)
---

# Sensor System

> [!summary] Overview
> The block moves from general sensing theory to concrete transducers. [[Sensors]] establishes the vocabulary — transducers, classification and figures of merit — then two families apply it: [[Light Sensors]] takes the photodiode and its noise and readout up to [[Image Sensors]] and its CCD and CMOS pixel arrays, while [[Temperature sensors]] builds thermal measurement from resistive devices (RTDs and thermistors) to the thermoelectric thermocouple. Read [[Sensors]] first; afterwards the light and thermal branches are independent and each reuses the specifications of the introduction.

## 1. Reading Path

1. [[Sensors]] — transducer as energy converter, sensor versus actuator, classification by phenomenon and mechanism, characteristics (sensitivity, LSB, FSR, accuracy, INL/DNL, noise, dynamic range), readout and calibration.
2. [[Light Sensors]] — photodiode physics: reverse bias, p-n versus p-i-n, penetration depth and bandgap, responsivity, electrical model, thermal and shot noise, NEP, readout; then APD, SPAD, SiPM and LDR.
3. [[Image Sensors]] — CCD (MOS capacitor, charge transfer, blooming, CTE) and CMOS active pixels, quantum efficiency, dark current, well capacity, reset noise and CDS, Bayer filtering.
4. [[Temperature sensors]] — RTDs with $\alpha$ and the 2/3/4-wire and bridge readouts, NTC and PTC thermistors with their $\beta$ law and applications, and the Seebeck effect behind the thermocouple.

## 2. Core Ideas

- A **sensor** monitors a parameter, an **actuator** acts on the mechanism — both are transducers, but only one is in the measurement chain.
- Figures of merit are the language of datasheets: resolution is an **LSB**, span is **FSR**, static accuracy splits into gain and offset error (**INL/DNL**), and the usable range is set by noise.
- In a photodiode, **responsivity** converts optical power to current; thermal and shot noise set the noise floor and hence the **NEP**.
- Image sensors trade the same quantities at pixel level: **quantum efficiency** and **well capacity** set sensitivity and dynamic range, **dark current** sets the floor, and **CDS** removes reset noise.
- CCD moves charge, CMOS switches per pixel — the architectural difference drives noise, speed and cost.
- Thermal sensing splits by the physics exploited: **resistance** (RTD, thermistor) or **thermoelectricity** (thermocouple). RTDs are linear, accurate and slow; thermistors are sensitive but narrow and non-linear; thermocouples are self-powered and wide-range but produce microvolts.
- Every resistive thermal sensor shares one problem: the **readout**. Lead resistance is cancelled by going from 2 to 3 or 4 wires or by a bridge, and the excitation current that makes $\Delta R$ readable also **self-heats** the element.

## 3. Gaps and next Steps

- [[Temperature sensors]] stops at the standard thermocouple types — **cold-junction compensation**, the signal conditioning chain and the linearisation of NTCs are still missing, and sections 1 (RTD introduction) and 1.3 (self-heating) are marked incomplete.
- No note yet on the optical front-end (lenses, filters, IR-cut) — see [[Optical Systems]] and [[_Image Analysis MOC]].
- [[Image Sensors]] compares CCD and CMOS qualitatively; quantitative noise and SNR budgets would need the datasheet parameters from [[Sensors]].
