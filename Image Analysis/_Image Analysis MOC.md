---
subject: Image Analysis
description: Map of contents for the Image Analysis subject — the camera as an optical system, projective geometry of the plane and of space, and single-view camera geometry with calibration and rectification
---

# Image Analysis

> [!summary] Overview
> The course builds a single pipeline: light forms an image through a **lens**, that image is described by **projective geometry**, and the projection is inverted through **calibration**. It starts from the physical camera and the pinhole approximation, develops the 2D and then 3D projective formalism, and arrives at the projection matrix $P = K[R\,|\,\mathbf{t}]$ and its estimation. Read in that order, each note reuses the notation of the previous one: coordinates in the plane, then in space, then in the image.

## 1. Reading Path

1. [[Optical Systems]] — the camera as an optical system: thin spherical lens, Snell's and Fresnel's laws, focalization, pinhole model, geometric distortions of central projection.
2. [[Planar Geometry]] — homogeneous coordinates, lines and duality, vanishing points and line, cross ratio, conics, homographies and the 2D transformation hierarchy.
3. [[Space Geometry]] — the 3D analogue: points and planes, self-dual lines, quadrics, the absolute conic, projectivities and the Euclidean → similarity → affine → projective hierarchy.
4. [[Camera Geometry]] — $P = K[R\,|\,\mathbf{t}]$, vanishing point theorem, intrinsic versus extrinsic parameters, homography of a plane, calibration, rectification, PnP and DLT.

## 2. Core Ideas

- A camera is a **central projection** from $\mathbb{P}^3$ to $\mathbb{P}^2$: linear in homogeneous coordinates, not invertible — only the visual ray of a pixel is recoverable.
- Moving down the hierarchy (Euclidean → similarity → affine → projective) loses invariants; fixing $\boldsymbol{\pi}_\infty$ characterises affinities, fixing $\Omega_\infty$ characterises similarities.
- **Calibration** recovers $K$ from $\omega = (KK^T)^{-1}$ by Cholesky factorization; a plane and its image are related by a homography.
- Geometry alone cannot produce 3D structure: it needs **correspondences** and additional assumptions on the scene — that is where the course continues.

## 3. Gaps and next Steps

- The notes stop at the **single view**: epipolar geometry, triangulation, stereo and bundle adjustment are not in the vault yet.
- [[Camera Geometry]] closes with symmetry and polarity (Appendices C–D), both summarised: a worked example of each would make them usable in the homework.
- The physical acquisition chain is covered separately in [[_Sensor System MOC]] — photodiodes, CCD/CMOS arrays, noise and dynamic range.
