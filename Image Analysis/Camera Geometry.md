---
date: 11-10-2026
subject: Image Analysis
description: Single-view camera geometry — the projective camera P = K[R t], backprojection and the vanishing point theorem, intrinsic and extrinsic calibration through the IAC, plane-to-image homographies, Zhang calibration, rectification from vanishing points, PnP localization, plus symmetry (harmonic tuples) and polarity.
---

# Camera Geometry

> [!summary] Overview
> A camera is a **central projection** $\mathbb{P}^3 \to \mathbb{P}^2$: linear in homogeneous coordinates, but a $3\times4$ matrix, hence **not invertible** — from a pixel we recover only its **viewing ray**, never the 3D point. Pixels add intrinsics (offset, unit change, aspect ratio) to the pinhole, collected in the **calibration matrix** $K$; the pose adds extrinsics, so $P = K[R\,|\,\mathbf{t}] = [M\,|\,\mathbf{m}]$. Everything else follows: the **vanishing point theorem**, angles between rays through the **IAC** $\omega = (KK^T)^{-1}$, the **plane-to-image homography** $H = K[\mathbf{r}_{\pi1}\ \mathbf{r}_{\pi2}\ \mathbf{o}_\pi]$, three calibration routes (Zhang, plane + camera centre, rectified face + normal vanishing point), rectification $H_R = R_\pi^T K^{-1}$ and localization (planar pose, PnP, DLT). Two appendices extend the same toolbox with no new machinery: **symmetry** (harmonic tuples, $CR = -1$) and **polarity**.

## 1. The Projective Camera

The pinhole model maps the scene point $\mathbf{X} = [X,Y,Z]^T$ to the image point on the plane $\Pi$:

$$x = f\,\frac{X}{Z}, \qquad y = f\,\frac{Y}{Z}$$
![[Camera Geometry-1793187261465.webp|416]]
- **Perspective projection:** non-linear, not shape-preserving, not length-ratio preserving.
- **But collinearity is preserved:** three collinear scene points project to three collinear image points.

Collinearity plus planar projective geometry ([[Planar Geometry]]) gives a **linear** mapping in homogeneous coordinates:

$$\mathbf{u} = P_{3\times 4}\,\mathbf{X}, \qquad P_{3\times 4} = [M_{3\times 3}\ |\ \mathbf{m}_{3\times 1}] \in \mathbb{R}^{3\times4}, \quad \text{rank}(P) = 3$$
![[Camera Geometry-1793187425673.webp|438x182]]
- $P$ has **11 dof** (12 entries minus scale).
- $M$ is $3\times3$ and invertible; it maps directions, not points.
- $\lambda\mathbf{u} \sim \mathbf{u}$, $\lambda \ne 0$ — a pixel is a *ray* in 3D.

## 2. Backprojection: The Viewing Ray

> [!theorem] Backprojection of an image point
> For $P = [M\,|\,\mathbf{m}]$ the backprojection of $\mathbf{u}$ is the straight line(we assume an homogeneous medium in which the light travels) through the optical centre $O$ with direction $\mathbf{d} = M^{-1}\mathbf{u}$.
![[Camera Geometry-1793188755982.webp|508]]

**Proof.** Any point on the ray is $\mathbf{X}' = O + \lambda\mathbf{X}$, and the projection is linear:

$$P\mathbf{X}' = P O + \lambda\,P\mathbf{X} = P\mathbf{X} = \mathbf{u}$$

so every point of the ray projects to $\mathbf{u}$ through $O=RNS(P)$. From $\mathbf{u} = M\mathbf{X} + \mathbf{m}$ we get $\mathbf{d} = M^{-1}\mathbf{u}$.

**Where is the camera centre($O$)?** It is the point that projects nowhere, i.e. $PO = \mathbf{0}$. Writing $P = [M\,|\,\mathbf{m}]$ in Cartesian form $PO = M + \mathbf{m}\begin{bmatrix} o\\1 \end{bmatrix} =\mathbf{0}$:

$$ o =\begin{bmatrix} x\\y\\z \end{bmatrix}= -M^{-1}\mathbf{m}\qquad (\text{cartesian coordinates})$$

> [!important] One pixel = one ray, not one point
> A $3\times4$ matrix kills one dimension: single-view geometry can never recover depth from one image alone. Everything below (vanishing points, calibration, rectification, symmetry) works *with* this limitation instead of against it.

## 3. Vanishing Points and the Vanishing Point Theorem

Parallel lines in space concur at the point at infinity of their common direction $\mathbf{d}$, i.e. at $\mathbf{X}_\infty = [\mathbf{d}^T, 0]^T$. Its image is the **vanishing point** at the infinity of direction $\mathbf{d}$:

$$\mathbf{V} = P\begin{bmatrix}\mathbf{d}\\0\end{bmatrix} = M\,\mathbf{d} = KR\,\mathbf{d}$$

The direction of the viewing ray of $\mathbf{V}$ is, by §2:

$$M^{-1}\mathbf{V} = M^{-1}M\mathbf{d} = \mathbf{d}$$
![[Camera Geometry-1793190085253.webp|273x105]]

> [!theorem] Vanishing point theorem
> The viewing ray associated with the vanishing point $\mathbf{V}$ of a direction $\mathbf{d}$ is **parallel** to $\mathbf{d}$.

