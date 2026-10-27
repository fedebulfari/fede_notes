---
date: 11-10-2026
subject: Image Analysis
description: 3D projective geometry — homogeneous points and planes, duality, lines as non-primitive self-dual elements, quadrics and the absolute conic, projective mappings and the hierarchy of 3D transformations with their invariants.
---

# Space Geometry

> [!summary] Overview
> Space projective geometry is the 3D analogue of [[Planar Geometry|planar projective geometry]]: a point becomes a 4-vector, a plane is its dual 4-vector, and **lines are no longer primitive** — they are intermediate entities between points and planes and are self-dual. Second-degree loci become **quadrics** $X^T Q X = 0$ ($4\times4$ symmetric), whose intersection with $\pi_\infty$ gives the **absolute conic** $\Omega_\infty$. The same invariants hierarchy (Euclidean $\to$ similarity $\to$ affine $\to$ projective) is recovered, and will be the basis of 3D reconstruction in multi-view geometry.

**Elements:** Points $\bullet$, Lines, Planes, Quadrics, Dual quadrics.

## 1. Points in Projective Space

Euclidean point $[X,Y,Z]$ is embedded as the hyperplane $w=1$ in $\mathbb{R}^4$. A point is any non-zero multiple of a 4-vector:

$$\mathbf{X} = \begin{bmatrix} x \\ y \\ z \\ w \end{bmatrix}, \qquad X = \frac{x}{w},\quad Y = \frac{y}{w},\quad Z = \frac{z}{w}$$

- **Homogeneity:** $\lambda \mathbf{X} \sim \mathbf{X}$, $\lambda \ne 0$.
- **Projective space:** $\mathbb{P}^3 =\{X \in \mathbb{R}^4 \setminus \{[0,0,0,0]^T\}\}$ modulo scale.
- **Points at infinity:** $w=0$, i.e. $\mathbf{X}_\infty = [x,y,z,0]^T$ — one for each direction of $\mathbb{R}^3$.

## 2. Planes, Incidence and Duality

A plane in Cartesian form $aX + bY + cZ + d = 0$ becomes, in homogeneous coordinates:

$$\boldsymbol{\pi} = \begin{bmatrix} a \\ b \\ c \\ d \end{bmatrix}, \qquad \boldsymbol{\pi}^T \mathbf{X} = a x + b y + c z + d w = 0$$

- $[a,b,c]^T$ is the **normal direction** to the plane.
- $\dfrac{-d}{\sqrt{a^2+b^2+c^2}}$ is the **signed distance** from the origin.
- $\boldsymbol{\pi}$ is homogeneous: $\lambda \boldsymbol{\pi} \sim \boldsymbol{\pi}$ (3 dof).

> [!example] The X–Z plane
> $\boldsymbol{\pi} = [0,1,0,0]^T$: normal along $Y$, passing through the origin.

**Plane at infinity** The locus of all points at infinity is the plane $w=0$:

$$\boldsymbol{\pi}_\infty =\begin{bmatrix} 0\\0\\0\\1
\end{bmatrix} \quad (\text{or any } \lambda \boldsymbol{\pi}_\infty)$$

> [!warning] $\boldsymbol{\pi}_\infty$ has **undefined normal direction** — it is not a Euclidean plane.

**Incidence and Duality** The dot product is commutative, so incidence is symmetric:

$$\boldsymbol{\pi}^T \mathbf{X} = 0 = \mathbf{X}^T \boldsymbol{\pi}$$

- Point $\mathbf{X}$ is on plane $\boldsymbol{\pi}$ $\iff$ plane $\boldsymbol{\pi}$ goes through point $\mathbf{X}$ $\iff$ **point $\boldsymbol{\pi}$ is on plane $\mathbf{X}$** (in the dual space).
- **Dual dictionary (3D):** _point_ $\leftrightarrow$ _plane_, _is on_ $\leftrightarrow$ _goes through_, _line_ $\leftrightarrow$ _line_ (self-dual).
- **Principle of duality:** for any true statement about points and planes, swapping these words gives another true statement.

## 3. Points and Planes: Intersection and Join

**Point on three planes** — three planes in general position meet in a point:

$$\begin{bmatrix} \boldsymbol{\pi}_1^T \\ \boldsymbol{\pi}_2^T \\ \boldsymbol{\pi}_3^T \end{bmatrix}_{3\times4} \mathbf{X} = \mathbf{0} \quad\Longrightarrow\quad \mathbf{X} = \text{RNS}\!\left(\begin{bmatrix} \boldsymbol{\pi}_1^T \\ \boldsymbol{\pi}_2^T \\ \boldsymbol{\pi}_3^T \end{bmatrix}_{3\times4}\right)$$
![[Space Geometry-1793101921773.webp|276]]
A 1D null space $\Rightarrow$ a solution vector plus all its multiples (one point).

**Plane through three points** — the **dual** statement:

$$\begin{bmatrix} \mathbf{X}_1^T \\ \mathbf{X}_2^T \\ \mathbf{X}_3^T \end{bmatrix}_{3\times4} \boldsymbol{\pi} = \mathbf{0} \quad\Longrightarrow\quad \boldsymbol{\pi} = \text{RNS}\!\left(\begin{bmatrix} \mathbf{X}_1^T \\ \mathbf{X}_2^T \\ \mathbf{X}_3^T \end{bmatrix}_{3\times4}\right)$$
![[Space Geometry-1793102171938.webp|268]]
## 4. Lines

> [!important] Lines are not primitive in 3D
> In the plane, lines are primitive elements. In space they are **not**: a line is the intersection of two planes or the join of two points — it is _intermediate_ between points and planes, and it is **self-dual**.

**Line as the set of points on two planes** (a "pencil" of points, 1D):

$$\begin{bmatrix} \boldsymbol{\pi}_1^T \\ \boldsymbol{\pi}_2^T \end{bmatrix}_{2\times4} \mathbf{X} = \mathbf{0}, \qquad \mathbf{L} = \text{RNS}\!\left(\begin{bmatrix} \boldsymbol{\pi}_1^T \\ \boldsymbol{\pi}_2^T \end{bmatrix}_{2\times 4}\right)$$

A 2D space of solutions (two points and all their linear combinations) $\Rightarrow$ a 1D set of points (parameter: abscissa along the line).
![[Space Geometry-1793102403032.webp|244]]
**Line as the set of planes through two points** (dual, 1D):

$$\begin{bmatrix} \mathbf{X}_1^T \\ \mathbf{X}_2^T \end{bmatrix}_{2\times4} \boldsymbol{\pi} = \mathbf{0}, \qquad \mathbf{L}^* = \text{RNS}\!\left(\begin{bmatrix} \mathbf{X}_1^T \\ \mathbf{X}_2^T \end{bmatrix}_{2\times 4}\right)$$

A 2D space of solutions (two planes and all their combinations) $\Rightarrow$ a 1D set of planes through the line (parameter: rotation angle).

**Linear combinations**

- $\mathbf{X} = \alpha \mathbf{X}_1 + \beta \mathbf{X}_2$ lies on the line through $\mathbf{X}_1, \mathbf{X}_2$ (they are **collinear**).
- **Dual:** $\boldsymbol{\pi} = \alpha \boldsymbol{\pi}_1 + \beta \boldsymbol{\pi}_2$ goes through the line $\mathbf{L}^*$ of $\boldsymbol{\pi}_1, \boldsymbol{\pi}_2$ (they are **coaxial**).
- **Special case (parallel planes):**
	
	$$\boldsymbol{\pi}' = \boldsymbol{\pi} + \lambda \boldsymbol{\pi}_\infty = \begin{bmatrix} a \\ b \\ c \\ d+\lambda \end{bmatrix}$$
	
	which is the set of all planes **parallel** to $\boldsymbol{\pi}$.

**Lines and circular points at infinity**

- Each plane $\boldsymbol{\pi}$ has its own line at infinity $l_\infty(\boldsymbol{\pi})$ and its own circular points $I_\pi, J_\pi$.
- **Parallel planes share** the same $l_\infty$ and the same $I_\pi, J_\pi$.

## 5. Cross Ratio in 1D, 2D and 3D

**1D — four collinear points** (abscissae $a,b,c,d$):

$$CR_{Y,Z,X_1,X_2} = \frac{\dfrac{c-a}{c-b}}{\dfrac{d-a}{d-b}}$$
![[Space Geometry-1793103039916.webp|210]]
**2D — four coplanar, concurrent lines:** take any crossing (transversal) line and compute the 1D cross ratio of the four intersection points.
![[Space Geometry-1793103054948.webp|346]]
**3D — four coaxial planes** (sharing a line): take any crossing plane and compute the 2D cross ratio of the four intersection lines.
![[Space Geometry-1793103374814.webp|367]]
All three levels are invariant under projective mappings (see §8).

## 6. Quadrics

A **quadric** is the locus of points $\mathbf{X}$ satisfying a homogeneous _quadratic_ equation:

$$\mathbf{X}^T Q \mathbf{X} = 0, \qquad Q = Q^T \in \mathbb{R}^{4\times4}$$

- **9 dof:** 10 independent entries in a symmetric $4\times4$ matrix, minus 1 for scale. $Q$ is homogeneous ($\lambda Q \sim Q$).
- **9 points** in general position define a quadric.

> [!info] Classification
>
> ![[Space Geometry-1793104091076.webp|308x258]]

**Example: the sphere** In Cartesian coordinates, with center $(X_o,Y_o,Z_o)$ and radius $r$:

$$(X-X_o)^2 + (Y-Y_o)^2 + (Z-Z_o)^2 - r^2 = 0$$

In homogeneous coordinates, $Q$ is (row $\times$ column against $[x,y,z,w]^T$):

$$Q = \begin{bmatrix} 1 & 0 & 0 & -X_o \\ 0 & 1 & 0 & -Y_o \\ 0 & 0 & 1 & -Z_o \\ -X_o & -Y_o & -Z_o & X_o^2+Y_o^2-r^2 \end{bmatrix}, \qquad \mathbf{X}^T Q \mathbf{X} = 0$$

Note the structure: identity block (unit sphere) plus the translation terms of the center.

## 7. Intersection of a Plane and a Quadric

A plane can be described by its **span**: three points generate it,

$$\boldsymbol{\pi}: \mathbf{X} = M \mathbf{x}, \qquad M = [\mathbf{X}_1\ \mathbf{X}_2\ \mathbf{X}_3]_{4\times3}$$

where $\mathbf{x} = [\alpha,\beta,\gamma]^T$ are **homogeneous coordinates within the plane** (2D geometry on $\boldsymbol{\pi}$).

Substituting into the quadric equation:

$$\mathbf{X}^T Q \mathbf{X} = \mathbf{x}^T M^T Q M \mathbf{x} = \mathbf{x}^T C \mathbf{x} = 0, \qquad \boxed{C = M^T Q M}$$

The result is a **conic** $C$ (a $3\times3$ symmetric matrix) — a set of points $\mathbf{x}$ _within_ the plane $\boldsymbol{\pi}$. This is the 3D mechanism behind every plane–quadric intersection: a plane cuts a quadric in a conic.

## 8. The Absolute Conic

> [!theorem] Absolute conic
> Intersecting **any** sphere with the plane at infinity $\boldsymbol{\pi}_\infty$ gives the _same_ conic, independent of center and radius.

With $w=0$ in $(x-X_o w)^2+(y-Y_o w)^2+(z-Z_o w)^2-r^2w^2 = 0$:

$$x^2+y^2+z^2 = 0,\quad w=0 \quad\Longrightarrow\quad \Omega_\infty = \begin{bmatrix} 1 & 0 & 0 \\ 0 & 1 & 0 \\ 0 & 0 & 1 \end{bmatrix}$$

The sphere parameters **disappear**: the intersection is a conic lying in $\boldsymbol{\pi}_\infty$, the **absolute conic** $\Omega_\infty$.

- $\Omega_\infty$ is made of the **circular points of all planes** ($\Omega_\infty = \bigcup_\pi \{I_\pi, J_\pi\}$) — the 3D extension of $I=[1,i,0]^T$, $J=[1,-i,0]^T$ of the planar case.
- It encodes the **metric** (Euclidean) structure of space: it is exactly what similarities preserve and affinities do not.
- Dual object: the **absolute dual quadric** $Q^*_\infty = \Omega_\infty$ as an envelope of tangent planes, with matrix $\text{diag}(1,1,1,0)$.

## 9. Degenerate Quadrics

$\mathbf{X}^T Q \mathbf{X} = 0$ with $\det(Q) = 0$:

- $\text{rank}(Q) = 1$: $Q = \mathbf{A}\mathbf{A}^T$ — a **repeated plane** $\mathbf{A}$.
- $\text{rank}(Q) = 2$: $Q = \mathbf{A}\mathbf{B}^T + \mathbf{B}\mathbf{A}^T$ — the union of **two planes** $\mathbf{A}$ and $\mathbf{B}$.
- $\text{rank}(Q) = 3$: a **cone**, with vertex $= \text{RNS}(Q)$.

> [!tip] A cylinder is a cone whose vertex is at infinity.

## 10. Dual Quadrics

Just as a dual conic is a set of _lines_, a **dual quadric** $Q^*$ is the set of **planes** tangent to the quadric:

$$\boldsymbol{\pi}^T Q^* \boldsymbol{\pi} = 0$$

- For a non-degenerate quadric, $Q^* = Q^{-1}$ (analogous to $C^* = C^{-1}$ in the plane).
- Degenerate cases are the dual of §9 (e.g. $\text{rank}(Q^*)=3$: planes through a point / tangent to a cone).

## 11. Projective Mappings

> [!definition] Projective mapping
> An **invertible** mapping $h: \mathbb{P}^3 \to \mathbb{P}'^3$ that **preserves collinearity**: $\mathbf{X}_1,\mathbf{X}_2,\mathbf{X}_3$ collinear $\iff$ $h(\mathbf{X}_1), h(\mathbf{X}_2), h(\mathbf{X}_3)$ collinear. Also called **projectivity**.

> [!theorem] Fundamental Theorem of Projective Geometry
> $h: \mathbb{P}^3 \to \mathbb{P}'^3$ is projective **iff** there exists an invertible $4\times4$ matrix $H$ such that $h(\mathbf{X}) = H\mathbf{X}$.
> Projective mappings are **linear in homogeneous coordinates** (not in Cartesian ones).

- **15 dof:** $\lambda H$ defines the same mapping as $H$, so only the 15 ratios of the 16 entries matter.
- $H$ is thus a **homogeneous matrix**.

**Transformation rules for the space elements**

| Element | Rule |
|---|---|
| Point | $\mathbf{X} \to H\mathbf{X}$ |
| Plane | $\boldsymbol{\pi} \to H^{-T}\boldsymbol{\pi}$ |
| Quadric | $Q \to H^{-T} Q H^{-1}$ |
| Dual quadric | $Q^* \to H Q^* H^T$ |

**Invariants:** collinearity, incidence, order of contact (crossing, tangency, inflection), and the 1D, 2D and 3D cross ratios.

## 12. Hierarchy of 3D Transformations

Each group is a subgroup of the ones below it and inherits all their invariants.

> [!info] Isometry / Euclidean ($H_I$ — **6 dof**: $t$ + Euler angles $\vartheta,\varphi,\psi$)
> $$H_I = \begin{bmatrix} R_\perp & \mathbf{t} \\ \mathbf{0}^T & 1 \end{bmatrix}, \qquad R_\perp^T R_\perp = I,\quad \det(R_\perp) = 1 \ (-1 \text{ for reflection})$$
> **Invariants:** lengths, distances, areas $\Rightarrow$ shape and size, relative positions.

> [!info] Similarity ($H_S$ — **7 dof**: rigid displacement + scale $s$)
> $$H_S = \begin{bmatrix} sR_\perp & \mathbf{t} \\ \mathbf{0}^T & 1 \end{bmatrix}$$
> **Invariants:** ratios of lengths, angles $\Rightarrow$ shape (not size); the **absolute conic $\Omega_\infty$** (and the absolute dual quadric $Q^*_\infty$).

> [!info] Affinity ($H_A$ — **12 dof**: $A_{3\times3}$ invertible + $\mathbf{t}$)
> $$H_A = \begin{bmatrix} A & \mathbf{t} \\ \mathbf{0}^T & 1 \end{bmatrix}$$
> **Invariants:** parallelism of planes, ratios of parallel lengths, ratios of areas, centroids; the **plane at infinity $\boldsymbol{\pi}_\infty$**. Linear in Cartesian coordinates.

> [!info] Projectivity ($H$ — **15 dof**: $A + \mathbf{v} + \mathbf{t}$)
> $$H = \begin{bmatrix} A & \mathbf{t} \\ \mathbf{v}^T & 1 \end{bmatrix}$$
> **Invariants:** incidence, collinearity, order of contact, cross ratios (1D, 2D, 3D).

**What fixes what:** $\boldsymbol{\pi}_\infty$ is fixed $\iff$ the map is affine; $\Omega_\infty$ is fixed $\iff$ the map is a similarity. This is the 3D analogue of the planar $l_\infty$ / $I,J$ criterion, and it is the key to stratified 3D reconstruction.

> [!warning] Caveat — a 3D rototranslation is not a pure rotation
> **Screw decomposition:** any rototranslation is equivalent to a rotation about a **screw axis** and a translation along it: $\mathbf{t} = \mathbf{t}_{\parallel} + \mathbf{t}_{\perp}$, with the screw axis parallel to the rotation axis. Unlike the planar case, there is no fixed point in general.

> [!note] Next step
> 3D shape reconstruction will be studied in Multi-view Geometry (next sessions).

## 13. Quick Reference: 2D vs 3D

| Element | $\mathbb{P}^2$ ([[Planar Geometry]]) | $\mathbb{P}^3$ |
|---|---|---|
| Point | 3-vector, 2 dof | 4-vector, 3 dof |
| Hyperplane | line, 2 dof | plane, 3 dof |
| Line | primitive, 2 dof | non-primitive, 4 dof, self-dual |
| Second-degree locus | conic $C_{3\times3}$, 5 dof | quadric $Q_{4\times4}$, 9 dof |
| Set at infinity | $l_\infty$, $I,J$ | $\pi_\infty$, $\Omega_\infty$ |
| Projectivity | $H_{3\times3}$, 8 dof | $H_{4\times4}$, 15 dof |

---
Related: [[_Image Analysis MOC]], [[Planar Geometry]]
Source: [[IACV 2026 - D - 3D Projective Geometry.pdf]]
