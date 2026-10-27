---
date: 14-10-2026
subject: Sensor System
description: CCD and CMOS image sensors — MOS-capacitor pixels, quantum efficiency, dark current, well capacity, blooming, charge transfer efficiency, readout and reset noise with CDS, Bayer filtering, and active-pixel architecture.
---

# Image Sensors

> [!summary] Overview
> This note compares the two dominant image-sensor architectures. The **CCD** is an array of MOS capacitors whose charge packets are shifted to a common output; performance is grouped by charge generation (**quantum efficiency**, pixel uniformity, dark current), collection (well capacity, linearity, blooming), transfer (**CTE**/**CTI**, defects) and readout noise (reset $kTC$, removed by **correlated double sampling**), plus Bayer colour filtering and full-frame/frame/interline variants. The **CMOS active pixel sensor** instead puts a photodiode and amplifier in every pixel, trading fill factor for speed, selectable windows and on-chip processing — hence rolling versus global shutter and MIPI/LVDS links.

## 1. Charge Coupled Device (CCD)

![[Image Sensors-1791960351242.webp|511]]

### 1.1. CCD Pixel: MOS Capacitor

- Electrodes + depleted insulator region.
- **Unbiased:** no current flow → free carriers recombination.
- **Biased:** free carriers generate a current similarly to a photodiode.

### 1.2. Photon Absorption

When a photon is absorbed, it generates an electron-hole pair → photocurrent.
Differently from photodiodes, electrons are stopped by the insulator at the n-doped side.
Equivalent model: see slide 5.

### 1.3. Front / Back Side Illumination

- **Front side illuminated (Standard Wafer):** n-type Si / p-type Si / SiO2 insulating layer / polysilicon electrodes. Light must pass electrodes.
- **Back side illuminated (Thinned Wafer):** same stack + anti-reflective (AR) coating, illuminated from back. Enables 3D vertical integration, better QE.

### 1.4. CCD Structure and Readout

CCD structure: array of MOS capacitors where charge is shifted vertically then horizontally to output (see slides 7-14).

Readout steps 1-6: charge packets are sequentially shifted from pixel to pixel toward First / Last output node then to OpAmp.

### 1.5. CCD Performance

4 groups:
1. **Charge generation:** Quantum Efficiency (QE), Pixel Uniformity, Dark Current
2. **Charge collection:** Well Capacity, Pixel Size, Linearity, Blooming
3. **Charge transfer:** Charge Transfer Efficiency (CTE), Defects
4. **Charge readout:** Readout Noise

#### 1.5.1. Charge Generation: Quantum Efficiency

$$QE = \frac{detected\ photons}{incident\ photons}$$

Probability that a photoelectron will be released for each incident photon.

Mechanisms which hamper photon collection:
- Reflection
- Absorption
- Transmission

#### 1.5.2. Charge Generation: Pixel Uniformity

Fixed pattern noise.
The sensitivity of pixels is not the same, for reasons such as differences in thickness, area of electrodes, doping, bias.
However these differences do not change, and can be calibrated out by dividing by a flat field, which is an exposure of a uniform light source.

#### 1.5.3. Charge Generation: Dark Current

Thermal effects cause an electron to move from the valence band to the conduction band.
The majority of dark current is created near the interface between the Si and the SiO2, where interface states at energy between the valence and conduction bands act as a stepping stone for electrons.

> [!info] Strongly temperature dependent: 
> Electrons per pixel per hour drops rapidly when cooling (see plot slide 18, from -110°C to -40°C).

#### 1.5.4. Charge Collection: Well Capacity

Well capacity = maximum charge that can be held in a pixel.
Typically, it is about $10,000\ electrons/\mu m^2$ → a few hundred thousand electrons per pixel.

Example: $V_{cell} = 5V$, pixel size = $5\mu m \times 5\mu m$, $C_{OX}/A = 35 nF/cm^2$:

$$\frac{Q}{A} = \frac{C_{ox}}{A} \cdot V_{cell} = 35nF/cm^2 \cdot 5V \approx 175\ nC/cm^2 \approx 11,000\ e^-/\mu m^2$$

→ $Q \approx 300,000\ e^-$

Saturation = when a pixel has accumulated the maximum amount of charge that it can hold.

- > 80% → non-linear response

- > 100% → blooming

#### 1.5.5. Charge Collection: Blooming

Blooming occurs mainly vertically, as there is little horizontal bleeding because of the permanent doped channel stops.
Example: bloomed star images.

#### 1.5.6. Charge Transfer: Efficiency / Inefficiency

Charge Transfer Efficiency (CTE) = fraction of electrons transferred from one pixel to the next (typically 0.9999 to 0.999999).

Charge Transfer Inefficiency (CTI) = fraction of electrons deferred by one pixel.
$$CTI = 1 - CTE \quad (typically\ 10^{-6}\ to\ 10^{-4})$$
→ charges are trapped by defects in the silicon crystal lattice.

Example: CTE = 0.99999, 12 Mpixel (about 3.5 kpixel × 3.5 kpixel). CTI in the worst case (about 7,000 transfers):
$$CTE_{TOT} = 1 - 0.99999^{7000} = 6.7\%$$

Part of the original image is smeared with an exponential decay function, producing "tails": original image after n transfers — good CTE vs bad CTE.

#### 1.5.7. Charge Transfer: Dark Columns and Other Defects

Dark columns: Defects caused by "traps" that block the vertical transfer of charge during image readout. Dark columns are removed by calibration.

Other defects:
- **Bright columns:** Caused by traps. Electrons contained in such traps can leak out during transfer causing a vertical streak.
- **Hot Spots:** Pixels with higher than normal dark current. Their brightness increases linearly with exposure times.
- **Cluster of Hot Spots / Cosmic rays / Bright Column**
- Somewhat rarer are light-emitting defects which are hot spots that act as tiny LEDs and cause a halo of light on the chip.

### 1.6. Readout Noise

Mainly due to amplifier noise. It can be reduced by reducing the bandwidth (slower readout).

Example: rate at which one pixel is read by the CCD $f_s = 500 kHz$ → $T_s = 2 \mu s$. Assuming 12 Mpx → $T_{readout} = 2\mu s \times 12 Mpx = 24s$ !!

The readout circuit consists of a storage capacitor, a reset transistor and a voltage amplifier or buffer (in this example a source follower).

#### 1.6.1. Reset Noise

Noise associated with recharging the output storage capacitor:
$$\sigma Q_{reset}=\sqrt{ kTC }$$
where C is the output capacitance.

We can remove the noise by a practice called **Correlated Double Sampling**:
The output voltage is measured after reset and again after readout. By subtracting the first value from the second we obtain a measurement without reset noise.
![[Drawing 2026-10-14 08.55.32.excalidraw|300]] $\Delta V$

### 1.7. Color Filtering

Various methods.
Bayer array (most common RGB filter)
![[Image Sensors-1791961262598.webp|318]]

Since the human eye is more sensitive to green than to the other two colors, the Bayer array has twice as many green color filters. This also means that with the Bayer array, the human eye can detect more detail than if the three colors were used in equal measures in the filter.

> [!info] Demosaicing algorithm
> Needed to fill the gap between two pixels by making an average of the three different values.

### 1.8. Types of CCD

- **Full frame**: entire chip is exposed to light. Readout requires shifting the charge both vertically and horizontally. Slow, and signal is corrupted during readout because light keeps arriving → mechanical shutter needed.
- **Frame transfer**: upper (or lower) half of the array is shielded from light, so imaging happens only in the uncovered part. Fast vertical transfer from uncovered to masked region, then slow readout from the masked region.
- **Interline transfer:** every other line is shielded from light. The uncovered line is transferred to the adjacent masked line for readout — even faster transfer than frame transfer.
	Since the resulting pixels are rectangular the vertical pitch is double the horizontal one; we need to do an average of adjacent pixels to compensate the gap.
	![[Image Sensors-1791962308534.webp|135]]

### 1.9. CCD Applications

- Digital cameras
- Optical scanners
- Microscopy and biology
- Astrophotography (galaxies, nebulae)
- Infrared photography (night vision, VLSI testing)

## 2. CMOS Active Pixel Image Sensor

### 2.1. Active Pixel Sensor (APS)

Both photodiode **and readout amplifier in each pixel**: charge accumulated by photodiode is converted to amplified voltage inside the pixel, then transferred by rows/columns to analog signal processing.

Main pixel components:
- Photodiode
- 3 transistors
- Busses
- Bayer filter
- Micro-lens [!incomplete]
![[Image Sensors-1791964040671.webp|242]]

> Fill factor ≈ 30% (photosensitive area / total pixel area, rest is transistors) — much lower than CCD.

![[Image Sensors-1791962560250.webp|134]]

### 2.2. 3-transistor (3T) Pixel

- **M1 – Reset:** restores initial condition before exposure
- **M2 – Source-follower amplifier:** load common to all pixels in a column
- **M3 – Row-select:** connects pixel output to column bus for readout
![[Image Sensors-1791962540060.webp|274]]
All pixels in a column share one column amplifier.
![[Drawing 2026-10-14 09.31.09.excalidraw|250]]
[!incomplete]

### 2.3. Noise Sources

- **Fixed Pattern Noise (FPN):** variation in photodiode efficiency + mismatch in source-follower performance. Constant and reproducible → removed by flat-field correction (on-chip subtraction of uniform-illumination image).
- **Reset noise (kTC noise):** $$\upsilon_{n}=\sqrt{ \frac{KT}{C} }$$
- **Amplifier noise (1/f noise)**
- **Photodiode shot noise**

### 2.4. Sensor Structure and Functional Blocks

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

> [!info] Functional Blocks
> ![[Image Sensors-1791964086769.webp|278]]

### 2.5. Active Window

**Active window / subsampling:** read only window of interest or subsampled pixels;
Smaller resolution → Faster readout.
![[Image Sensors-1791964506041.webp|521]]

### 2.6. Readout Modes

- **Rolling shutter:** rows scanned sequentially, not all pixels at same instant → distortion on fast-moving objects / flashes.
- **Global shutter:** entire frame captured at same instant.

### 2.7. Communication Protocols

- **Parallel CMOS:** oldest, multiple data lines + clock/sync, still used in low-speed sensors
- **MIPI CSI-2:** high-speed serial, from mobile, now standard in embedded vision
- **LVDS:** low-voltage differential signaling, good noise immunity at high speed
- To PC: Camera Link, USB3, Gigabit Ethernet

### 2.8. CMOS APS Applications

Camera phones, webcams, machine vision (area + line scan), high-speed motion capture, digital radiography, pill endoscopy, DSLRs.

## 3. CCD vs CMOS

- **CCD pros:** uniformity (less structured noise), higher fill factor (almost all area for light), higher NIR sensitivity
- **CMOS pros:** faster readout (converter per pixel), selectable active window, digital output, less off-chip electronics (amp, ADC, processing on-chip), less power → lower temperature
- **Cost:** custom imager → CCD; large-scale economy → CMOS

![[Image Sensors-1791964983553.webp|427]] ![[Image Sensors-1791964995643.webp|448x237]]

---
Related: [[_Sensor System MOC]]
Source: [[03 - Image sensors.pdf]]