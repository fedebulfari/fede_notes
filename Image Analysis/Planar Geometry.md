---
date: 11-10-2026
subject: Image Analysis
description: Planar projective geometry for image rectification — homogeneous points, lines, vanishing points, cross ratio, conics, homographies, and affine/metric reconstruction from invariants.
---

> [!summary] Overview
> Central projection is non-linear, does not preserve shape or ratios. To understand what we get from what we see we study planar projective geometry: points, lines, conics and their transformations, then use invariants to rectify an image of an unknown planar scene.

# 1. Homogeneous coordinates for points

Embed the Euclidean plane $X,Y$ as the plane $w=1$ in 3D. A point $P=[X,Y]$ is represented by any non-zero multiple of $[X,Y,1]^T$:$$x = [x,y,w]^T = w[X,Y,1]^T, \ X = \frac{x}{w},\ Y = \frac{y}{w}$$
- Homogeneity: $x$ is equivalent to $\lambda x$, $\lambda \ne 0$.
- 3 coordinates for 2 dof: the two independent ratios $x:y:w$.
- The null vector $[0,0,0]^T$ represents no point.
- Projective plane: $\mathbb{P}^2 = \mathbb{R}^3 \setminus \{0\}$ modulo scale.

>[!example] Example: $[9,6,3]^T \sim [3,2,1]^T \rightarrow [3,2]$, $[0,-8,-4]^T \sim [0,2,1]^T \rightarrow [0,2]$.

## 1.1 Points at infinity

Points with $w=0$, e.g. $[x,y,0]^T$, have no Cartesian counterpart. They represent directions. All directions in a plane meet at infinity.

Line at infinity: $l_{\infty} = [0,0,1]^T$. A point $x$ is at infinity iff $l_{\infty}^T x = w = 0$.

# 2. Lines, incidence and duality

A line is $ax + by + cw = 0$, i.e.:$$l^T x = [a,b,c][x,y,w]^T = 0$$

For $c=0$ the line passes through the origin. $l$ is homogeneous like $x$.

Incidence is symmetric: $l^T x = x^T l = 0$. Point $x$ on line $l$ $\Leftrightarrow$ point $l$ on line $x$ in dual space. This is the duality principle between points and lines.

## 2.1 Line through two points

$x_1 \times x_2 = l$. Dual: intersection of two lines is $x = l_1 \times l_2$.

In coordinates: if $l_1^T x = 0$ and $l_2^T x = 0$, then $x$ is the null-space of $[l_1^T;l_2^T]$, i.e. the cross product.

# 3. Vanishing points and vanishing line

> [!theorem] Vanishing point
> The image of a set of parallel lines $l_i$ is a set of lines $l_i'$ concurrent at a common point $x'$, called the vanishing point of that direction.

Vanishing point = image of a point at infinity, where images of parallel lines concur.

Vanishing line / horizon $l'_{\infty}$: image of the set of points at infinity, i.e. image of $l_{\infty}$. All vanishing points lie on $l'_{\infty}$. Given two vanishing points $V_1,V_2$:

$$l'_{\infty} = V_1 \times V_2$$

# 4. Cross ratio — the projective invariant

Lengths and ratios of lengths are NOT invariant. Example in slides: $50/-50 = -1$ in scene becomes $420/-160 = -2.62$ in image.

For 4 collinear points $Y,Z,X_1,X_2$ with abscissae $a,b,c,d$:

$$CR_{Y,Z,X_1,X_2} = \frac{\frac{c-a}{c-b}}{ \frac{d-a}{d-b}}$$
If $X_1 = \alpha_1 Y + \beta_1 Z$ and $X_2 = \alpha_2 Y + \beta_2 Z$, then:$$CR_{Y,Z,X_1,X_2} = \frac{\beta_1 / \alpha_1}{\beta_2 / \alpha_2}$$
Since a homography $H$ preserves linear combinations, $X_1' = H X_1 = \alpha_1 Y' + \beta_1 Z'$, coefficients are unchanged, hence:$$CR_{Y',Z',X_1',X_2'} = CR_{Y,Z,X_1,X_2}$$
Dual: cross ratio of 4 concurrent coplanar lines = 1D cross ratio of their intersections with any transversal.

# 5. Conics

Second-degree curve: $x^T C x = 0$, with $C$ symmetric $3 \times 3$:$$C = \begin{bmatrix} a & b/2 & d/2 \\ b/2 & c & e/2 \\ d/2 & e/2 & f \end{bmatrix}$$
- 5 dof (6 elements minus scale).
- Ellipse, parabola, hyperbola = different intersections of plane with cone. 
	- Parabola: plane parallel to a cone side.
	- Ellipse: plane with $\theta_{plane}<\theta_{cone}$.
	- Hyperbolae:  plane with $\theta_{plane}>\theta_{cone}$
	![[Planar Geometry-1791805957885.webp|417]]
- Intersection line-conic gives quadratic: 2 distinct real, 2 coincident real, or 2 complex conjugate solutions.

Non-degenerate if $rank(C)=3$, $|C| \ne 0$. 
Degenerate if $|C|=0$:
- $rank(C)=2$: $C = l m^T + m l^T$, two lines $x^T l = 0$ or $m^T x = 0 \ $.
- $rank(C)=1$: $C = l l^T$, one line counted twice.
![[Planar Geometry-1791807415729.webp]]
Transformation under $H$: $C' = H^{-T} C H^{-1}$.

## 5.1 Circular points

All circumferences intersect $l_{\infty}$ at the same two complex points:$$I = [1,i,0]^T, \ J = [1,-i,0]^T$$
They are the same for all circles — centre and radius disappear on $l_{\infty}$.

## 5.2 Dual conics

Set of tangent lines $l$ to $C$: $l^T C^* l = 0$, with $C^* = C^{-1}$ for non-degenerate $C$.

Dual conic to the circular points:$$C^*_{\infty} = I J^T + J I^T = \begin{bmatrix} 1 & 0 & 0 \\ 0 & 1 & 0 \\ 0 & 0 & 0 \end{bmatrix}$$
Transformation: $C^{*'} = H C^* H^T$. Additional info $C^{*'}_{\infty} = I' J'^T + J' I'^T$ is equivalent to $I',J'$.

# 6. Projective mapping / homography

A mapping between two planes induced by central projection. E.g. shadow of planar silhouette on ground, mapping between two images of a planar scene, or two images by a camera rotating about its centre.

It is invertible, preserves collinearity. Also called projectivity, homography.$$x' = H x,\  H_{3 \times 3} \text{ invertible, 8 dof (9 elements minus scale)}$$.
Estimation: 4 point correspondences determine $H$ (each gives 2 constraints). Solve $x_i' \times H x_i = 0$.

Transforms:
- points: $x' = H x$
- lines: $l' = H^{-T} l$
- conics: $C' = H^{-T} C H^{-1}$
- dual conics: $C^{*'} = H C^* H^T$

# 7. Hierarchy of 2D transformations

Each group inherits invariants of the groups above it.

> [!info] Isometry / Euclidean:
$H_I$ — 3 dof: $t_x,t_y,\theta$$$H_I = \begin{bmatrix} R & t \\ 0^T & 1 \end{bmatrix},\ R^T R = I,\ det(R)=1$$
Invariants: lengths, distances, areas, shape + size + pose.

>[!info] Similarity:
> $H_S$ — 4 dof: $t_x,t_y,\theta,s$$$H_S = \begin{bmatrix} sR & t \\ 0^T & 1 \end{bmatrix}$$
Invariants: ratio of lengths, angles, shape. Fixes $I,J$.

>[!info] Affinity:
> $H_A$ — 6 dof: $A$ $2 \times 2$ rank 2 + $t$$$H_A = \begin{bmatrix} A & t \\ 0^T & 1 \end{bmatrix}$$
Invariants: parallelism, ratio of parallel lengths, ratio of areas. Fixes $l_{\infty}$. Linear in Cartesian coordinates.

>[!info] Projectivity:
> $H$ — 8 dof: $A + t + v$$$H = \begin{bmatrix} A & t \\ v^T & 1 \end{bmatrix},\ v=[v_1,v_2]^T$$
Invariants: collinearity, incidence, order of contact (crossing, tangency, inflection), cross ratio.

# 8. 2D reconstruction problem

Given: image points $x_i' = H x_i$ known, but scene $x_i$ on plane $\pi$ and $H$ unknown. Cannot simply invert $H$ — 8 unknowns.

Strategy:
1. Reduce unknowns: require reconstruction similar (shape, 4 unknowns = 8-4) or affine (2 unknowns = 8-6) to original.
2. Add constraints from scene knowledge.

## 8.1 Affine reconstruction

> [!theorem] Affine invariant
> $H$ maps $l_{\infty}$ onto itself iff $H$ is affine.

Proof sketch: $[x,y,0]^T$ maps to third coordinate $v_1 x + v_2 y = 0$ for all $x,y$ iff $v=0$.

Method: image $l'_{\infty}$ is in general $\ne l_{\infty}$. Use it as additional info. Find $H_{AA}$ mapping $l'_{\infty}$ back to $l_{\infty}$:

- $v_1 = l_1 \times l_2$, $v_2 = l_3 \times l_4$ from two pairs of images of parallel lines
- $l'_{\infty} = v_1 \times v_2 = [a,b,c]^T$
- $H_{AA} = \begin{bmatrix} * & * & * \\ * & * & * \\ a & b & c \end{bmatrix}$ (first two rows arbitrary, ensure invertible)
- Model $M_A = H_{AA} \times \text{Image}$ is affine to original.

## 8.2 Shape / Euclidean reconstruction — theory

> [!theorem] Similarity invariant
> $H$ maps $I$ and $J$ onto themselves iff $H$ is a similarity.

Idea: $\{I,J\} = \text{circle} \cap l_{\infty}$ maps under similarity to another circle $\cap$ $l_{\infty} = \{I,J\}$.

Method: use $I',J'$ (images of $I,J$, in general $\ne I,J$) as info. Find $H_{SS}$ mapping them back to $I,J$. Equivalent to mapping $C^{*'}_{\infty}$ back to $C^*_{\infty}$:$$C^{*'}_{\infty} = H_{SS}^{-1} C^*_{\infty} H_{SS}^{-T}$$
Via SVD: $svd(C^{*'}_{\infty}) = U \text{diag}(a,b,0) U^T$, rectification (up to noise-corrected $a,b$):$$H_{SS} = \begin{bmatrix} 1/a & 0 & 0 \\ 0 & 1/b & 0 \\ 0 & 0 & 1 \end{bmatrix} U^T$$
Model $M_S = H_{SS} \times \text{Image}$ has same shape as original.

Accuracy note: in principle $\text{diag}(1,1,0)$, but noise gives $\text{diag}(a,b,0)$. Normalise with $1/a,1/b$.

## 8.3 How to find $I',J'$ or $C^{*'}_{\infty}$ in practice

1. Known angles between lines
2. Known shapes, e.g. circumferences
3. Combinations
4. Rigid planar motion

	1. **Angles:** for scene lines $l,m$, angle $\theta$ between normals:$$\cos \theta = \frac{l^T C^*_{\infty} m}{\sqrt{(l^T C^*_{\infty} l)(m^T C^*_{\infty} m)}}$$
		In image:$$\cos \theta = \frac{l'^T C^{*'}_{\infty} m'}{\sqrt{(l'^T C^{*'}_{\infty} l')(m'^T C^{*'}_{\infty} m')}}$$
		- Known $\theta$ → non-linear equation in $C^{*'}_{\infty}$.
		- Perpendicular $\theta=90°$ → linear: $l'^T C^{*'}_{\infty} m' = 0$.
		- $C^{*'}_{\infty} l'_{\infty} = 0$ → 2 constraints; $l'_{\infty} = RNS(C^{*'}_{\infty})$.
		- $C^{*'}_{\infty}$ symmetric, homogeneous, singular → 4 dof. Need 4 independent constraints, but singularity is non-linear → use 5 orthogonal pairs, or $l'_{\infty}$ (2 constraints) + 2 orthogonal pairs.
	
		Caveat: only one plane (+ parallel planes) is rectified, not other planes. Check independence — e.g. Hartley-Zisserman Fig. 2.17 five pairs reduce to four.
		
	2. **Coplanar circumferences:** $\{I',J'\} = C_1' \cap C_2' \cap C_3'$. Also parallel non-coplanar circles intersect in $I,J$.
	3. **Circumference + parallelogram:** vanishing points $v_1 = p' \times q'$, $v_2 = l' \times m'$, $l'_{\infty}=v_1 \times v_2$, then $\{I',J'\}=l'_{\infty} \cap C'$.
	4. **Rigid planar motion:** planar motion is isometry → similarity → fixes $I,J$. Any roto-translation is pure rotation about $O$ with angle $\vartheta$: 3 invariants $I,J,O$, hence $I',J',O'$ fixed. Fit inter-frame homography $H$, eigen-decompose: eigenvalues $\sim 1, e^{i\theta}, e^{-i\theta}$; eigenvector for $1$ is $O'$, complex ones are $I',J'$.

## 8.4 Direct vs stratified method

Direct: estimate $C^{*'}_{\infty}$ with 4-5 constraints, SVD, $H_{SS}$.

Stratified — often more stable:
1. Projective → affine via $l'_{\infty}$ as above.
2. Affine → metric. After affine rectification:$$C^{*'}_{\infty} = \begin{bmatrix} S & 0 \\ 0^T & 0 \end{bmatrix},\ S = G G^T,\  $G$ 2 \times 2 \text{invertible}$$.
Take $G$ upper-triangular $G=\begin{bmatrix} g_{11} & g_{12} \\ 0 & g_{22} \end{bmatrix}$, so $S=\begin{bmatrix} g_{11}^2+g_{12}^2 & g_{12}g_{22} \\ g_{12}g_{22} & g_{22}^2 \end{bmatrix}$ — only 2 unknowns. Each orthogonal pair: $l'^T_{1:2} S\, m'_{1:2} = 0$.
Two pairs suffice. Cholesky gives $G$, then $H_{rect} = \begin{bmatrix} G^{-1} & -G^{-1}t \\ 0^T & 1 \end{bmatrix}$. No SVD needed.

Geometric variant: 4-point homography for affine step, then enforce orthogonality with Euclid theorem $HC'^2 = AH \cdot HB$ for metric step.

## 8.5 Accuracy issues

1. Noise in SVD singular values.
2. Poor line intersections when lines are too close — use far apart lines.
3. Vanishing point near infinity (images almost parallel) → $l'_{\infty}$ inaccurate → affine step inaccurate.

---
Related: [[_Image Analysis MOC]]
Source: [[IACV 2026 - C - 2D Projective Geometry and 2D Reconstruction.pdf]]
