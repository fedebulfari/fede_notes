---
date: 11-10-2026
subject: Image Analysis
---

# Camera Geometry

## Camera Projections

- As seen previously, matrices are 3x4 and no longer invertible, being transpositions from a 3D space to a 2D one.
- $\underline{u}_{2}=[M_{2+1};m_{2+1}]X_{1}$ where $H_{3\times3}$ is invertible.
- Given a point u from the image, we can however recover the visual ray that generated it as a straight line passing through the center of the lens.
- Any X on the ray is projected as $PX = PO + PX = PX$.

## Vanishing Point Theorem

- The Ray of Vision associated with V, vanishing point of direction d, is parallel to d.
- This allows us to define important information following the directions d from V.

## Camera Projection

- It is necessary to calibrate our system to be able to study.
- Offset: $c_{x}, c_{y}$.
- Camera Projection: $Pr[x_{1},y_{1},z_{1}]\rightarrow p\cdot[x_{1}-y_{2}]:::\{\begin{matrix}x_{1}+f-\frac{x_{2}}{2_{1}}+u_{2}\\ y_{1}+f=\frac{y_{1}}{2_{1}}-x_{2}\end{matrix}$.
- Pixel aspect ratio.
- Therefore the homogeneous projection of a point on a pixel translates as:
$\underline{u}=[\begin{matrix}x\\ y\\ w\end{matrix}]=[\begin{matrix}f+0&w\\ 0&f_{+}&w_{-}\\ -0&+\end{matrix}][\begin{matrix}x\\ y\\ 2\end{matrix}]+[\begin{matrix}f+0&w\\ 0,f+y_{+}\end{matrix}]p+[k+][\begin{matrix}x\\ 2\\ 1\end{matrix}]+[\begin{matrix}x\\ 2\\ 1\end{matrix}]x_{con}$.

## Calibration Matrix

- In general, the World Reference is Camera Reference $X_{cam}$.
- $\underline{x}=[K\cdot a]\times_{ctm}=[K\cdot][\begin{matrix}R\cdot c\\ …\end{matrix}]X_{crecd}=[KR\cdot Kt]\times_{mat}\oplus\underline{M\cdot KR,=-KL$.
- K: Calibration Matrix, contains the Intrinsic parameters of the camera.
- M = K[R t]: Projection Matrix, contains Intrinsic and Extrinsic parameters of the camera.

## Camera Calibration

- Intrinsic calibrations:
	- Focal distance $f_{x}$
	- Focal distance $f_{y}$
	- Principal Point (u, v)
	- Skew factor
	- Aspect Ratio a $=\frac{f_{2}}{f_{r}}$
- Extrinsic calibrations: relation of the Camera in the world
	- World Rotation R
	- World Translation t

## Angles between Rays

- $d=(KR)^{-1}u\rightarrow R^{-1}K^{-1}u$
- $d^{T}=\omega^{T}(KR)^{-T}+\omega^{T}K^{-T}R$
- $u~cos~\theta=\frac{d_{z}^{T}d_{z}}{\sqrt{(u^{T}d_{z})(d_{z}^{T}d_{z})}}=\frac{u_{z}^{T}(k^{-T}k^{-T})a_{z}}{\sqrt{u\epsilon(k^{T}k^{-T})u_{z})(u_{z}^{T}(k^{T}k^{-T})u_{z})}}=T_{z}dy=dyR$
- We define $w^{3}(KK^{1})^{-1}=-m+0\le0$

## Homography between a Plane and Its Image

- The image of a planar scene is a Homography between Plane $\pi$ and its image.
- $u=Hx_{\pi}$
- $X_{x^{\prime}}[\begin{matrix}x\\ y\\ w\end{matrix}],X_{w^{\prime}},X_{w^{\prime}}[\begin{matrix}r_{z}&r_{zz}&0&0&i\end{matrix}][\begin{matrix}y\\ y\\ y\\ w\end{matrix}],[\begin{matrix}r_{z},&r_{zz}&0_{z}\\ 0&0&1\end{matrix}][\begin{matrix}u\\ y\\ w\end{matrix}]$
- $u=PX_{w}=[\begin{matrix}K_{0}\end{matrix}][\begin{matrix}r_{x1}&r_{x2}\\ 0&0\end{matrix}]x_{x}=K[r_{xx}&r_{x1}&r_{x2}&o_{x}\end{matrix}]x_{z}$
- Plane $\in$ Image Homography
- $K=K[\begin{matrix}r_{x},&r_{z}&r_{x}\end{matrix}]$
- If Plane is parallel to image plane $H$
- $P_{EEE}^{2}[\begin{matrix}1\\ 2\\ 0\end{matrix}]_{+}=P_{EEE}^{2}[\begin{matrix}0\\ 1\\ 0\end{matrix}]=m[\begin{matrix}r_{EEE}&F_{EEE}&0_{EE}&0_{EE}\end{matrix}]+[\begin{matrix}1&0&x_{E}\\ 0&0&1\end{matrix}]$ $o_{\pi}$
- $u_{2}=K[\begin{matrix}r_{11}&r_{12}&r_{12}&\cdot\cdot\cdot r_{22}\end{matrix}],u_{22}=[\begin{matrix}f_{11}&0&a_{2}\\ -f_{11}&a_{2}\\ 0&0&0&0\end{matrix}](\begin{matrix}1&0&x_{1}\\ 0&0&1\end{matrix}),x_{1}$
- $=H=20\cdot ayline\cdot2D\cdot amety=20.2ylin2ky$
- If furthermore the camera is natural
- $P_{EEE}=[\begin{matrix}cos~\theta\\ cos~\theta\\ sin~\theta\\ sin~\theta\\ sin~\theta\\ sin~\theta\\ \end{matrix}]=[\begin{matrix}-1~cos~\theta\\ cos~\theta\\ 0\end{matrix}]=\epsilon_{1}[\begin{matrix}r_{11}&r_{22}&\theta_{22}&\theta_{22}\end{matrix}]=[\begin{matrix}0&r_{2}\\ 0&r_{1}\\ \end{matrix}]$
- $q_{2}=K[\begin{matrix}r_{xx}&r_{xx}&r_{xx}\end{matrix}]d_{y}=[\begin{matrix}f&0&a_{x}\\ -f&r_{x}&r_{x}\\ 0&0&1\end{matrix}][\begin{matrix}R&r_{x}\\ 0&r\end{matrix}]\times_{y}$
- $P=[\begin{matrix}H&m\end{matrix}]=[\begin{matrix}KR&Kc\end{matrix}]$
- $MR^{r}:KR(KR)^{r}\cdot KK^{r}=w^{-r}$
- Therefore from $P \cdot K$ Cholesky factorization of $w^{-1}$

## Calibration through the Matrix

- We can collect the constraints of w from
- $t=geL_{i},mt_{i},t_{i},t_{i},t_{i},t_{i},t_{i},t_{i},t_{i},t_{i},t_{i},t_{i},t_{i},t_{i}))}{\sqrt{(v_{i}^{T},w_{i})(v_{i}^{T},w_{i})}}…v_{i}:thRL_{i}$
- Known planar shapes observing their images
- $=K[\begin{matrix}r_{art}&r_{ar}&0\end{matrix}]$
- For each homography H we have homogeneous equations in 6 knowns forming 3 homographies

## Calibration from a Plane and Camera Center

- Estimate of the homography H from known points of plane $\pi$ and their images.
- Find $H_0$ matrix relating points $\pi_0$ and the direction d of the ray passing from O.
- $J_{yy}=(\begin{matrix}x&x_{y}\\ y&y_{z}\\ -z_{z}\end{matrix})=[\begin{matrix}x&0&-x_{z}\\ 0&1&y_{z}\\ +&0&z_{z}\end{matrix}][\begin{matrix}x\\ y\\ z\end{matrix}]=H_{yy}^{-1}(\begin{matrix}x\\ y\\ z\end{matrix}],H_{y}=[\begin{matrix}x&x_{y}\\ 0&x&y_{z}\\ 0&0&z_{z}\end{matrix}]$
- Find $H_r$ matrix relating each image of points with the directions d of the ray of origin.
- $d+R_{0}^{-1}\equiv H_{0}^{-1}K_{-1}=H^{-1}=H_{0}^{-1}H^{-1}$
- Use a QR decomposition on the matrix $H^{-r}$.
- $MRK^{-1}$ K: Calibration Matrix, $R_{i}^{-*}$ World rotation matrix.

## Rectification

- Variables remaining unknown:
- $w=(KK^{*})^{-1}=[\begin{matrix}a^{2}&0&\alpha_{1}a^{2}\\ +&1&-k_{1}\\ +&f_{1}&-k_{2}\\ +&f_{1}^{2}+y_{2}^{2}+y_{2}^{2}\end{matrix}],\alpha+\frac{f_{2}}{k}$
- $(h_{t}^{T}wh_{t}r_{t}$
- $h_{x}^{r}h_{xz0}$
- Solving for w finding Cholesky factorization to obtain K.
- At this point:
	- The homography of the image is the rectified image.
	- The image of the horizon line.
	- The vanishing point v.
- Starting from the homography of a Planar $K=[h_{1},h_{2},h_{1}]$ inverse to a rectified homography.
- $K_{A}\vert{}_{K\cdot H_{A}}$
- $h_{t}^{T}\omega h_{t}=h_{z}^{T}\omega h_{z}=0$
- From which I solve for w and find it with Cholesky factorization: $w^{\cdot\cdot}=Kk^{T}$

## Localization of a Planar (2D) Set of Points

- Given an image of known Dimensional points (Perspective n Points).
- Find position and rotation of the camera (R, C) from P and $X_i$.
- $PK_{i}=[\overline{KR}K_{i}]X_{i}\cdot K[\overline{R}_{t}]X_{i}=m_{i}$
- For a calibrated camera of known K:
- $[R^{C}]K_{i}=K_{i}^{-1},…,n+1,…,n$
- R has 3 dof considering that the orthogonality constraints of R are included.
- Each (of the dof) represents 2 equations.
- Can be found in libraries like OpenCV.

## DLT

- $p_{K_{i}-\omega_{i}}$
- Each gives 2 equations in 2D.

## Symmetry

- In a known space one has information.
- If we place a point in space, this enjoys: Spherical Symmetry.
- Locus for spheres.
- Placing a second point in space, moving one, both move. This is called Aerial Symmetry.
- Adding a third point I have Planar symmetries.
- Two points of symmetry meet in 3D.

---
Related: [[_Image Analysis MOC]]
Source: