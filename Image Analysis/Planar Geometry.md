---
date: 11-10-2026
subject: Image Analysis
description: Planar projective geometry for image rectification — homogeneous points, lines, vanishing points, cross ratio, conics, homographies, and affine/metric reconstruction from invariants.
---

> [!summary] Overview Central projection in a pinhole camera ($x_p = f \frac{X_p}{Z_p},\ y_p = f \frac{Y_p}{Z_p}$) is non-linear and does not preserve shape or length ratios. To understand what we get from what we see we study planar projective geometry: points, lines, conics and their transformations, then use invariants to rectify an image of an unknown planar scene.

# 1. Homogeneous Coordinates for Points

Embed the Euclidean plane $X,Y$ as the plane $w=1$ in 3D. A point $P=[X,Y]$ is represented by any non-zero multiple of $[X,Y,1]^T$:

$$x = [x,y,w]^T = w[X,Y,1]^T, \quad X = \frac{x}{w},\quad Y = \frac{y}{w}$$

- **Homogeneity:** $x$ is equivalent to $\lambda x$, $\lambda \ne 0$.
	
- **Redundancy:** 3 coordinates for 2 dof (the two independent ratios $x:y:w$).
	
- The null vector $[0,0,0]^T$ represents no point.
	
- **Projective plane:** $\mathbb{P}^2 = \mathbb{R}^3 \setminus \{[0,0,0]^T\}$ modulo scale (Euclidean plane $\cup$ set of points at infinity).

> [!example] Example $[9,6,3]^T \sim [3,2,1]^T \rightarrow [3,2]$, $[0,-8,-4]^T \sim [0,2,1]^T \rightarrow [0,2]$.

**Points at Infinity** Points with $w=0$, e.g. $[x,y,0]^T = \lim_{w \to 0} [x/w, y/w]$, have no Cartesian counterpart. They represent directions in the Euclidean plane. All parallel lines along direction $[b, -a]$ meet at the point at infinity $[b, -a, 0]^T$.

**Line at infinity:** $l_{\infty} = [0,0,1]^T$ (or $[0,0,\lambda]^T$). A point $x$ is at infinity iff $l_{\infty}^T x = w = 0$.

# 2. Lines, Incidence and Duality

A line in the Euclidean plane $aX + bY + c = 0$ becomes in homogeneous coordinates $ax + by + cw = 0$, i.e.:

$$l^T x = [a,b,c][x,y,w]^T = 0$$

$l = [a,b,c]^T$ is homogeneous like $x$ (2 dof: ratios $a:b:c$; $[0,0,0]^T$ is not a line).

**Three Geometric Remarks on $l = [a,b,c]^T$:**

1. If $c=0$, the line $l = [a,b,0]^T$ passes through the origin $[0,0]$.
	
2. The vector $[a,b]$ is the **normal direction** to the line $l$.
	
3. Two lines $l = [a,b,c]^T$ and $l' = [a,b,c']^T$ are **parallel**: they share the same normal $[a,b]$ and the same direction $[b,-a]$, intersecting at $x_\infty = [b,-a,0]^T$.
	

**Incidence and Duality:** Incidence is symmetric: $l^T x = x^T l = 0$. Point $x$ is on line $l \Leftrightarrow$ line $l$ goes through point $x \Leftrightarrow$ point $l$ is on line $x$ in the dual projective plane.

- **Dual dictionary:** _Point_ $\leftrightarrow$ _Line_; _is on_ $\leftrightarrow$ _goes through_; _collinear_ $\leftrightarrow$ _concurrent_.
	

**Intersection and Join:**

- **Point on two lines (intersection):** $x = l_1 \times l_2 = \text{RNS}([l_1^T ; l_2^T])$.
	
- **Line through two points (join):** $l = x_1 \times x_2 = \text{RNS}([x_1^T ; x_2^T])$.
	
**Linear Combinations:**

- Point $x = \alpha x_1 + \beta x_2$ lies on the line joining $x_1$ and $x_2$ ($x$ is **collinear** to $x_1, x_2$).
	
- **Dual:** Line $l = \alpha l_1 + \beta l_2$ passes through the intersection of $l_1$ and $l_2$ ($l$ is **concurrent** to $l_1, l_2$).
	
- **Special case (parallel pencil):** $l' = l + \lambda l_\infty = [a,b,c]^T + \lambda [0,0,1]^T = [a,b,c']^T$ represents the set of all lines parallel to $l$.
	

# 3. Vanishing Points and Vanishing Line

> [!theorem] Vanishing point The image of a set of parallel lines $l_i$ is a set of lines $l_i'$ concurrent at a common point $x'_\infty$, called the vanishing point of that direction.

- **Vanishing point:** Image of a point at infinity $x_\infty$ under central projection (or any homography).
	
- **Vanishing line (or horizon) $l'_{\infty}$:** Image of the line at infinity $l_{\infty}$. All vanishing points of a plane lie on $l'_{\infty}$ (and are linear combinations of any two vanishing points $V_1, V_2$):
	
	$$l'_{\infty} = V_1 \times V_2$$
	

# 4. Cross Ratio — the Projective Invariant

Lengths and ratios of lengths are **not** invariant under central projection (e.g., $50\text{ m}/-50\text{ m} = -1$ in scene becomes $420\text{ pix}/-160\text{ pix} = -2.62$ in image).

For 4 collinear points $Y,Z,X_1,X_2$ with abscissae $a,b,c,d$ along the line:

$$CR_{Y,Z,X_1,X_2} = \frac{\frac{c-a}{c-b}}{\frac{d-a}{d-b}}$$

If $X_1 = \alpha_1 Y + \beta_1 Z$ and $X_2 = \alpha_2 Y + \beta_2 Z$, then:

$$CR_{Y,Z,X_1,X_2} = \frac{\beta_1 / \alpha_1}{\beta_2 / \alpha_2}$$

Since a homography $H$ is linear in homogeneous coordinates, $X_1' = H X_1 = \alpha_1 Y' + \beta_1 Z'$ and $X_2' = H X_2 = \alpha_2 Y' + \beta_2 Z'$ preserve the linear combination coefficients, hence:

$$CR_{Y',Z',X_1',X_2'} = CR_{Y,Z,X_1,X_2}$$

- **Dual (2D Cross Ratio):** The cross ratio of 4 concurrent coplanar lines equals the 1D cross ratio of their intersection points with any transversal line.
	

**Application: Time to Impact for a Translating Camera** Consider a camera translating at constant speed (or observing features moving at constant speed) taking frames at $t=0$ (feature at image coordinate $x$) and $t=\Delta t$ (feature at $x'$):

1. 3D motion segments are parallel in the scene $\rightarrow$ their 2D image trajectories concur at the **vanishing point of the motion direction** $x_\infty$, which corresponds to $\infty$ distance, i.e., $t = \infty$.
	
2. Let $t_i$ be the **time of impact** when the feature hits the **lens plane** (which passes through the optical center $O$ and is parallel to the image plane). Since the projection ray $(P, O)$ lies on the lens plane, its intersection with the image plane is at infinity: at $t = t_i$, the image coordinate is $x_{impact} = \infty$.
	
3. Since speed is constant, 3D distance is proportional to time. Equating the cross ratio of time instants $\{t_i, \infty, \Delta t, 0\}$ to the cross ratio of image coordinates $\{\infty, x_\infty, x', x\}$:
	
	$$\frac{\frac{t_i - \Delta t}{t_i - 0}}{\frac{\infty - \Delta t}{\infty - 0}} = \frac{\frac{\infty - x'}{\infty - x}}{\frac{x_\infty - x'}{x_\infty - x}} \implies \frac{t_i - \Delta t}{t_i} = \frac{x_\infty - x}{x_\infty - x'} \implies t_i = \Delta t \frac{x_\infty - x'}{x - x'}$$
	
	This allows sorting features by time to impact and, if all features move at the same speed (static scene), provides a partial 3D reconstruction (depth proportional to $t_i$).
	

# 5. Conics and Dual Conics

A conic is a second-degree curve $aX^2 + bXY + cY^2 + dX + eY + f = 0$. Homogenizing with $X=x/w, Y=y/w$ gives the quadratic form $x^T C x = 0$, with $C$ a symmetric $3 \times 3$ homogeneous matrix:

$$C = \begin{bmatrix} a & b/2 & d/2 \\ b/2 & c & e/2 \\ d/2 & e/2 & f \end{bmatrix}$$

- **5 dof:** 6 independent entries in a symmetric $3 \times 3$ matrix minus 1 for scale.
- **Line-conic intersection:** Solving the system $x^T C x = 0$ and $l^T x = 0$ yields a quadratic equation with 2 solutions:
	- 2 distinct real solutions (secant line).
	- 2 coincident real solutions (tangent line).
	- 2 complex-conjugate solutions (external line).	

- **Tangent line to a conic:** At a point $y$ on the conic ($y^T C y = 0$), the tangent line is given by $l = C y$.
- **Classification via intersection with $l_\infty$:**
	- _Parabola:_ plane parallel to a cone side $\rightarrow$ 2 coincident solutions with $l_\infty$ (point at $\infty$ along the axis).
	- _Ellipse:_ $\theta_{plane} < \theta_{cone}$ $\rightarrow$ 2 complex-conjugate solutions with $l_\infty$ (no real points at $\infty$).
	- _Hyperbola:_ $\theta_{plane} > \theta_{cone}$ $\rightarrow$ 2 distinct real solutions with $l_\infty$ (directions of the asymptotes).
		
- **Non-degenerate vs Degenerate Conics:**
	- _Non-degenerate:_ $\text{rank}(C)=3$, $\vert{}C\vert{} \ne 0$.
	- _Degenerate:_ $\vert{}C\vert{}=0$, $\text{rank}(C) < 3$:
		- $\text{rank}(C)=2$: $C = l m^T + m l^T$, union of two lines ($x^T l = 0 \lor m^T x = 0$).
		- $\text{rank}(C)=1$: $C = l l^T$, one line $x^T l = 0$ counted twice.

**Circular Points** A circumference $(X-X_o)^2 + (Y-Y_o)^2 - r^2 = 0$ has homogeneous matrix:

$$C = \begin{bmatrix} 1 & 0 & -X_o \\ 0 & 1 & -Y_o \\ -X_o & -Y_o & X_o^2 + Y_o^2 - r^2 \end{bmatrix}$$

Intersecting with $l_\infty$ ($w=0$) yields $x^2 + y^2 = 0, w = 0$: center $(X_o, Y_o)$ and radius $r$ disappear. All circumferences intersect $l_{\infty}$ at the same two complex conjugate **circular points**:

$$I = [1,i,0]^T, \quad J = [1,-i,0]^T$$

**Dual Conics** A dual conic is a set of lines $l$ satisfying $l^T C^* l = 0$, where $C^*$ is a $3 \times 3$ symmetric matrix:
- **Non-degenerate ($\text{rank}(C^*) = 3, \vert{}C^*\vert{} \ne 0$):** Set of lines tangent to a non-degenerate conic $C$, with $C^* = C^{-1}$.
- **Degenerate ($\text{rank}(C^*) < 3, \vert{}C^*\vert{} = 0$):**
	- $\text{rank}(C^*) = 2$: $C^* = p q^T + q p^T$, set of all lines passing through point $p$ or point $q$ ($l^T p = 0 \lor q^T l = 0$).
	- $\text{rank}(C^*) = 1$: $C^* = p p^T$, set of lines through $p$ counted twice.
		
- **Conic dual to the circular points ($C^*_\infty$):** Degenerate dual conic ($\text{rank} = 2$) representing the set of all lines going through $I$ or $J$:$$C^*_{\infty} = I J^T + J I^T = \begin{bmatrix} 1 & 0 & 0 \\ 0 & 1 & 0 \\ 0 & 0 & 0 \end{bmatrix}$$

# 6. Projective Mapping / Homography

An invertible mapping $h: \mathbb{P}^2 \to \mathbb{P}'^2$ that preserves collinearity. Induced by central projection between planes (e.g., scene plane to image, two images of a planar surface, two images from a camera rotating about its optical center, planar shadow on the ground).

> [!theorem] Fundamental Theorem of Projective Geometry A mapping $h: \mathbb{P}^2 \to \mathbb{P}'^2$ is projective iff there exists an invertible $3 \times 3$ matrix $H$ such that $x' = H x$.

- **Properties:** Linear in homogeneous coordinates (non-linear in Cartesian coordinates), **8 dof** (9 elements minus scale).
- **Transformation rules under $H$:**
	- Points: $x' = H x$
	- Lines: $l' = H^{-T} l$
	- Conics: $C' = H^{-T} C H^{-1}$
	- Dual conics: $C^{*'} = H C^* H^T$

**Homography Estimation via DLT (Direct Linear Transformation)** Since $x_i' = \lambda H x_i$, the vectors are collinear: $x_i' \times H x_i = 0$. Writing $H = [h_1, h_2, h_3]^T$ yields:

$$\begin{bmatrix} 0^T & -w_i' x_i^T & y_i' x_i^T \\ w_i' x_i^T & 0^T & -x_i' x_i^T \\ -y_i' x_i^T & x_i' x_i^T & 0^T \end{bmatrix} \begin{bmatrix} h_1 \\ h_2 \\ h_3 \end{bmatrix} = 0$$

Only 2 of the 3 equations are linearly independent (each point correspondence gives 2 constraints):
- **Exact case ($n = 4$ correspondences):** Gives $A_{8 \times 9} h = 0$, solved via Right Null Space $h = \text{RNS}(A)$.
- **Overdetermined case ($n > 4$ correspondences):** Minimize algebraic error $\arg\min_h \Vert{}A_{2n \times 9} h\Vert{}_2$ subject to $\Vert{}h\Vert{}_2 = 1$. Compute $\text{SVD}(A) = U D V^T$ (with singular values in decreasing order): $h$ is the last column of $V$ (eigenvector of $A^T A$ with minimum eigenvalue).

# 7. Hierarchy of 2D Transformations

Each transformation group is a subgroup of the ones below it and inherits all invariants of the groups below it.

> [!info] Isometry / Euclidean ($H_I$ — 3 dof: $t_x, t_y, \vartheta$)
>
> $$H_I = \begin{bmatrix} R_\perp & t \\ 0^T & 1 \end{bmatrix} = \begin{bmatrix} \cos\vartheta & -\sin\vartheta & t_x \\ \sin\vartheta & \cos\vartheta & t_y \\ 0 & 0 & 1 \end{bmatrix}, \quad R_\perp^T R_\perp = I, \quad \det(R_\perp) = 1 \text{ (or } -1 \text{ for reflection)}$$
>
> **Invariants:** lengths, distances, areas, shape, size, relative positions.

> [!info] Similarity ($H_S$ — 4 dof: $t_x, t_y, \vartheta, s$)
>
> $$H_S = \begin{bmatrix} sR_\perp & t \\ 0^T & 1 \end{bmatrix} = \begin{bmatrix} s\cos\vartheta & -s\sin\vartheta & t_x \\ s\sin\vartheta & s\cos\vartheta & t_y \\ 0 & 0 & 1 \end{bmatrix}$$
>
> **Invariants:** ratio of lengths, angles, shape (not size), circular points $I, J$ (and $C^*_\infty$).

> [!info] Affinity ($H_A$ — 6 dof: $A_{2 \times 2}$ rank 2 + $t$)
>
> $$H_A = \begin{bmatrix} A & t \\ 0^T & 1 \end{bmatrix} = \begin{bmatrix} a_{11} & a_{12} & t_x \\ a_{21} & a_{22} & t_y \\ 0 & 0 & 1 \end{bmatrix}, \quad \text{rank}(A) = 2$$
>
> **Invariants:** parallelism, ratio of parallel lengths, ratio of areas, line at infinity $l_{\infty}$. Linear in Cartesian coordinates.

> [!info] Projectivity ($H$ — 8 dof: $A + t + v$)
>
> $$H = \begin{bmatrix} A & t \\ v^T & 1 \end{bmatrix} = \begin{bmatrix} a_{11} & a_{12} & t_x \\ a_{21} & a_{22} & t_y \\ v_1 & v_2 & 1 \end{bmatrix}, \quad v=[v_1,v_2]^T$$
>
> **Invariants:** collinearity, incidence, order of contact (crossing, tangency, inflection), cross ratio. Maps origin to $[t_x, t_y]^T$ and axis directions to vanishing points $[a_{11}/v_1, a_{21}/v_1]^T$ and $[a_{12}/v_2, a_{22}/v_2]^T$.

# 8. 2D Reconstruction Problem (Image Rectification)

**Problem:** Given image points $x_i' = H x_i$, both scene points $x_i$ on plane $\pi$ and $H$ (8 dof) are unknown. We cannot simply invert $H$. **Combined Strategy:**

1. **Relax requirements (reduce unknowns):** Aim for a reconstruction up to a _similarity_ (same shape: $8 - 4 = 4$ unknowns) or up to an _affinity_ (parallelism preserved: $8 - 6 = 2$ unknowns).
2. **Add constraints** from geometric scene knowledge.

## A. Affine Reconstruction

> [!theorem] Affine Invariant A projective transformation $H$ maps $l_{\infty}$ onto itself iff $H$ is affine. _Proof:_ $H[x,y,0]^T$ has third coordinate $v_1 x + v_2 y = 0 \ \forall x,y \iff v_1 = v_2 = 0$.

**Method:** Find the image of the line at infinity $l'_{\infty} = [a,b,c]^T$ (e.g. from two vanishing points $v_1 = l_1 \times l_2$, $v_2 = l_3 \times l_4 \implies l'_{\infty} = v_1 \times v_2$) and apply a rectifying homography $H_{AR}$ that maps $l'_{\infty}$ back to $l_{\infty} = [0,0,1]^T$:

$$H_{AR} = \begin{bmatrix} 1 & 0 & 0 \\ 0 & 1 & 0 \\ a & b & c \end{bmatrix} \quad \text{(or any invertible matrix with last row } l_{\infty}'^T\text{)}$$

The reconstructed model $M_A = H_{AR} \cdot \text{Image}$ is an affine transformation of the original scene.

## B. Shape (Euclidean / Metric) Reconstruction — Theory & SVD

> [!theorem] Similarity Invariant A projective transformation $H$ maps the circular points $I, J$ (or equivalently $C^*_{\infty}$) onto themselves iff $H$ is a similarity.

**Method:** Estimate $C^{*'}_{\infty} = I' J'^T + J' I'^T$ in the image and find $H_{SR}$ that maps $C^{*'}_{\infty}$ back to $C^*_{\infty} = \text{diag}(1,1,0)$:
$$C^*_{\infty} = H_{SR} C^{*'}_{\infty} H_{SR}^T \implies C^{*'}_{\infty} = H_{SR}^{-1} C^*_{\infty} H_{SR}^{-T}$$

Applying Singular Value Decomposition to $C^{*'}_{\infty}$ (which, due to numerical noise, yields singular values $a, b$ instead of $1, 1$):
$$\text{svd}(C^{*'}_{\infty}) = U \begin{bmatrix} a & 0 & 0 \\ 0 & b & 0 \\ 0 & 0 & 0 \end{bmatrix} U^T = \left(U \begin{bmatrix} \sqrt{a} & 0 & 0 \\ 0 & \sqrt{b} & 0 \\ 0 & 0 & 1 \end{bmatrix}\right) \begin{bmatrix} 1 & 0 & 0 \\ 0 & 1 & 0 \\ 0 & 0 & 0 \end{bmatrix} \left(\begin{bmatrix} \sqrt{a} & 0 & 0 \\ 0 & \sqrt{b} & 0 \\ 0 & 0 & 1 \end{bmatrix} U^T\right)$$

Hence the rectifying homography is:
$$H_{SR} = \begin{bmatrix} \frac{1}{\sqrt{a}} & 0 & 0 \\ 0 & \frac{1}{\sqrt{b}} & 0 \\ 0 & 0 & 1 \end{bmatrix} U^T$$

## C. How to Find $I', J'$ or $C^{*'}_{\infty}$ in Practice

1. **Known Angles Between Lines:** For scene lines $l, m$ with angle $\vartheta$ between their normals:$$\cos\vartheta = \frac{l^T C^*_{\infty} m}{\sqrt{(l^T C^*_{\infty} l)(m^T C^*_{\infty} m)}} = \frac{l'^T C^{*'}_{\infty} m'}{\sqrt{(l'^T C^{*'}_{\infty} l')(m'^T C^{*'}_{\infty} m')}}$$
	- General known angle $\vartheta \rightarrow$ non-linear constraint on $C^{*'}_{\infty}$.
	- Orthogonal lines ($\vartheta = 90^\circ$) $\rightarrow$ **linear constraint:** $l'^T C^{*'}_{\infty} m' = 0$.
	- Known vanishing line $l'_{\infty} \rightarrow C^{*'}_{\infty} l'_{\infty} = 0$, i.e. $l'_{\infty} = \text{RNS}(C^{*'}_{\infty})$ (**2 linear constraints** that also enforce singularity).
	- **Counting constraints:** $C^{*'}_{\infty}$ has **4 dof** (9 elements $-$ 3 symmetry $-$ 1 scale $-$ 1 singularity). Since $\det(C^{*'}_{\infty}) = 0$ is non-linear, a linear solution requires either **5 independent orthogonal pairs**, or **$l'_{\infty}$ (2 constraints) + 2 orthogonal pairs**.
	- _Caveats:_ Always verify constraint independence (e.g. in Hartley-Zisserman Fig. 2.17, 5 window pairs reduce to 4 because $l'_{\infty}$ is fixed by parallelism). Only the target plane (and planes parallel to it) is rectified.

2. **Coplanar (or Parallel) Circumferences:** Intersect the images of 3 circumferences: $\{I', J'\} = C_1' \cap C_2' \cap C_3'$ (parallel non-coplanar circles also share $I, J$).
3. **Circumference + Parallelogram:** Find $l'_{\infty} = v_1 \times v_2$ from the two pairs of parallel sides, then intersect with the imaged circle: $\{I', J'\} = l'_{\infty} \cap C'$.
4. **Rigid Planar Motion:** A planar roto-translation is a pure rotation by angle $\vartheta$ around a center $O$: it is an isometry (hence similarity) and leaves 3 points fixed: $O, I, J$. In the image, $O', I', J'$ are fixed points under the inter-frame homography $H$ ($He = \lambda e$):
	- Fit $H$ between the two frames and compute its eigenvalues/eigenvectors.
	- Eigenvalues are proportional to $\{1, e^{i\vartheta}, e^{-i\vartheta}\}$.
	- Real eigenvector ($\lambda' = 1$) is $O'$; complex conjugate eigenvectors ($\lambda'', \lambda''' = e^{\pm i\vartheta}$) are $I', J'$, from which $C^{*'}_{\infty} = I' J'^T + J' I'^T$.

## D. Direct vs. Stratified Method

- **Direct Method:** Estimate $C^{*'}_{\infty}$ in one step from 4–5 constraints, then rectify via SVD.
- **Stratified Algebraic Method (often numerically more stable):**
	1. _Projective $\to$ Affine:_ Rectify the image using $l'_{\infty}$ via $H_{AR}$.
	2. _Affine $\to$ Metric:_ On the affinely rectified image, the remaining distortion is a pure affinity $H_A = \begin{bmatrix} G & t \\ 0^T & 1 \end{bmatrix}$, so the dual conic to the circular points has the simplified form: $$C^{*'}_{\infty} = H_A C^*_{\infty} H_A^T = \begin{bmatrix} G G^T & 0 \\ 0^T & 0 \end{bmatrix} = \begin{bmatrix} S & 0 \\ 0^T & 0 \end{bmatrix}$$
		where $G$ is a $2 \times 2$ invertible matrix. Taking $G = \begin{bmatrix} g_{11} & g_{12} \\ 0 & g_{22} \end{bmatrix}$ upper-triangular, $S = G G^T = \begin{bmatrix} g_{11}^2 + g_{12}^2 & g_{12}g_{22} \\ g_{12}g_{22} & g_{22}^2 \end{bmatrix}$ is symmetric and homogeneous (**only 2 dof**).
		- Each pair of orthogonal lines gives 1 linear equation on $S$: $l'_{1:2}{}^T S \, m'_{1:2} = 0$.
		- **2 non-parallel pairs of orthogonal lines** determine $S$.
		- Extract $G$ via **Cholesky factorization** of $S = G G^T$ and rectify via $H_{rect} = H_A^{-1} = \begin{bmatrix} G & t \\ 0^T & 1 \end{bmatrix}^{-1}$ (**no SVD needed**).

- **Stratified Geometric Method:**
	1. _Projective $\to$ Affine:_ Estimate a 4-point homography mapping 4 corners of a known scene parallelogram/rectangle onto an actual parallelogram.
	2. _Affine $\to$ Metric (1st orthogonal pair):_ Apply a 3-point affinity $H_{A1}$ ($A, B, C \to A', B', C'$) that makes the first pair of lines orthogonal.
	3. _Affine $\to$ Metric (2nd orthogonal pair):_ Given the second pair forming a triangle $ABC$ with altitude $CH \perp AB$, move $C$ along line $HC$ to $C'$ so that $\triangle ABC'$ is right-angled at $C'$. By **Euclid's theorem**, $HC' = \sqrt{AH \cdot HB}$ ($HC'^2 = AH \cdot HB$). Apply the 3-point affinity $H_{A2}$ mapping $A \to A, B \to B, C \to C'$, which enforces the second orthogonality while preserving the first.

## E. Numerical Accuracy Issues

1. **Noise in SVD:** Singular values of $C^{*'}_{\infty}$ are $a, b \ne 1$ $\rightarrow$ normalize with $1/\sqrt{a}, 1/\sqrt{b}$.
2. **Line intersection uncertainty:** Intersecting lines that are too close to each other in the image yields poor vanishing point estimates $\rightarrow$ choose lines as far apart as possible.
3. **Vanishing points near infinity:** When images of parallel lines are almost parallel in the image, vanishing points lie very far away $\rightarrow$ poor estimation of $l'_{\infty}$ and inaccurate affine rectification.