---
date: 11-10-2026
subject: Image Analysis
---

## Non Linear Filters
- Linear filters are not always optimal.
- Non linear filters follow a function $g()$.

## Median Filter
- Takes the values of the pixels in the filter and assigns to the central one the most common value in the filter.
- Used to cancel some types of noise (e.g. Salt and pepper).

## Erosion and Dilation
- Filters applied on binary images (typically 2) to perform an AND operation.
- Takes always the minimum value.
- Inverse of the Erosion, goes to compensate the lost areas.
- Combo of Erosion then Dilation, Cuts isolated artifacts.
- Combo Dilation then Erosion, Cuts isolated black artifacts.

## Connected Components
- I can find the individual elements in an image looking at the interconnection of the pixels.
- 4 pixel and 8 pixel types.
- If the central pixel is connected to adjacent ones.

---
Related: [[_Image Analysis MOC]]
Source: