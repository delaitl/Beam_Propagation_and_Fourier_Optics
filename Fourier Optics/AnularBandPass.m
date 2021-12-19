function GBPF = AnularBandPass(Dim, Rc, r)
% Generation of an anular aperture by substraction of two circular
% apertures
%
% Dim: Dimension od the square matrix
% Rc:  Central radius of the anular aperture
% r:   semi witdth of the paerture

GBPF = CircularAperture(Dim, Rc+r) - CircularAperture(Dim, Rc-r);
