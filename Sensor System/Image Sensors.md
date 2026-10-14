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

- **Full frame**: all the pixel are axpoised to the lite; to readout we need to exange the charge both verticaly and horizontaly. Slaw and poossibly out of focus cause during the readout 'cause of the light still coming(prevented by using mechanical shatter).
- **Frame transfer**: only half the array is exposed to light, therefore half the resoolution.  On the other hand to make the readout we need to do only a vertical trasfer. Fast trasfer from the two reagion and then slow readout from masked region.
- **Interline transfer:** one line and one not is masked. even faster transfer then the Frame transfer. Since the combination of the adiacent pixels makes rettagular form the pitch of vertical pixel is double the hotizontal one; we need to do an avarage between the lighted pixel to then fill the gap created by the masked one.