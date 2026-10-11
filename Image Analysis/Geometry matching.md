---
date: 11-10-2026
subject: Image Analysis
---

## Geometric Matching
- Given 2 images, I want to be able to find the matching regardless of their alignment.
- I also want to be able to reconstruct the 3-dimensionality of an object bringing it from 2 images.
- Other applications: SLAM, Image stitching, Image retrieval.

## Point-to-Point Matching
- Key Point: easily distinguishable points of interest in an image.
- Methods for finding Keypoints:
  - $F_{6025*}$ Keypoint.
  - semi-automatic manner.
- Define an area around the Keypoint: the larger the area taken into consideration, the greater the importance of the Keypoint.
- Extract and normalize the content of the regions.
- Compute local descriptors for the regions.
- Match local descriptor.
- Robust model fitting.

## Key Point Detection
- To automatically identify Key points, I evaluate a measure of how much a point is of interest.
- SSD (sum of squared distances).
- $E_{x,y}(r,u)=\sum (w,w,v,v,v,v,v)J^{2}$
- $C_{(n,w)}=C_{(n,y)}C_{(n,w)}$
- $E_{x,y}(x,x)=E_{w}w_{x,y}(w,y)(-l_{x}(w,x)+yl_{y}(w,y)=o(-;y^{z}))^{2}$
- $E_{x,y}(x,c)=[x,y],K_{x,y}[x]$
- Using the Harris corner Localizator to define the areas of interest.
- To define the Key point evaluate the local maxima.
- $y:=d_{1}L_{2}L_{2}L_{6}(y,K)$

## Construction
- I take the image and imagine creating a pyramid of these each time blurring it and shrinking it every so often.
- Then apply a difference between the images and perform a convolution.
- $D(x,y,\sigma)=L(x,y,K\sigma)\cdot L(x,y,\sigma)$
- $D(x,y,\sigma)=((G_{10}-G_{r})\Theta I)(x,y)$
- Then localize the Keypoints.
- Use a Harris Radius to locate them.
- $\Delta_{xi}$ Keypoints found I can draw arrows:
  - large differences.
  - Length: high up in the pyramid of Keypoints.
  - Direction: Direction of the gradient from this I make histograms.
- Radius of curvature of the image.
- Used as an input for the Gaussian method.
- Makes the process faster.

---
Related: [[_Image Analysis MOC]]
Source: