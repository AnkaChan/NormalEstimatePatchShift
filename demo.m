addpath ('../toolbox/jjcao_io')
addpath ('../toolbox/jjcao_point')
filePath = '..\dataBenchMark\octahedron_26K_noise04_ourfast1.off';
[P.pts, trueNormals] = read_noff(filePath);
normalEstimatePatchShift(P.pts); 