---
date: 28-10-2026
subject: Sensor System
description: Thermal transducers — RTDs (sensitivity, temperature coefficient, resistance-temperature law, 2-, 3- and 4-wire lead configurations, Wheatstone and wire bridges, self-heating, pros and cons), NTC and PTC thermistors (exponential characteristic, switching point, applications, pros and cons) and thermocouples (Seebeck effect, Seebeck coefficient, measured voltage and standard types).
---

# Temperature Sensors

> [!summary] Overview
> The note compares the three ways of turning temperature into an electrical signal. The **RTD** is a metal resistor with an almost linear law $R = R_0(1+\alpha\Delta T)$: sensitivity $S$ and temperature coefficient $\alpha$ are material constants, and accuracy depends on the wiring — **2-wire** keeps the lead resistance, the **3-wire** scheme cancels it by differencing two readings, and the **4-wire** one removes it entirely — or on reading the small $\Delta R$ with a **Wheatstone** or **wire bridge**, where the 2- and 3-wire versions leave a residual error $\varepsilon$. **Thermistors** are ceramics with a strongly non-linear exponential characteristic: **NTC** falls with temperature ($\beta$ law) and serves measurement, compensation, level sensing and inrush limiting, while **PTC** stays flat until the switching point and is used for overcurrent protection and battery charging. The **thermocouple** instead relies on the **Seebeck effect**: the hot end of two dissimilar metals drives an electron diffusion, so $\Delta V = \int S_{AB}(T)\,dT$ with $S_{AB}$ the difference between the two Seebeck coefficients — the voltage is a differential, self-powered measurement over the widest range of the three, at the price of a small signal and the need to know the reference-junction temperature.

## 1. RTDs

[incomplete]

**Sensitivity**: quantity characteristic of a specific RTD
$$S=\frac{\Delta R}{\Delta T}\quad \left[ \frac{\Omega}{°C} \right]$$
**Temperature coefficient**: quantity characteristic of a specific material — usually positive in RTDs
$$\alpha = \frac{R_{100}-R_0}{100\,^{\circ}\mathrm{C}\cdot R_0} = \frac{S}{R_0} \qquad \left[\frac{\Omega}{^{\circ}\mathrm{C}}\right]$$
**Characteristic equation**:
$$\begin{aligned} R_{RTD} &= R_0(1+\alpha\,\Delta T) = R_0 + \Delta R \\ &\implies \Delta R = \alpha\,R_0\,\Delta T \end{aligned}$$

### 1.1. Temperature Coefficient

![[Temperature sensors-1793173223903.webp|543]]

### 1.2. Measuring Circuits

There are various possible setup:
1. Lead wires setup:
	- **2 lead wires**:
		Least accurate 'cause of the impossibility of eliminating the wire resistance from the measurement $$R_{means}=R_{L_{1}}+R_{L_{2}}+R_{RTD}$$
		 ![[Temperature sensors-1793173294611.webp|253x168]]
		_Used with small lead wires or where we don't need accuracy_
	- **3 lead wires**: thanks to the third wire we can compute and remove the average wire resistance.$$RA = R_{L1} + R_{L2} +R_{RTD} \\ R_B = R_{L2} + R_{L3} \\ R_{}{meas} = R_A - R_B = R_{RTD}$$
		![[Temperature sensors-1793173636664.webp|279]]
		_Is the most used in industrial application_
	- **4 lead setup**: we are able to remove the actual resistance making the measurement pure
		The input impedance of the voltage measurement circuitry must be high enough to prevent any significant current flow in the voltage leads.$$R_{means}=R_{RTD}=R_{0}+\Delta R \\ V_{CD}=I{R_{C}}$$[Incomplete]
		![[Temperature sensors-1793173728485.webp|286]]
		_It is used primarily in laboratory where close accuracy is required_
2. **Differential readout setup**:
	- **Wheatstone bridge**:
		![[Temperature sensors-1793174405054.webp|287]]
		
		We don't have an input current but an input current
		
		$R_{x0}$ nominal value of $R_x$ → $R_{x}=R_{x_0}+\Delta R$
		In order to have $V_{out} =0$ when $R_ x = R_ {x0}$ :
		$$\frac{R_{2}}{R_{3}}=\frac{R_{1}}{R_{x_{0}}}$$
		Considering $R_1=R_2$ and $R_3=R_{x_0}$:$$V_{out}=V_{s}\left[\frac{R_{x_0}+\Delta R}{R_1+R_{x_0}+\Delta R}-\frac{R_{x_0}}{R_1+R_{x_0}}\right]=V_{s}\cdot\frac{R_1}{(R_1+R_{x_0})^{2}}\cdot\frac{\Delta R}{1+\frac{\Delta R}{R_1+R_{x_0}}}$$$$V_{out}\approx V_{s}\cdot\frac{R_1}{(R_1+R_{x_0})^{2}}\cdot\Delta R=V_{s}\cdot\frac{R_1}{(R_1+R_{x_0})^{2}}\cdot\alpha R_{x_0}\,\Delta T$$
		Choosing $R_{1}=R_{2}=R_{3}=R_{x_{0}}$ then:$$V_{out}=\frac{1}{4}\cdot \frac{\Delta R}{R_{x_{0}}}V_{s}$$
	- **Wire-brige**:
		Ideally $R_{L}=0$ (balancing resistors $R_1=R_2=R_3=R$)
		$$V_{out}=V_{S}\left(\frac{R+\Delta R}{2R+\Delta R}-\frac{1}{2}\right)$$
		- **2-wire bridge**:
			![[Temperature sensors-1793175025534.webp|389]]
			$$V_{out-2w}=V_{S}\left(\frac{R+\Delta R+2R_{L}}{2R+\Delta R+2R_{L}}-\frac{1}{2}\right)$$$$\varepsilon=V_{out-2w}-V_{out}=V_{S}\frac{2R_{L}R}{(2R+\Delta R)^{2}\left(1+\frac{2R_{L}}{2R+\Delta R}\right)}\approx V_{S}\frac{R_{L}}{2(R+R_{L})}$$
		- **3-wire bridge**:
			![[Temperature sensors-1793175015517.webp|400]]
			$$V_{out-3w}=V_{S}\left(\frac{R+\Delta R+R_{L}}{2R+\Delta R+2R_{L}}-\frac{1}{2}\right)$$$$\varepsilon=V_{out-3w}-V_{out}=V_{S}\frac{-R_{L}\,\Delta R}{(2R+\Delta R)^{2}\left(1+\frac{2R_{L}}{2R+\Delta R}\right)}\approx -V_{S}\frac{R_{L}}{2(R+R_{L})}\cdot\frac{\Delta R}{2R}$$

### 1.3. Self Heating

[incomplete]

### 1.4. RTDs Pros and Cons

- **Pro**:
	- High linearity 
	- High accuracy 
	- Great repeatability 
	- High sensitivity 
	- Moderate price
- **Cons**:
	- Narrow measuring range particularly at the high end 
	- Require an external power source 
	- Slow response time 
	- Self-heating

## 2. Termistors

Thermistor = thermally sensitive resistor in which its primary function is to exhibit a change in electrical resistance with a change in body temperature.

Two basic types of thermistors: 
- **NTC thermistors** = ceramic semiconductors (transition metal oxides), which decrease in resistance as the temperature increases. 
- **PTC thermistors** = resistors generally made of polycrystalline ceramic materials, which increases in resistance as the temperature increases.

Thermistors have a strong non-linear characteristic.

### 2.1. NTC

Can be found as:
- Disk
- Bead/Chip
- SMDs: used to measure the temperature of a circuit it self

#### 2.1.1. Characteristic

![[Temperature sensors-1793175956731.webp|393]]
$$R(T)=R_{25}\cdot e^{\beta\left(\frac{1}{T}-\frac{1}{T_{25}}\right)}$$

- $R_{25}$: resistance at $25°$
- $\beta$: thermistor constant (depends on material)
- $T$: temperature expressed in Kelvin
- $T_{25}=298.15\ \mathrm{K}$

#### 2.1.2. Application

- **Temperature Measurement**: Low-cost temperature measurement applications.
- **Temperature Compensation**: Precision circuits, which require temperature compensation (i.e., Oscillators, LCD displays, battery under charge and some amplifiers). 
- **Fluid Level Applications**: To sense the presence or absence of a liquid by using the difference in dissipation constants between a liquid and a gas. 
- **Inrush Current Limiter**: Disc NTC subjected to a change in power will experience a time lag before reaching a lower resistance. This time lag can be utilized to limit the inrush surge current (the larger the part, the greater the lag).

### 2.2. PTC

The PTC thermistor exhibits only a slight change of resistance with temperature until the “switching point” is reached at which point an increase of several orders of magnitude in resistance occurs

#### 2.2.1. Characteristic

![[Temperature sensors-1793176245361.webp|334]]

	$Tc$: Curie temperature -- the temperature at which resistance becomes twice the minimum resistance ($R_{min}$

#### 2.2.2. Applications

- **Overcurrent Protection (Polyfuse)**: When a fault condition occurs, PTC will heat up causing it to switch from a low to a very high resistance. 
- **Battery Management**: As a rechargeable battery becomes fully charged, its temperature increases and the RTD increases rapidly reducing the charge to a very low level.
	![[Temperature sensors-1793176445553.webp|347]]

#### 2.2.3. Thermistors Pros and Cons

- **Pros**:
	- High sensitivity (higher than RTD) 
	- Very moderate price 
	- Robust signal
- **Cons**: 
	- Very narrow measuring range (-100°C – 500°C) 
	- Low stability and linearity 
	- Medium accuracy 
	- Medium response time
	- Self-heating

## 3. Thermocouple

The physical principle behind the thermocouple is the Seedbeck effect.

### 3.1. Seedbeck Effect

A temperature difference between two points in a conductor or semiconductor results in a voltage difference between these two points.
![[Temperature sensors-1793176793068.webp|627]]
The electrons in the hot region are more energetic, therefore there will be a net diffusion of electrons from hot to cold and so a change in voltage following the Mott formula.

**Sensitivity**: $$S(T)=\frac{dV}{dT}$$
_The sign represents the potential of the cold side with respect to the hot side_

So $\Delta V$ will be:
$$\Delta V=\int_{T_0}^{T}S(T)\cdot dT$$

| Metal | $S$ at 0°C ($\mu\mathrm{V\,K^{-1}}$) | $S$ at 27°C ($\mu\mathrm{V\,K^{-1}}$) |
| --- | --- | --- |
| Al | -1.60 | -1.8 |
| Pt | -4.45 | -5.28 |
| Constantan | -39.90 | -35.00 |

> [!Example] Principle
> ![[Temperature sensors-1793177380434.webp|507x204]]
> _Al: Alluminium_

![[Temperature sensors-1793177935639.webp|383]]

$$\Delta V_{meas}=\Delta V_{lead}+\Delta V_{B}-\Delta V_{A}-\Delta V_{lead}=\Delta V_{B}-\Delta V_{A} \quad\Rightarrow\quad \Delta V_{meas}=\int_{T_{R}}^{T_{M}}\big(S_{B}(T)-S_{A}(T)\big)\,dT=\int_{T_{R}}^{T_{M}}S_{AB}(T)\,dT$$
$$S_{AB}(T)=S_{B}(T)-S_{A}(T)$$

### 3.2. Types

![[Temperature sensors-1793178077416.webp|602]]

---
Related: [[_Sensor System MOC]]
Source:[[04 - Temperature sensors - Part 1.pdf]]