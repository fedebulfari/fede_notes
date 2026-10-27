---
subject: Sensor System
description: Map of content for the sensor system block — transducers and sensor specifications, photodiode physics and light detection, and CCD versus CMOS image sensors
---

# Sensor System

> [!summary] Overview
> The block moves from general sensing theory to concrete light-detection hardware. [[Sensors]] establishes the vocabulary — transducers, classification and figures of merit — [[Light Sensors]] applies it to the photodiode and its noise and readout, and [[Image Sensors]] scales the same transduction ideas to CCD and CMOS pixel arrays. Read in that order, each note reuses the specifications of the previous one.

## 1. Reading Path

1. [[Sensors]] — transducer as energy converter, sensor versus actuator, classification by phenomenon and mechanism, characteristics (sensitivity, LSB, FSR, accuracy, INL/DNL, noise, dynamic range), readout and calibration.
2. [[Light Sensors]] — photodiode physics: reverse bias, p-n versus p-i-n, penetration depth and bandgap, responsivity, electrical model, thermal and shot noise, NEP, readout; then APD, SPAD, SiPM and LDR.
3. [[Image Sensors]] — CCD (MOS capacitor, charge transfer, blooming, CTE) and CMOS active pixels, quantum efficiency, dark current, well capacity, reset noise and CDS, Bayer filtering.

## 2. Core Ideas

- A **sensor** monitors a parameter, an **actuator** acts on the mechanism — both are transducers, but only one is in the measurement chain.
- Figures of merit are the language of datasheets: resolution is an **LSB**, span is **FSR**, static accuracy splits into gain and offset error (**INL/DNL**), and the usable range is set by noise.
- In a photodiode, **responsivity** converts optical power to current; thermal and shot noise set the noise floor and hence the **NEP**.
- Image sensors trade the same quantities at pixel level: **quantum efficiency** and **well capacity** set sensitivity and dynamic range, **dark current** sets the floor, and **CDS** removes reset noise.
- CCD moves charge, CMOS switches per pixel — the architectural difference drives noise, speed and cost.

## 3. Gaps and next Steps

- No note yet on the optical front-end (lenses, filters, IR-cut) — see [[Optical Systems]] and [[_Image Analysis MOC]].
- [[Image Sensors]] compares CCD and CMOS qualitatively; quantitative noise and SNR budgets would need the datasheet parameters from [[Sensors]].
