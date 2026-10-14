![[Image Sensors-1791960351242.webp|511]]
[!uncoplete]
## Reset Noise
Noise associated with recharging the output storage capacitor:
$$𝜎Q_{reset}=\sqrt{ kTC }$$
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
- **Interline transfer:** every other line is shielded from light. The uncovered line is transferred to the adjacent masked line for readout — even faster transfer than frame transfer. Since the resouling pixels are retttangular the vertical pithc is double the horizontal one; we need to do an avarage of adiacating pixel to compensate the gap.
	![[Image Sensors-1791962308534.webp|135]]

# 2. CMOS active image sensor

