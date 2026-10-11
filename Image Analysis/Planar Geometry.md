---
date: 11-10-2026
subject: Image Analysis
---

## Vanishing point
- Parallel lines are transposed as orthogonal lines intersecting in the vanishing point.

## Cross Ratio
- The Cross Ratio (ratio between the ratios) in the distances between the points is invariant.
- $CR_{y,a,x_{i}}=\frac{\frac{c-a}{c-b}}{\frac{c-a}{c-b}}=CR_{y,y,x_{i},x_{i}^{i}}$

## Unitary geometric element
- Identified by Homogeneous Coordinates.
- Coordinates x, y, w.
- $f=[\begin{matrix}x\\ y\\ w\end{matrix}]$
- A point is identified by any multiple of the triplet.
- Cartesian Coordinates.
- $E_{5}p=[\begin{matrix}1\\ 2\\ 1\end{matrix}]=[\begin{matrix}0\\ 1\\ 4\end{matrix}]$
- $p=[\begin{matrix}x\\ y\\ w\end{matrix}]=w[\begin{matrix}x/w\\ y/w\\ 1\end{matrix}],X=x/w,y=y/w$

## Points at infinity
- Thanks to the triplet I can find points at infinity.
- Obtain points at infinity representing a direction.
- A direction is a point.

## Line
- Represented as $ax+by+cw=0\rightarrow[abc][\begin{matrix}x\\ y\\ w\end{matrix}]=0\rightarrow b^{4}x=0$.
- For c=0 the line passes through the origin.

## Line through Two Points
- `[IMAGE: Diagram showing a line l passing through two points x1 and x2 on a grid]`
- points playing on a line to construct a x, and x acts in turn on equivalent representations, obtaining parameters for a 2D line.

## Incidence
- $x=[\begin{matrix}x\\ y\\ w\end{matrix}]secl=[\begin{matrix}a\\ 6\\ c\end{matrix}]=zG=(\begin{matrix}a\\ 6\\ c\end{matrix}]pesseattrarsex=(\begin{matrix}x\\ y\\ w\end{matrix}]$

## Line at the Infinity
- Points at infinity of lines can be identified by w=0.

## The duality principle between points and lines
- Since dot product is commutative $\rightarrow$ incidence relation is commutative.
- $l^{T}x=[\begin{matrix}a&b&c\end{matrix}][\begin{matrix}x\\ y\\ w\end{matrix}]=[\begin{matrix}x&y&w\end{matrix}][\begin{matrix}a\\ b\\ c\end{matrix}]=\underline{x^{T}I=0$.
- point x is on line l.
- point l is on line x.
- Principle of duality between points and lines (50% discount principle).

## Point on Two Lines
- $\begin{cases}C_{4}^{T}x=0\Rightarrow x=RN5([\begin{matrix}L_{1}^{T}\\ L_{2}^{T}\\ \end{matrix}])$
- x is the cross-product of l1 and l2.
- $x=L_{1}\times L_{2}$

## Line through Two Points
- DUAL: The linear combination of two lines.
- Property: given by the linear combination $C=x_{2}\times x_{1}$.

## Conics
- PARABOLAE, ELLIPSE, HYPERBOLAE.
- Intersecting a plane with the cone I obtain the 3 families of conics.
- Parabola: Plane // to an element of the Cone.
- Ellipse: Plane not // to the Cone.
- Represented as $x^{T}Cx=0,C_{\infty}[\begin{matrix}a&b/c&d/2\\ b/2&c&d/2\\ c/2&d/2&f\end{matrix}]\mapsto Symmetric$.
- 5 degrees of freedom.
- Circumferences $C=Cmr_{0}r=C^{T}$.

## Intersection Conics
- $\int x^{T}Cx=0$
- Leads to an equation of 2 solutions (2 Distinct Real, 2 Coincident Real, 2 Complex Conjugate).
- Intersection between a Circumference (Particular Conic) and the line at infinity (Loo).
- These will always meet at 2 points.
- $I=[\begin{matrix}1\\ i\\ 0\end{matrix}],3_{2}[\begin{matrix}1\\ -i\\ -\end{matrix}],6]$

## Degenerate Conics
- $\begin{cases}x^{2}-2X_{a}w+X_{a}^{2}w^{2}+y^{2}-2Y_{a}w+Y_{a}^{2}w^{2}-r^{2}w^{2}=0$
- $\begin{cases}x^{2}+y^{2}=0\\ w=0\end{cases}$
- The circumference parameters (center and radius) disappear from the equation.
- the two intersection points are the same for all circumferences.
- $I=[\begin{matrix}1\\ i\\ 0\end{matrix}]and~f=[\begin{matrix}1\\ -i\\ 0\end{matrix}]$ is the imaginary unit number).
- Non degenerate: $rank(C)=3$.
- Degenerate: $\vert{}C\vert{}=0, rank(C)<3$.

## Dual Conics
- Set of tangent lines to a non-degenerate Conic C.
- two cases:
  - $rank(C)=2~C=hm^{T},$ mf with l and m are column vectors.
  - $\Rightarrow x^{T}C~x=x^{T}(lm^{T}+ml^{T})x=2x^{T}lm^{T}x=2(x^{T}l)(m^{T}x)=0$.
  - $x^{T}l=0$ OR $m^{T}x=0$.
  - $rank(C)=1,C=II^{T}v$ with l column vector.
  - $\rightarrow x^{T}Cx=x^{T}ll^{T}x=(x^{T}l)(l^{T}x)=0$.
  - $x^{T}I=0$ counted 2 times.
- Nondegenerate dual conic C is the set of lines TANGENT to a nondegenerate conic C with $c^{*}=c^{-1}$.
- Conic Dual to the Circular Points. $C_{\infty}^{*}=[3^{T}+3T^{T}=[\begin{matrix}1&0\\ 0&+&0\\ 0&0&0\end{matrix}]$.

## Projective Mapping
- A Projective mapping between 2 planes.
- The shadow cast by a planar silhouette onto a ground plane is a projective transformation of the planar silhouette, since they are related by a central projection.
- It is an invertible Mapping preserving Collinearity.
- Also called Projectivity & Homography.
- Mappings between two planes induced by central projection are projective, since they preserve collinearity.
- Mapping between two images of a planar scene is a homography.
- Two images of a 3D scene, taken by a camera rotating about its center are related by a homography.

## Fundamental Theorem
- A mapping h in IP is a projection.
- 8 degrees of freedom.
- A 3x3 invertible Matrix H point p represented by a vector, $h(x)= Hx$.

## Homography estimation from Point Correspondences
- Since I have 8 degrees of freedom determined by the ratio of its elements.
- H can be calculated starting from 4 point correspondences (4 points of a plane and their projections on the image).
- $x_{i}^{\prime}=Kx_{i}=KKKx_{i},x_{i}^{\prime}\times Kx_{i}=0$.
- Every Point is transformed.
- Every Line is transformed.
- Every Conic is transformed $e\rightarrow K^{-T}CK^{*}=C^{\prime}$.
- Every Dual Conic is transformed.

## Vanishing point
- Point where the lines of an image collide.
- Vanishing Line: Line connecting 2 or more vanishing points. Also called Horizon.

## Hierarchy of Projective Transformation
- Projective: 8 dof. Invariant properties: Concurrency, collinearity, order of contact, cross ratio.
- Affine: 6 dof. $\begin{matrix}a_{11}&a_{12}&t_{x}\\ a_{21}&a_{22}&t_{y}\\ 0&0&1\end{matrix}]$. Invariant properties: Parallelism, ratio of areas, ratio of lengths on collinear or parallel lines.
- Similarity: 4 dof. $\begin{matrix}r_{11}&r_{12}&t_{X}\\ r_{22}&r_{22}&t_{3}\\ 0&0&1\end{matrix}]$. Invariant properties: Ratio of lengths, angle. The circular points I, J.
- Euclidean: 3 dof. Invariant properties: Length, area.
- Each Group inherits the invariants of the overarching Group.

## Transformations
- `[IMAGE: Diagram showing combined mapping as an identity with unknown projective map H]`
- `[IMAGE: Diagram showing combined mapping as a similarity and an affinity]`
- Isometries: 3 degrees of freedom: Translation t + rotations $\theta$. Invariants: Lengths, Distances, Areas.
- Similarities: 4 degrees of freedom: Translation t + rotations $\theta$ + Scale s. Invariants: ratio of lengths, angles.
- Affinities: $K_{A}=[\begin{matrix}A&t\\ 0&0&t\end{matrix}]=[\begin{matrix}a_{xx}&a_{xx}&a_{xx}&t_{yy}\\ 0&0&0&1\end{matrix}]$ A: 2x2 Matrix, rank 2. 6 degrees of freedom. Invariants: ratio between areas, Parallelisms, Ratio between parallel lengths.
- Projectivities: $K=[\begin{matrix}A&t\\ 0&0&t\end{matrix}]=[\begin{matrix}a_{xx}&a_{x2}&t_{x}\\ a_{21}&a_{22}&t_{y}\\ v&v&1\end{matrix}]$. A: 2x2 Matrix, rank 2. 8 degrees of freedom. Invariants: Collinearity, Incidence, Order of contact, Cross ratio.

## 2D Reconstruction
- Instead of using 4 points I use 4 coplanar lines.
- $CR_{V,X_{+},X_{2}}=\frac{c-a}{\epsilon-b}/\frac{d-a}{d-b}$
- When I reconstruct an image its original properties are not known (E.g. Camera pos, Focals...).
- Formally therefore, of Scene X, I know points $x_{i}$ and X' Image, I cannot therefore simply invert H.
- I can therefore try to reduce the unknowns and set constraints.
- To reduce the unknowns I use Similarities or Affinities.

## Adding constraints
- Affine Reconstruction: The affine map maps the Line at infinity into itself.
- Shape (Euclidean) Reconstruction: A similarity transformation is the Transformation mapping the circular points I and J into themselves.
- I can, instead of using the images of the circular points, use the image of the dual Conic $C_{\infty}^{*}$.
- $C_{\infty}^{*}=53^{7}+32^{7}+[\begin{matrix}7&0\\ 0&1&0\\ 0&0\\ 0&0\end{matrix}]\times C_{\infty}^{*}$
- Singular Value Decomposition
- $svd(C^{T})\rightarrow K_{2n}[\begin{matrix}1&0&0\\ 0&0&0\\ 0&0\end{matrix}]K_{xn}^{T}=U_{\perp}^{-1}[\begin{matrix}0&0&0\\ 0&1&0\end{matrix}]U_{\perp}^{-1}$
- We can find $C_{\infty}^{*}$ by observing details on the image.
- Known angles between lines.
- Known shapes.
- Combinations between points.
- Observation of Rigid translational Planar motion.
- Angles: $cos~\theta=\frac{a_{1}a_{2}+b_{1}b_{2}}{\sqrt{(a_{1}^{2}+b_{1}^{2})(a_{2}^{2}+b_{1}^{2})}},a_{1}a_{2}+b_{1}b_{2}=[\begin{matrix}a_{1}b_{1}c_{1}\end{matrix}][\begin{matrix}b_{2}\\ b_{2}\\ c_{1}\end{matrix}]=c^{7}C_{m}^{p}$

## Direct Method
- `[IMAGE: Illustration showing projection and (affine) rectification mapping H_p and H_A between image planes \pi_1, \pi_2, \pi_3]`
- Trace lines parallel to the lines of the images, converging to the horizon, with known relative angles.
- I obtain linear constraints on $C_{\infty}^{*\prime}$.
- $C_{0}^{\prime\prime}=I^{\prime}3^{\prime}+3^{\prime}I^{\prime T}$.
- $M_{s}=K_{sac}\cdot\Gamma_{moge}$.

## Stratified Method
- Affine Reconstruction -> Projective -> Affine.
- Shape Reconstruction -> Affine -> Metric.
- Affine Reconstruction: Takes lines from the horizon incident in 2 foci.
- $v_{1}=l_{1}\times l_{2}$, $\Gamma_{m}=v_{1}\times v_{2}$, $v_{y}=l_{y}\times l_{4}$.
- Where GG is a 2x2 invertible matrix.
- $G=(\begin{matrix}g_{11}&g_{11}\\ 0&g_{21}\end{matrix}),GG^{T}=[\begin{matrix}g_{11}+g_{12}^{2}&g_{12}&g_{12}\\ g_{22}g_{21}&g_{22}\end{matrix}]$.

## Shape Reconstruction
- Given the constraints already analyzed previously, since GG is an origin symmetric matrix, there are only 2 remaining unknowns in $C_{\infty}^{*}$.
- I have thus calculated GG.
- There is a margin of error given by numerical "Noise", estimates on intersections.
- Geometric Stratified Method.

---
Related: [[_Image Analysis MOC]]
Source: