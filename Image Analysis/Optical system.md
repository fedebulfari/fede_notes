---
date: 11-10-2026
subject: Image Analysis
description:
---
															 

# 1. Optical Sensor: Camera

Composed by Screen with order of $10^6$ or more photosensitive elements called pixels (PIXEL = PICture ELement).
	Pixels are optical $\to$ electric transducers, plus electric circuits collecting the signal.
Optical system selects a single direction of incoming light at each element.
	30-60 frames per second, even more in special cameras.

# 2. Single Lens Model

Simplified model: single simple  lens = intersection of two spheres, axial symmetric around the optical axis.

![[Optical system-1791738697985.webp|581]]

The Light ray has to pass first through air, then glass, then air again, therefore it's being refracted two time

Geometry: radii $\rho_1, \rho_2$, heights $y_1, y_2$:$$\alpha_1 = \frac{y_1}{\rho_1}\\ \alpha_2 = -\frac{y_2}{\rho_2}$$Making the hypothesise that:
- thin lens: very short light path inside, so $y_1 = y_2 = y$.
- small angles: $\sin \theta \cong \theta$.

We can assume:$$y_{1}=y_{2}=y$$

> [!info] Snell law:
> $n_1 \sin \theta_1 = n_2 \sin \theta_2$, with small-angle approximation:$$\frac{\theta - \alpha_1}{\theta' - \alpha_1} \cong \frac{\sin(\theta - \alpha_1)}{\sin(\theta' - \alpha_1)} = n \\ \frac{\sin(\theta' - \alpha_2)}{\sin(\theta'' - \alpha_2)} \cong \frac{\theta' - \alpha_2}{\theta'' - \alpha_2} = n$$
> _n: Light refraction index of the material_

So the Deviation angle $\delta \theta = \theta'' - \theta$ for the Snell law is:$$\delta \theta = (n-1) Y \left( \frac{1}{\rho_1} + \frac{1}{\rho_2} \right)$$
In particular, for $Y= 0 \to \delta \theta = 0$: ray through centre is un-deviated.

![[Optical system-1791740538486.webp|415]]

# 3. Focalization of Parallel Rays

All parallel rays crossing the lens concur at a common point on the focal plane $Z = -f$.

With $\delta \theta = \frac{y}{f}$:$$f = \frac{1}{(n-1)(\frac{1}{\rho_1} + \frac{1}{\rho_2})} \text{: focal distance.}$$

Same plane for any direction of parallel rays. Parallel rays = rays from a point at infinite distance.

![[Optical system-1791740662290.webp|416]]

# 4. Focalization at Finite Distance and Screen Placement

For a point $P$ at finite distance $Z$, focused at distance $r$:$$\frac{1}{Z} + \frac{1}{r} = \frac{1}{f}$$
![[Optical system-1791740843861.webp|401]]

> [!warning] Screen placement
> If the screen is NOT placed at $Z = r$, rays diffuse $\to$ blurred image.
> 
> Hence: place the screen where parallel rays converge, i.e. at $Z = -f$, valid when $Z(P) \gg$ lens aperture so subjects are in focus. Other depths are blurred; stopping down the aperture reduces blur but close objects stay hard to focus.

# 5. Pin-hole Camera Model

Assumptions:
- thin lens, small angles, plus observed points distant from lens: $Z(P) \gg$ lens aperture.
- screen at $Z = -f$.

Then the image of $P$ is where the undeviated ray hits the focal plane:
- $p =$ image plane $\cap$ line $(O,P)$
- viewing ray of $p$: line $(O,p)$, locus of scene points projecting onto $p$.

Our simplified model is therefore: thin spherical lens + small angles + $Z(P) \gg a$ + $Z = -f$ $\to$ PIN-HOLE CAMERA.

Projection with $Z = -f$:
- $x = f \frac{X}{Z}$
- $y = f \frac{Y}{Z}$

# 6. Central Projection: what You See IS NOT what You Get

Central projection is:
- non-linear
- not shape-preserving
- not length-ratio preserving

> [!warning] Be careful
> It maps $P$ onto $p$ on line $(O,P)$. We imagine image = scaled version of object, but:
> - parallel lines DO NOT project onto parallel lines
> - circumferences DO NOT project onto circumferences
> - midpoints DO NOT project onto midpoints
> - orthogonal lines DO NOT project onto orthogonal lines
> - sphere outlines DO NOT project onto circumferences
> 
> ![[Optical system-1791747117960.webp|358]]
> 
> Exception: planar scene parallel to image plane, $Z = Z_o =$ const:
> - $x = f \frac{X}{Z_o} = k X$, $y = f \frac{Y}{Z_o} = k Y$
> - image is a scaled version: same shape, angles preserved.
> 
> So to estimate SHAPE from image we need the geometry of projection.

---
Related: [[_Image Analysis MOC]]
Source: [[IACV 2026 - B - Camera Optical System.pdf]]
