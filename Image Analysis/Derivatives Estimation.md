---
date: 11-10-2026
subject: Image Analysis
---

# Derivatives Estimation

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