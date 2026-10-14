![[Image Sensors-1791960351242.webp|511]]
[!uncoplete]
## Reset Noise
Noise associated with recharging the output storage capacitor:
$$\sigma Q_{reset}=\sqrt{ kTC }$$
where C is the output capacitance.

We can remove the noise by a practice called **Correlated double smapling**:
	The output voltage is  measured after reset and again after readout. BY subtratting the first value to the second we obtain a measurment of the noise.
	![[Drawing 2026-10-14 08.55.32.excalidraw]]

## Color filtering 

Various method
Bayer array(most common RGB filter)
![[Image Sensors-1791961262598.webp|318]]

Since the human eye is more sensitive to green than to the other two colors, the Bayer array has twice as many green color filters. This also means that with the Bayer array, the human eye can detect more detail than if the three colors were used in equal measures in the filter.

>[!info] Demosaicing algorithm
>Needed too fill the gap between two pixel by making an  avarage of the tre different value

## Types of CCD

- **Full frame**: entire chip is exposed to light. Readout requires shifting the charge both vertically and horizontally. Slow, and signal is corrupted during readout because light keeps arriving → mechanical shutter needed.
- **Frame transfer**: upper (or lower) half of the array is shielded from light, so imaging happens only in the uncovered part. Fast vertical transfer from uncovered to masked region, then slow readout from the masked region.
- **Interline transfer:** every other line is shielded from light. The uncovered line is transferred to the adjacent masked line for readout — even faster transfer than frame transfer. 
	Since the resouling pixels are retttangular the vertical pithc is double the horizontal one; we need to do an avarage of adiacating pixel to compensate the gap.
	![[Image Sensors-1791962308534.webp|135]]

# 2. CMOS active pixel image sensor

## Active Pixel Sensor (APS)

Both photodiode **and readout amplifier in each pixel**: charge accumulated by photodiode is converted to amplified voltage inside the pixel, then transferred by rows/columns to analog signal processing.

Main pixel components:
- Photodiode
- 3 transistors
- Busses
- Bayer filter
- Micro-lens [!uncomplete]
![[Image Sensors-1791964040671.webp|242]]

> Fill factor ≈ 30% (photosensitive area / total pixel area, rest is transistors) — much lower than CCD.

![[Image Sensors-1791962560250.webp|134]]
## 3-transistor (3T) pixel

- **M1 – Reset:** restores initial condition before exposure
- **M2 – Source-follower amplifier:** load common to all pixels in a column
- **M3 – Row-select:** connects pixel output to column bus for readout
![[Image Sensors-1791962540060.webp|243]]
All pixels in a column share one column amplifier.
![[Drawing 2026-10-14 09.31.09.excalidraw]]
[!uncomplete]
## Noise sources

- **Fixed Pattern Noise (FPN):** variation in photodiode efficiency + mismatch in source-follower performance. Constant and reproducible → removed by flat-field correction (on-chip subtraction of uniform-illumination image).
- **Reset noise (kTC noise)**:$$\upsilon_{n}=\sqrt{ \frac{KT}{C} }$$
- **Amplifier noise (1/f noise)**
- **Photodiode shot noise**

## Sensor structure and functional blocks

Modern sensor: **Back-illuminated**, 3D-stacked hybrid-bonding **CIS + ISP** (CMOS Image Sensor + Image Signal Processor).

Typical blocks (VGA 640×480 example):
- Line address register for readout + shielded pixels for black-level compensation
- Correlated Double Sampling (CDS) to reduce reset noise
- Horizontal shift register
- Video amplifier with adjustable gain/offset
- ADC
- Image processing (interpolation, smoothing, white/black balancing)
- Alternative for high frame rate: one video amp + ADC **per column**
![[Image Sensors-1791963673827.webp|279]]
>[!info] Functional Blocks
![[Image Sensors-1791964086769.webp|278]]

## Active window

 **Active window / subsampling:** read only window of interest or subsampled pixels; 
	Smalller resolution→ Faster readout.
	![[Image Sensors-1791964506041.webp|521]]

## Readout Modes

- **Rolling shutter:** rows scanned sequentially, not all pixels at same instant → distortion on fast-moving objects / flashes.
- **Global shutter:** entire frame captured at same instant.
## Communication protocols

- **Parallel CMOS:** oldest, multiple data lines + clock/sync, still used in low-speed sensors
- **MIPI CSI-2:** high-speed serial, from mobile, now standard in embedded vision
- **LVDS:** low-voltage differential signaling, good noise immunity at high speed
- To PC: Camera Link, USB3, Gigabit Ethernet

## CMOS APS applications

Camera phones, webcams, machine vision (area + line scan), high-speed motion capture, digital radiography, pill endoscopy, DSLRs.

# 3. CCD vs CMOS

- **CCD pros:** uniformity (less structured noise), higher fill factor (almost all area for light), higher NIR sensitivity
- **CMOS pros:** faster readout (converter per pixel), selectable active window, digital output, less off-chip electronics (amp, ADC, processing on-chip), less power → lower temperature
- **Cost:** custom imager → CCD; large-scale economy → CMOS

