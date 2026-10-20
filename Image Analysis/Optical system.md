---
date: 11-10-2026
subject: Image Analysis
description: Camera optical system — thin spherical lens model, Snell's law, focalization, Fresnel law, pinhole camera model, and geometric distortions of central projection.
---

# 1. Optical Sensor: Camera

- **Screen:** Composed of an array (on the order of $10^6$ or more) of photosensitive elements called **pixels** (_PIXEL = PICture ELement_).
	- Pixels act as optical $\to$ electric transducers.
	- Electric circuits collect the signal generated at the pixels at **30–60 frames per second** (or more in special high-speed cameras).

- **Optical system:** Enables the selection of a single direction of incoming light at each pixel element.

# 2. Simplified Single Lens Model

A simplified camera lens is modeled as the intersection of two spheres of radii $\rho_1, \rho_2$, axially symmetric around the **optical axis** ($Z$-axis).

![[Optical system-1791738697985.webp|581]]

A light ray crossing the lens undergoes two refractions:

1. **Air–glass refraction** at height $y_1$ on the first spherical surface.
2. **Glass–air refraction** at height $y_2$ on the second spherical surface.


**Model Hypotheses:**

- **Thin lens:** The light path inside the lens is very short, so the entry and exit heights coincide:

$$y_1 = y_2 = Y$$

- **Small angles (paraxial approximation):** $\sin \theta \cong \theta$. The angles $\alpha_1, \alpha_2$ between the **surface normals** and the optical axis at heights $y_1, y_2$ are given by:
$$\alpha_1 = \frac{y_1}{\rho_1} = \frac{Y}{\rho_1}, \quad \alpha_2 = -\frac{y_2}{\rho_2} = -\frac{Y}{\rho_2}$$

> [!info] Snell's Law and Ray Deviation When a light ray crosses the boundary between two media with refractive indices $n_1, n_2$, it obeys **Snell's Law**: $n_1 \sin \theta_1 = n_2 \sin \theta_2$ (where $\theta_1, \theta_2$ are measured with respect to the surface normal).
>
> Let $\theta$ be the angle of the incident ray in air ($n_{air}=1$), $\theta'$ the angle of the refracted ray inside the lens (refractive index $n$), and $\theta''$ the angle of the exiting ray in air. Under the small-angle approximation:
>
> $$\begin{aligned} > \text{1st refraction (air $\to$ glass):} \quad & \frac{\theta - \alpha_1}{\theta' - \alpha_1} \cong \frac{\sin(\theta - \alpha_1)}{\sin(\theta' - \alpha_1)} = n \implies \theta - \alpha_1 = n(\theta' - \alpha_1) \\ > \text{2nd refraction (glass $\to$ air):} \quad & \frac{\theta'' - \alpha_2}{\theta' - \alpha_2} \cong \frac{\sin(\theta'' - \alpha_2)}{\sin(\theta' - \alpha_2)} = n \implies \theta'' - \alpha_2 = n(\theta' - \alpha_2) > \end{aligned}$$

Subtracting the two linear equations eliminates $\theta'$ and yields the **total deviation angle** $\delta \theta = \theta'' - \theta$:
$$\delta \theta = \theta'' - \theta = (n-1)(\alpha_1 - \alpha_2) = (n-1) Y \left( \frac{1}{\rho_1} + \frac{1}{\rho_2} \right)$$
- **Undeviated ray:** For $Y = 0 \implies \delta \theta = 0$, meaning any ray passing through the optical center $O$ of the lens is undeviated.

![[Optical system-1791740538486.webp|415]]

# 3. Focalization of Parallel Rays

All parallel rays crossing the lens (i.e. rays coming from a single point at $\infty$ distance) concur at a common point on the **focal plane** $Z = -f$.

For small angles, $f \delta \theta = Y$ ($\delta \theta = \frac{Y}{f}$), which defines the **focal distance** $f$:
$$f = \frac{1}{(n-1)\left(\frac{1}{\rho_1} + \frac{1}{\rho_2}\right)}$$

The focal plane $Z = -f$ is the same for any direction of incoming parallel rays.

![[Optical system-1791740662290.webp|416]]

# 4. Focalization at Finite Distance and Screen Placement

For a scene point $P$ at a finite distance $Z$ from the lens, the rays passing through the lens converge at a distance $r$ behind the lens according to the **Fresnel Law**:
$$\frac{1}{Z} + \frac{1}{r} = \frac{1}{f}$$

![[Optical system-1791740843861.webp|401]]

> [!warning] Screen Placement & Blur
>
> - If the sensor screen is **not** placed at distance $r$, rays from $P$ do not converge to a single point on the screen but diffuse over an area $\to$ **blurred image**.
>
> - **Distant scene approximation:** When observed points are far from the lens compared to the lens aperture $a$ ($Z(P) \gg a$), we have $r \approx f$, so we place the screen at the focal plane **$Z = -f$** where parallel rays converge.

# 5. Pin-Hole Camera Model

**Model Assumptions:**
1. Thin spherical lens.
2. Small angles.
3. Distant observed points: $Z(P) \gg a$ (where $a$ is the lens aperture).
4. Screen (image plane) placed at the focal plane $Z = -f$.

**Geometric Projection:**
- The image $p$ of a 3D scene point $P = [X, Y, Z]^T$ is the point where the **undeviated ray** passing through the optical center $O$ hits the image plane:
$$p = \text{image plane} \cap \text{line}(O,P)$$

- **Viewing ray of $p$:** $\text{line}(O,p)$, which is the locus of all 3D scene points projecting onto the same image point $p$.
- **Pinhole Projection Equations:** Taking the principal point $c$ (intersection of the optical axis $Z$ with the image plane) as the 2D origin on the image plane, triangle similarity gives:
$$x = f \frac{X}{Z}, \quad y = f \frac{Y}{Z}$$

# 6. Central Projection: "What You See IS NOT What You Get"

Due to the division by depth $Z$, central projection is:
- **Non-linear**
- **Not shape-preserving**
- **Not length-ratio preserving**

> [!warning] Geometric Distortions of Central Projection Intuitively we might think of an image as a scaled version of the observed object, but in general:
>
> - Parallel lines **DO NOT** project onto parallel lines (they converge at vanishing points).
>
> - Circumferences **DO NOT** project onto circumferences.
>
> - Midpoints **DO NOT** project onto midpoints.
>
> - Orthogonal lines **DO NOT** project onto orthogonal lines.
>
> - Sphere outlines **DO NOT** project onto circumferences.
>
>
> ![[Optical system-1791747117960.webp|358]]
>
> **Exception — Planar Scene Parallel to the Image Plane ($Z = Z_o = \text{const}$):**
>
> - $x = f \frac{X}{Z_o} = k X, \quad y = f \frac{Y}{Z_o} = k Y$ (with constant scale factor $k = \frac{f}{Z_o}$).
>
> - Only in this case is the image a scaled version of the scene, preserving **shape** and **angles**.
>
>
> Consequently, to estimate the true **shape** of observed objects from general views, we must study the **Projective Geometry of Central Projection**.

---
Related: [[_Image Analysis MOC]] 
Source: [[IACV 2026 - B - Camera Optical System.pdf]]