# Normal Estimation via Shifted Neighborhood for point cloud

Code for:
- Junjie Cao, He Chen, Jie Zhang*, Yujiao Li, Xiuping Liu, Changqing Zou. Normal Estimation via Shifted Neighborhood for point cloud. Journal of Computational and Applied Mathematics, 2018, 329, 57-67.

<img src = "https://github.com/AnkaChan/NormalEstimatePatchShift/blob/main/Pipeline.PNG" height="600px"></img> Pipeline<br />

For accurately estimating the normal of a point, the structure of its neighborhood has to be
analyzed. All the previous methods use some neighborhood centering at the point, which is
prone to be sampled from different surface patches when the point is near sharp features.
Then more inaccurate normals or higher computation cost may be unavoidable. To conquer
this problem, we present a fast and quality normal estimator based on neighborhood shift.
Instead of using the neighborhood centered at the point, we wish to locate a neighborhood
containing the point but clear of sharp features, which is usually not centering at the point.
Two specific neighborhood shift techniques are designed in view of the complex structure
of sharp features and the characteristic of raw point clouds. The experiments show that our
method out-performs previous normal estimators in either quality or running time, even
in the presence of noise and anisotropic sampling.