This is the single most used result of the lecture: it converts an image measurement (where two lines meet) into a 3D **direction**, and therefore into a constraint on the camera.

> [!example] Navigation along a corridor
> Take an image of a corridor: its edges concur at $\mathbf{V}$. Knowing $M$ (calibrated camera), the direction to follow is $\mathbf{d} = M^{-1}\mathbf{V}$ — driving towards the vanishing point. $M$ is estimated by intrinsic + extrinsic calibration.

## 4. From the Image Plane to Pixels: The Calibration Matrix

Coordinates on $\Pi$ are in cm, but digital images are in **pixels** and pixels need not be square.

Three corrections:

| Correction                         | Cause                                                                | Effect                                                                                        |
| ---------------------------------- | -------------------------------------------------------------------- | --------------------------------------------------------------------------------------------- |
| Offset $\mathbf{c} = [u_o, v_o]^T$ | principal point (projection of $O$ on $\Pi$) is not the pixel origin | add $\mathbf{c}$                                                                              |
| Different units (cm/pixel)         | $k$ = pixel width, $l$ = pixel height                                | $f_x = f/k$, $f_y = f/l$                                                                      |
| Aspect ratio                       | $k \ne l$                                                            | $a = \dfrac{f_x}{f_y} = \dfrac{l}{k}$ (square pixels $\Rightarrow a = 1$, **natural** camera) |

$$P=[X_{p},Y_{p},Z_{p}]\to p=[x_{p},y_{p}]\qquad 
\begin{cases}
x_p = f_x\,\frac{X_P}{Z_P} + u_o\\ y_p = f_y\,\frac{Y_P}{Z_P} + v_o
\end{cases}\quad \{u_{0},v_{0}\}\text{: pixel coordinates}$$
![[Camera Geometry-1793190693746.webp|336]]
In homogeneous pixel coordinates:

$$\mathbf{u} = \begin{bmatrix} x \\ y \\ w \end{bmatrix} = \begin{bmatrix} f_x & 0 & u_o \\ 0 & f_y & v_o \\ 0 & 0 & 1 \end{bmatrix}\begin{bmatrix} X \\ Y \\ Z \end{bmatrix} = [K\,|\,\mathbf{0}]\,\mathbf{X}_{cam}$$

$$K = \begin{bmatrix} f_x & 0 & u_o \\ 0 & f_y & v_o \\ 0 & 0 & 1 \end{bmatrix} \quad\text{— calibration matrix (intrinsic parameters)}$$
![[Camera Geometry-1793191093775.webp|487x195]]
## 5. The Projection Matrix $P = K[R\,|\,\mathbf{t}]$

In general the world reference frame is **not** the camera frame. Let $(R,\mathbf{t})$ be the rototranslation *camera $\to$ world* (i.e. world with respect to camera):

$$\mathbf{X}_{cam} = \begin{bmatrix} R & \mathbf{t} \\ \mathbf{0}& 1 \end{bmatrix}\mathbf{X}_{world}$$

$$\mathbf{u} = [K\,|\,\mathbf{0}]\begin{bmatrix} R & \mathbf{t} \\ \mathbf{0}& 1 \end{bmatrix}\mathbf{X}_{world} = K[R\,|\,\mathbf{t}]\,\mathbf{X}_{world}$$

$$P = [\,KR \;|\; K\mathbf{t}\,] = [M\,|\,\mathbf{m}], \qquad \boxed{M = KR}, \quad \boxed{\mathbf{m} = K\mathbf{t}}$$

- $K$ — **intrinsic** parameters: do **not** vary under camera displacement.
- $R,\mathbf{t}$ — **extrinsic** parameters(**Rotation** and **translation**): **do** vary under camera displacement.

## 6. What Calibration Gives You

| Calibration           | Known  | Viewing ray direction              | Expressed in     |
| --------------------- | ------ | ---------------------------------- | ---------------- |
| Intrinsic only        | $K$    | $\mathbf{d} = K^{-1}\mathbf{u}$    | **camera** frame |
| Intrinsic + extrinsic | $K, R$ | $\mathbf{d} = (KR)^{-1}\mathbf{u}$ | **world** frame  |
|                       |        |                                    |                  |
**Intrinsic** camera calibration: camera parameters don’t vary under camera displacement
	Estimation of matrix $𝐊$
	 - focal distance $𝑓_𝑋$ 
	 - focal distance $𝑓_𝑌$
	 - principal point $(𝑈_𝑜, 𝑉_𝑜)$ 
	 - skew factor (in old cameras) aspect ratio $𝑎 = 𝑓_𝑋/𝑓_𝑌 = 𝑙/𝑘$ : ratio between pixel height and length

**Extrinsic** camera calibration: camera parameters vary under camera displacement
	Estimation of matrix $𝐑$ and vector $𝒕$ 
	- Camera → World rotation $𝐑$ 
	- Camera → World translation $𝒕$

In all cases all rays pass through the camera centre; a pixel is never a point. Intrinsic calibration already gives the full mapping pixel $\to$ 3D ray direction, which is what rectification and single-view reconstruction need.

## 7. Angles Between Viewing Rays and the IAC

Take two pixels $\mathbf{u}_1, \mathbf{u}_2$ and their directions $\mathbf{d}_i = (KR)^{-1}\mathbf{u}_i$:

$$\cos\theta = \frac{\mathbf{d}_1^T\mathbf{d}_2}{\lVert\mathbf{d}_1\rVert\,\lVert\mathbf{d}_2\rVert} = \frac{\mathbf{u}_1^T (KR)^{-T}(KR)^{-1}\mathbf{u}_2}{\sqrt{\mathbf{u}_1^T (KR)^{-T}(KR)^{-1}\mathbf{u}_1}\;\sqrt{\mathbf{u}_2^T (KR)^{-T}(KR)^{-1}\mathbf{u}_2}}$$

Since $(KR)^{-1} = R^{-1}K^{-1}$ and $R^{-T}R^{-1} = I$, the rotation cancels:

$$(KR)^{-T}(KR)^{-1} = K^{-T}K^{-1} = (KK^T)^{-1}$$

> [!important] The $\omega$ matrix — Image of the Absolute Conic
> $$\boxed{\omega \triangleq (KK^T)^{-1} = K^{-T}K^{-1}}$$
> $\omega$ is symmetric and positive definite. It is the **image of the absolute conic** $\Omega_\infty$ of [[Space Geometry]] (2D analogue: $C^*_\infty$ of [[Planar Geometry]]).
>
> $$\cos\theta = \frac{\mathbf{u}_1^T\omega\,\mathbf{u}_2}{\sqrt{\mathbf{u}_1^T\omega\,\mathbf{u}_1}\;\sqrt{\mathbf{u}_2^T\omega\,\mathbf{u}_2}}$$

**Key consequences**

- Angles between viewing rays do **not** depend on the camera position (only on $K$) — $R$ disappeared.
- Conversely, measuring angles in the image constrains $\omega$, hence calibrates $K$.
- Orthogonal rays ($\theta = 90^\circ$) give a **linear** constraint: $\mathbf{u}_1^T\omega\,\mathbf{u}_2 = 0$.

## 8. Homography Between a Plane and Its Image

Attach the world reference frame to a known plane $\pi$. A point on $\pi$ has homogeneous coordinates $\mathbf{x}_\pi = [x,y,1]^T$ and lifts to 3D as $\mathbf{X}_\pi = [x,y,0,1]^T$:

$$\mathbf{u} = P\mathbf{X}_\pi = K[\mathbf{r}_{\pi1}\ \mathbf{r}_{\pi2}\ \mathbf{r}_{\pi3}\ \mathbf{o}_\pi]\begin{bmatrix}x\\y\\0\\1\end{bmatrix} = K[\mathbf{r}_{\pi1}\ \mathbf{r}_{\pi2}\ \mathbf{o}_\pi]\begin{bmatrix}x\\y\\1\end{bmatrix}$$

$$\boxed{\mathbf{u} = H\,\mathbf{x}_\pi, \qquad H = K[\mathbf{r}_{\pi1}\ \mathbf{r}_{\pi2}\ \mathbf{o}_\pi] = K R_\pi}$$

where $R_\pi = [\mathbf{r}_{\pi1}\ \mathbf{r}_{\pi2}\ \mathbf{o}_\pi]$ is the rototranslation plane $\to$ camera. **A plane and its image are related by a homography** ($8$ dof); by contrast, a full $P$ has 11 dof, so planar scenes are the "easy" case.

### 8.1. Three Special Cases

**a) The plane at infinity $\pi_\infty$** — its points are pure directions $[\mathbf{d}^T, 0]^T$, so the homography collapses to the vanishing points:

$$\mathbf{V} = P\begin{bmatrix}\mathbf{d}\\0\end{bmatrix} = K[R\,|\,\mathbf{t}]\begin{bmatrix}\mathbf{d}\\0\end{bmatrix} = KR\,\mathbf{d} \qquad\Longrightarrow\qquad H_{\pi_\infty} = KR$$

and its inverse gives the direction of any vanishing point: $\mathbf{d} = (KR)^{-1}\mathbf{V}$.

**b) $\pi$ parallel to the image plane** ($\mathbf{r}_{\pi1} = [1,0,0]^T$, $\mathbf{r}_{\pi2} = [0,1,0]^T$):

$$H = \begin{bmatrix}f_x&0&u_o\\0&f_y&v_o\\0&0&1\end{bmatrix}\begin{bmatrix}1&0&X_o\\0&1&Y_o\\0&0&1\end{bmatrix} = K\cdot L$$

where $K$ is a 2D affinity (unit change + offset) and $L$ a 2D translation: $H$ = 2D-affine $\times$ 2D-isometry = **2D affinity** — shape not preserved, parallelism preserved.

**c) $\pi$ parallel to the image plane and a natural camera** ($f_x = f_y = f$, plane rotated by $\theta$):

$$H = \begin{bmatrix}f&0&u_o\\0&f&v_o\\0&0&1\end{bmatrix}\begin{bmatrix}\cos\theta&-\sin\theta&X_o\\ \sin\theta&\cos\theta&Y_o\\0&0&1\end{bmatrix} = \text{2D-similarity}\times\text{2D-isometry} = \textbf{2D-similarity}$$

Shape **is** preserved. This is exactly the target of *rectification* (§13): make the scene plane parallel to a new image plane of a natural camera.

## 9. From $P$ Back to $K$: Cholesky

$P$ contains $K$; recover it without knowing $R$ by using $M = KR$:

$$MM^T = KR\,(KR)^T = KRR^TK^T = KK^T$$

Therefore

$$\omega^{-1} = KK^T = MM^T$$

and the **Cholesky factorization** $\omega^{-1} = KK^T$ returns an upper triangular $K$ — exactly the shape of the calibration matrix. This is the universal last step of every calibration method in §10–12.

## 10. Camera Calibration Through the $\omega$ Matrix

Collect constraints on $\omega$ (5 dof: symmetric $3\times3$ minus scale), then Cholesky.

### 10.1. From Known Angles between Directions

For parallel lines of direction $\mathbf{d}_i$ in the scene, their vanishing points are $\mathbf{v}_i = KR\,\mathbf{d}_i$:

$$\cos\theta = \frac{\mathbf{d}_1^T\mathbf{d}_2}{\lVert\mathbf{d}_1\rVert\lVert\mathbf{d}_2\rVert} = \frac{\mathbf{v}_1^T(KR)^{-T}(KR)^{-1}\mathbf{v}_2}{\sqrt{\mathbf{v}_1^T\omega\mathbf{v}_1}\sqrt{\mathbf{v}_2^T\omega\mathbf{v}_2}} = \frac{\mathbf{v}_1^T\omega\,\mathbf{v}_2}{\sqrt{\mathbf{v}_1^T\omega\mathbf{v}_1}\sqrt{\mathbf{v}_2^T\omega\mathbf{v}_2}}$$

- General known angle $\theta$: one **non-linear** constraint on $\omega$.
- **Orthogonal directions** ($\theta = 90^\circ$): one **linear** constraint $\mathbf{v}_1^T\omega\,\mathbf{v}_2 = 0$.

> [!warning] Do not mix up with 2D geometry
> Two different formulæ look identical:
> - **2D** ([[Planar Geometry]]): $\cos\vartheta = \dfrac{\mathbf{l}'^T C^{*'}_\infty \mathbf{m}'}{\sqrt{\dots}}$ with $\mathbf{l}',\mathbf{m}'$ **image lines** and $C^{*'}_\infty$ the dual conic to the circular points.
> - **3D / this lecture**: $\cos\theta = \dfrac{\mathbf{v}_1^T\omega\,\mathbf{v}_2}{\sqrt{\dots}}$ with $\mathbf{v}_1,\mathbf{v}_2$ **vanishing points** and $\omega$ the IAC.
>
> Same algebra, different objects, different calibration ($K$ vs. rectifying homography).

### 10.2. From Homographies of Known Planar Shapes — Zhang's Method

For a plane-to-image homography $H = [\mathbf{h}_1\ \mathbf{h}_2\ \mathbf{h}_3] = K[\mathbf{r}_{\pi1}\ \mathbf{r}_{\pi2}\ \mathbf{o}_\pi]$:

$$K^{-1}\mathbf{h}_1 = \lambda\,\mathbf{r}_{\pi1}, \qquad K^{-1}\mathbf{h}_2 = \lambda\,\mathbf{r}_{\pi2}$$

and $\mathbf{r}_{\pi1}, \mathbf{r}_{\pi2}$ are **orthogonal** and have **unit norm**. Multiplying out with $\omega = K^{-T}K^{-1}$:

$$\mathbf{h}_1^T K^{-T}K^{-1}\mathbf{h}_2 = 0 \qquad\Longrightarrow\qquad \mathbf{h}_1^T\omega\,\mathbf{h}_2 = 0$$
$$\mathbf{h}_1^T K^{-T}K^{-1}\mathbf{h}_1 - \mathbf{h}_2^T K^{-T}K^{-1}\mathbf{h}_2 = 0 \qquad\Longrightarrow\qquad \mathbf{h}_1^T\omega\,\mathbf{h}_1 - \mathbf{h}_2^T\omega\,\mathbf{h}_2 = 0$$

> [!theorem] Zhang constraints
> Every homography of a known planar shape gives **2 homogeneous linear equations** in the 6 entries of $\omega$. With 5 dof, **at least 3 homographies** are needed (6 equations).

**Procedure:** estimate $H_i$ from known planar targets by DLT → solve the linear system for $\omega$ → Cholesky of $\omega^{-1} = KK^T$ → $K$.

**OpenCV / Matlab camera calibration toolbox**

- implements Zhang's method with a printable planar checkerboard;
- uses ~20 images to average out noise;
- also estimates **lens distortion** parameters;
- is the practical, accurate way to calibrate.

## 11. Calibration from a Known Plane and the Camera Centre

The deck's tennis-court example: **one image**, a known planar shape, and the known 3D position $O$ of the camera centre.

1. **Estimate $H$** from ground-plane points and their images.
2. **Locate $O$ in the plane's frame.** Backproject the two vanishing points $\mathbf{e}, \mathbf{f}$ of two known scene directions: $E' = H^{-1}\mathbf{e}$, $F' = H^{-1}\mathbf{f}$ lie on the ground plane, so $O$ is the intersection of the lines $E'E$ and $F'F$.

Formally, with $\mathbf{x} = [x,y,1]^T$ on $\pi$ and $O = [x_o, y_o, z_o]^T$ (known, cartesian), the ray direction from $O$ to $\mathbf{x}$ is

$$\mathbf{d} = \begin{bmatrix}x - x_o\\ y - y_o\\ -z_o\end{bmatrix} = M_o\,\mathbf{x}, \qquad M_o = \begin{bmatrix}1&0&-x_o\\0&1&-y_o\\0&0&-z_o\end{bmatrix}$$

Since $\mathbf{x} = H^{-1}\mathbf{u}$:

$$\mathbf{d} = M_o H^{-1}\mathbf{u} \qquad\Longrightarrow\qquad M^{-1} = M_o H^{-1}$$

and because $\mathbf{d} = (KR)^{-1}\mathbf{u} = R^{-1}K^{-1}\mathbf{u}$:

$$M^{-1} = R^{-1}K^{-1} \qquad\Longrightarrow\qquad M = K R$$

> [!important] Last step: RQ decomposition
> $M = KR$ with $K$ upper triangular and $R$ orthogonal is precisely the **RQ decomposition** of $M$ (equivalently, a QR decomposition of $M^{-1}$). It returns $K$ and the world$\to$camera rotation $R$ directly — no $\omega$, no Cholesky, no $\mathbf{t}$ needed.

## 12. Calibration from a Rectified Face + the Normal Vanishing Point

Take a planar face whose **shape is already known** after metric rectification ([[Planar Geometry]] §8.2), plus the vanishing point $\mathbf{V}$ of the direction **normal** to the face (e.g. "vertical").

The face's plane-to-image homography is the inverse of the rectifying homography: $H = H_R^{-1} = [\mathbf{h}_1\ \mathbf{h}_2\ \mathbf{h}_3]$.

**Unknowns.** With skew $= 0$ only four remain ($f_x, f_y, u_o, v_o$):

$$\omega = (KK^T)^{-1} = \begin{bmatrix} 1/f_x^2 & 0 & -u_o/f_x^2 \\ 0 & 1/f_y^2 & -v_o/f_y^2 \\ -u_o/f_x^2 & -v_o/f_y^2 & u_o^2/f_x^2 + v_o^2/f_y^2 + 1 \end{bmatrix} \quad(\text{up to scale})$$

**Four equations** are therefore enough — the Zhang pair for the face, plus the two orthogonality constraints with the normal:

$$\mathbf{h}_1^T\omega\,\mathbf{h}_2 = 0 \qquad \text{(in-plane directions are orthogonal)}$$
$$\mathbf{h}_1^T\omega\,\mathbf{h}_1 - \mathbf{h}_2^T\omega\,\mathbf{h}_2 = 0 \qquad \text{(equal unit norm, i.e. square pixels)}$$
$$\mathbf{V}^T\omega\,\mathbf{h}_1 = 0, \qquad \mathbf{V}^T\omega\,\mathbf{h}_2 = 0 \qquad (\text{normal orthogonal to both in-plane directions})$$

> [!note] Why no further equations
> $\mathbf{h}_3$ is the translation of the face, not a direction, so it carries no orthogonality information; $\mathbf{V}^T\omega\,\mathbf{h}_1 = \mathbf{V}^T\omega\,\mathbf{h}_2 = 0$ already encode $\mathbf{n}_\pi \perp \pi$. The last two equations are linearly independent of the first two (they involve the third column structure of $\omega$).

Then solve for $\omega$ and Cholesky $\omega^{-1} = KK^T$ to get $K$.

## 13. Rectification of a Single Calibrated Image from Vanishing Points

**Scenario 2** of the deck: unknown shape, known $K$ (calibrated camera), unknown plane — but **vanishing points are measurable**.

Goal: the **plane-to-image** homography $H = K[\mathbf{r}_{\pi1}\ \mathbf{r}_{\pi2}\ \mathbf{o}_\pi]$; the reconstruction is $H_R = H^{-1}$.

**Ingredient: the plane normal from the vanishing line.** The plane's vanishing line $l'_\infty$ is the image of the line at infinity of $\pi$ (from two vanishing points: $\mathbf{v}_1 = \mathbf{l}_1\times\mathbf{l}_2$, $\mathbf{v}_2 = \mathbf{l}_3\times\mathbf{l}_4$, $l'_\infty = \mathbf{v}_1\times\mathbf{v}_2$). Then

$$\mathbf{n}_\pi = K^T l'_\infty \quad (\text{normal to } \pi, \text{ in the camera frame})$$

> [!note] Digression — backprojection of an image line
> The set of space points $\mathbf{X}$ with $\mathbf{u} = P\mathbf{X}$ on the line $\mathbf{l}$ satisfies $\mathbf{l}^T\mathbf{u} = \mathbf{l}^T P\mathbf{X} = 0$: a **plane** through $O$ (since $\mathbf{l}^TPO = 0$) with equation $\boldsymbol{\beta}^T\mathbf{X} = 0$, where
> $$\boldsymbol{\beta} = P^T\mathbf{l} = \begin{bmatrix}M^T\mathbf{l}\\ \mathbf{m}^T\mathbf{l}\end{bmatrix}, \qquad \text{normal } \mathbf{n}_\beta = M^T\mathbf{l}$$
> For $P = K[I\,|\,\mathbf{0}]$ (or a calibrated camera, $M = K$): $\mathbf{n}_\beta = K^T\mathbf{l}$. Applying this to $l'_\infty$ gives $\mathbf{n}_\pi = K^T l'_\infty$.

**Construction of $H_R$.** The plane's reference frame is free (only the direction $\mathbf{n}_\pi$ is constrained). Choose any two unit vectors $\mathbf{r}_{\pi1}, \mathbf{r}_{\pi2}$ orthogonal to each other **and** to $\mathbf{n}_\pi$, and set $\mathbf{o}_\pi = \mathbf{n}_\pi$; then $[\mathbf{r}_{\pi1}\ \mathbf{r}_{\pi2}\ \mathbf{o}_\pi] = R_\pi$ is a rotation, and

$$\boxed{H_R = H^{-1} = (KR_\pi)^{-1} = R_\pi^T K^{-1}}$$

> [!important] Geometric meaning of rectification
> Rectification = **reprojection onto a new image plane $\pi'$ parallel to the scene plane $\pi$, by a natural camera**. Then scene plane $\parallel$ image plane and a natural camera $\Rightarrow$ the new image is **similar** to the scene.
>
> For each pixel, $\mathbf{d} = K^{-1}\mathbf{u}$; its components along $\mathbf{r}_{\pi1},\mathbf{r}_{\pi2}$ are the new coordinates:
> $$\mathbf{u}' = \begin{bmatrix}\mathbf{r}_{\pi1}^T\mathbf{d}\\ \mathbf{r}_{\pi2}^T\mathbf{d}\\ \mathbf{n}_\pi^T\mathbf{d}\end{bmatrix} = \begin{bmatrix}\mathbf{r}_{\pi1}^T\\ \mathbf{r}_{\pi2}^T\\ \mathbf{n}_\pi^T\end{bmatrix}K^{-1}\mathbf{u} = R_\pi^T K^{-1}\mathbf{u}$$
> The third component is the out-of-plane part and is divided out by homogenization.

> [!example] Homework pipeline (2024-25): a parallelepiped from one image
> 1. **Vanishing line** $l'_\infty$ joining the measurable vanishing points.
> 2. **Euclidean rectification of the horizontal faces**, two ways:
> 	 - *Direct:* intersect $l'_\infty$ with the image $C'$ of a horizontal **circumference** → $I', J'$ → $C^{*'}_\infty = I'J'^T + J'I'^T$ → SVD → $H_{SR}$ ([[Planar Geometry]] §8.2).
> 	 - *Stratified:* affine rectification with $l'_\infty$, then in the affinely rectified image map the ellipse $C$ (a circle in reality) to a circumference: rotate onto the axes, scale, rotate back.
> 3. **Intrinsic calibration** from $H = H_R^{-1} = [\mathbf{h}_1\ \mathbf{h}_2\ \mathbf{h}_3]$ via Zhang (§10.2).
> 4. **Rectification of the front face** with $H_R = R_\pi^T K^{-1}$ (§13).
> 5. **Localization** of the camera w.r.t. the parallelepiped: $[\mathbf{r}_1\ \mathbf{r}_2\ \mathbf{o}_\pi] = K^{-1}H_R = K^{-1}K R_\pi = R_\pi$ (§14).

## 14. Localization (Pose from One Image)

### 14.1. Known Planar Shape, Calibrated Image

Estimate $H$ by DLT from $\ge 4$ correspondences $\mathbf{u}_j = H\mathbf{x}_{\pi j}$. With $H = \lambda K[\mathbf{r}_1\ \mathbf{r}_2\ \mathbf{o}_\pi]$:

$$\mathbf{r}_1 = \frac{K^{-1}\mathbf{h}_1}{\lVert K^{-1}\mathbf{h}_1\rVert}, \qquad \mathbf{r}_2 = \frac{K^{-1}\mathbf{h}_2}{\lVert K^{-1}\mathbf{h}_1\rVert}, \qquad \mathbf{o}_\pi = \frac{K^{-1}\mathbf{h}_3}{\lVert K^{-1}\mathbf{h}_1\rVert}, \qquad \mathbf{r}_3 = \mathbf{r}_1\times\mathbf{r}_2$$

> [!warning] Scale ambiguity
> If the plane coordinates $\mathbf{x}_{\pi j}$ are known only **modulo scale**, the translation $\mathbf{o}_\pi$ is known only modulo scale — its **direction** is known, its **module** is not.
>
> - Shape + image $\Rightarrow$ orientation and viewing direction (**5 dof**).
> - Shape + **size** + image $\Rightarrow$ position and orientation (**6 dof**).

### 14.2. Perspective $n$ Points (PnP) — Non-planar 3D Set

Given images $\mathbf{u}_i$ of $N$ points with known 3D coordinates, find $R, \mathbf{t}$ from $P\mathbf{X}_i = \mathbf{u}_i$.

- **Calibrated** ($K$ known): $[R\,|\,\mathbf{t}]\mathbf{X}_i = K^{-1}\mathbf{u}_i$, $i = 1..n$. The unknowns are **6 dof**, but the orthogonality of $R$ is non-linear; each correspondence gives **2 equations**, so $n \ge 3$.
- **Uncalibrated** ($K$ unknown): $P\mathbf{X}_i = \mathbf{u}_i$ directly. $P$ has **11 dof**, each correspondence gives 2 **linear** equations, so $n \ge 6$ — solve by **DLT** (same right-null-space / SVD machinery as the homography, [[Planar Geometry]] §6).

Both are available in OpenCV (`solvePnP`, `calibrateCamera`).

## 15. Appendix A — The Painter's Eye

> [!example] Where was the painter standing?
> Assumptions: the floor is **horizontal**, the floor tiles are **square**, we know the vanishing points of the "x" and "y" directions ($\mathbf{V}_x$, $\mathbf{V}_{y\infty}$, the latter at infinity → the y direction is parallel to the painting).
>
> 1. By the **vanishing point theorem**, the line (eye, $\mathbf{V}_x$) is parallel to $\mathbf{d}_x$; the floor is horizontal, so this line is horizontal.
> 2. $\mathbf{V}_{y\infty}$ at infinity ⇒ (eye, $\mathbf{V}_{y\infty}$) is parallel to the painting.
> 3. (eye, $\mathbf{V}_x$) $\perp$ (eye, $\mathbf{V}_{y\infty}$) — this fixes the eye on the **normal to the y-axis through $\mathbf{V}_x$** (top view).
> 4. **How far?** Square tiles ⇒ the diagonals make $45^\circ$ with $\mathbf{d}_x$; the theorem gives the line (eye, $\mathbf{V}_{45^\circ}$) at $45^\circ$ to (eye, $\mathbf{V}_x$), and horizontality makes it horizontal. The intersection of the two loci is the eye.

## 16. Appendix B — Calibration from Two Images of an Unknown Planar Scene

The circular points of any plane are **self-orthogonal**: $I_\pi^T I_\pi = 0$. For the imaged circular points ($I' = K R I_\pi$):

$$I'^T\omega\,I' = 0$$

being $\omega = K^{-T}K^{-1}$ — the same equation as before, now with an **unknown scene**. Take images of an unknown planar scene with a **constant $K$** and estimate the image-to-image homographies $H'$. Then $I'' = H'I'$, so the condition propagates to

$$I'^T H'^T \omega\, H' I' = 0$$

- Unknowns: $I'$ (2 real dof: real and imaginary part) and $\omega$ (5 dof). Each **non-linear** equation gives 2 constraints (Re and Im part) ⇒ at least **5 images**.
- Solve for $\omega$ and $I'$, invert $\omega$, Cholesky → $K$.

> [!warning] Accuracy
> This route is usually **less accurate** than Zhang's method: it needs many views and a non-linear solve.

*Variant:* with **two calibrated images** ($\omega$ known) only $I'$ is unknown ⇒ **2 images** suffice. With two **different** cameras, $I'$ is the intersection of the conics $I'^T\omega'I' = 0$ and $I'^TH'^T\omega''H'I' = 0$ — two candidate pairs of circular points, selected by reprojection or a third image. Rectification then proceeds as in [[Planar Geometry]] §8.2 (SVD of $C^{*'}_\infty$).

*Variant:* with **two calibrated images** ($\omega$ known) only $I'$ is unknown ⇒ **2 images** suffice. With two **different** cameras, $I'$ is the intersection of the conics $I'^T\omega'I' = 0$ and $I'^TH'^T\omega''H'I' = 0$ — two candidate pairs of circular points, selected by reprojection or a third image. Rectification then proceeds as in [[Planar Geometry]] §8.2 (SVD of $C^{*'}_\infty$).

## 17. Appendix C — Symmetry as a Measurement Tool

A system is symmetric w.r.t. a transformation if applying it produces no measurable change. Adding elements restricts the symmetry group:

| Elements | 3D symmetry | 2D symmetry |
|---|---|---|
| empty space/plane | any motion | any motion |
| 1 point | **spherical** (any motion preserving distance) | **circular / isotropic** |
| 2 points (axis through them) | **axial** (motion along circles orthogonal to the axis, centred on it) | axial |
| 3 points | **planar** (mirroring in the plane through them) | none left |

Same symmetry for the corresponding spheres/circles. Two points are symmetric w.r.t. a plane if the joining segment is **perpendicular** to the plane and its **midpoint** lies on it.

### 17.1. Harmonic Tuples: $CR = -1$

Because the cross ratio is projectively invariant, the symmetric 4-tuple (two endpoints, their midpoint, the point at infinity) keeps its value in the image:

$$CR_{Y,Z,X_o,X_\infty} = -1 \qquad\Longrightarrow\qquad CR_{\mathbf{y},\mathbf{z},\mathbf{x}_o,\mathbf{V}} = -1$$

So the **image of a midpoint** $\mathbf{x}_o$ is the point on $\mathbf{yz}$ harmonic-conjugate to the vanishing point $\mathbf{V}$ of the joining direction. When $CR = -1$, $X_1$ and $X_2$ are said to be **conjugate** w.r.t. $Y,Z$ — and the roles can be swapped, since $-1$ is its own inverse. One of the two points is internal to the segment, the other external.

> [!example] 3D position of symmetric features (calibrated camera, one known size $AB$)
> 1. Find the segments joining **symmetric feature pairs** (e.g. car mirrors, wing tips); their concurrency point is $\mathbf{V}$ — the direction of the plane normal.
> 2. Find the **images of the midpoints**: $\mathbf{C}'$ such that $CR(A', B', \mathbf{C}', \mathbf{V}) = -1$.
> 3. Normal of the symmetry plane: $\mathbf{n} = K^{-1}\mathbf{V}$.
> 4. Solve the **triangle** $OAB$: known $AB$, directions $OA = K^{-1}A'$, $OB = K^{-1}B'$ ⇒ 3D $A, B$; then $C = (A+B)/2$.
> 5. Symmetry plane: $\boldsymbol{\pi} = [\mathbf{n}^T, d]^T$ with $d = -\mathbf{n}^T C$.
> 6. Backproject the other midpoint images onto $\pi$: with $\mathbf{F} = \alpha K^{-1}\mathbf{F}'$ and $\mathbf{n}^T\mathbf{F} + d = 0$,
> $$\alpha = -\frac{d}{\mathbf{n}^TK^{-1}\mathbf{F}'}$$
> 7. Solve the triangle $OFD$ ($O$, $F$ known; directions $OD = K^{-1}D'$ and $FD = K^{-1}\mathbf{V}$) ⇒ 3D $D$, hence all symmetric features.

## 18. Appendix D — Polarity: Projective Symmetry

**Polar line.** Given a point $\mathbf{y}$ and a conic $C$, the line

$$\mathbf{l} = C\mathbf{y}$$

is the **polar line** of $\mathbf{y}$ w.r.t. $C$.

> [!theorem] Polar line ↔ cross ratio $-1$
> Let $\mathbf{x}_1, \mathbf{x}_2$ be the intersections of any line through $\mathbf{y}$ and $\mathbf{z}$ with $C$. Then $\mathbf{y}$ and $\mathbf{z}$ are conjugate w.r.t. $\mathbf{x}_1,\mathbf{x}_2$:
> $$CR_{Y,Z,X_1,X_2} = -1 \qquad\Longleftrightarrow\qquad \mathbf{z} \in \mathbf{l} = C\mathbf{y}$$

**Proof.** A point of the line $(\mathbf{y},\mathbf{z})$ is $\mathbf{x} = \alpha\mathbf{y} + \beta\mathbf{z}$; imposing $\mathbf{x}^TC\mathbf{x} = 0$ and using $\mathbf{z}^TC\mathbf{y} = 0$ (since $\mathbf{z}$ is on the polar) leaves

$$\alpha^2\,\mathbf{y}^TC\mathbf{y} + \beta^2\,\mathbf{z}^TC\mathbf{z} = 0 \qquad\Longrightarrow\qquad \frac{\beta}{\alpha} = \pm\sqrt{-\frac{\mathbf{y}^TC\mathbf{y}}{\mathbf{z}^TC\mathbf{z}}}$$

two opposite solutions, i.e. $\dfrac{\beta_1/\alpha_1}{\beta_2/\alpha_2} = -1$. $\blacksquare$

**Consequences**

- The polar $\mathbf{l} = C\mathbf{y}$ is the **locus of the conjugates** of $\mathbf{y}$ w.r.t. $C$ (conjugates w.r.t. the intersections of $C$ with any line through $\mathbf{y}$).
- It **passes through the tangency points** from $\mathbf{y}$ to $C$: at tangency the two roots coincide ($\mathbf{z}^TC\mathbf{z} = 0$).
- If $\mathbf{y}$ is **on** $C$, its polar is the **tangent** to $C$ at $\mathbf{y}$ (the tangent formula of [[Planar Geometry]] §5).

**Polar w.r.t. a circumference** (centre $\mathbf{c}_o$, radius $r$) — the polar of $\mathbf{y}$ is perpendicular to the segment $(\mathbf{c}_o, \mathbf{y})$:

| Point $\mathbf{y}$ | Polar line |
|---|---|
| $[X_o, 0, 1]^T$ | $X_o\,x - r^2 w = 0$, i.e. the vertical line $x = r^2/X_o$ |
| at infinity, $[x, y, 0]^T$ | the **diameter** perpendicular to that direction |
| the centre, $[0,0,1]^T$ | $l_\infty$ |

Polarity is what makes **circles, spheres, right cones and cylinders, and planar mirrors** tractable in a single image: their symmetry becomes an algebraic conjugacy.

---

## 19. Cheat Sheet

$$P = [M\,|\,\mathbf{m}] = K[R\,|\,\mathbf{t}], \qquad \mathbf{d} = M^{-1}\mathbf{u}, \qquad O = -M^{-1}\mathbf{m}$$
$$\mathbf{V} = M\mathbf{d} \quad(\text{and } \mathbf{d} = M^{-1}\mathbf{V}), \qquad \omega = (KK^T)^{-1} = K^{-T}K^{-1}$$
$$H = K[\mathbf{r}_{\pi1}\ \mathbf{r}_{\pi2}\ \mathbf{o}_\pi], \qquad \omega^{-1} = KK^T = MM^T \;\Rightarrow\; K = \text{Cholesky}(\omega^{-1})$$
$$H_R = R_\pi^T K^{-1}, \qquad \mathbf{n}_\pi = K^T l'_\infty, \qquad \mathbf{r}_1, \mathbf{r}_2, \mathbf{o}_\pi = K^{-1}[\mathbf{h}_1\ \mathbf{h}_2\ \mathbf{h}_3] \text{ normalized}$$

---
Related: [[_Image Analysis MOC]]
Source: [[IACV 2026 - E - Single-view Geometry and Camera Calibration.pdf]]
