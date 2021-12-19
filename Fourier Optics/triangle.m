function[out]=triangle(x)
%
% triangle function
%
% evaluates tri(x)
%
% USE
% [out]=triangle(x)

% create lines
t = 1-abs(x);

% keep lines for |x|<=1, out=0 otherwise
mask = abs(x)<=1;
out  = t.*mask;
end