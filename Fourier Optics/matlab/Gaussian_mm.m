function G = Gaussian_mm(w0, R2)
% Generates a Gaussian function
% x: X and Y coordinates en mm
% w0: gaussian width
% 
% use
%   G = Gaussian_mm(x, w0)
%
% Juan Campos
% Universitat Autonoma de Barcelona
% http://grupsderecerca.uab.cat/mipoptilab/



G = exp(-R2/ (w0*w0));