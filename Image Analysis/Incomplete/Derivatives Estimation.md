---
date: 11-10-2026
subject: Image Analysis
description: Edge detection by derivative estimation — horizontal and vertical derivatives computed as convolutions on the intensity function, image gradient, edge orientation and magnitude, followed by dilation and erosion
---

# Derivatives Estimation

> [!summary] Overview
> This note introduces **derivative estimation** as a way to find the contours of objects and turn a grayscale image into a binary edge map. Derivatives are computed as **convolutions** on the image intensity treated as a multi-variable function: the horizontal and vertical derivatives isolate horizontal and vertical edges, and the **gradient** gives both edge strength (its magnitude) and edge orientation (its inclination). The magnitude is then post-processed with **dilation** and **erosion**. It is a first step toward the shape analysis pursued in [[Optical Systems|central projection]] and [[Geometry matching|feature detection]].

## Derivative Estimation

- Techniques to find contours of the analyzed objects.
- Given a grayscale image I want as output Binary images containing the edges.
- To do this, use Derivatives, computed via convolutions.
- Considering the grayscale image as a multi-variable function I can derive on the intensity of the pixels in the image function.
- Horizontal derivative: $hes@das$.
- Vertical derivative: $his@dy$.
- Establishes horizontal and vertical edges.
- I can at this point calculate the Gradient of the image (The greater the gradient, the greater the verticality of the edge).
- The direction is given by the inclination of the Gradient.
- On the Magnitude I compute a Dilation and an Erosion.


---
Related: [[_Image Analysis MOC]]
Source: