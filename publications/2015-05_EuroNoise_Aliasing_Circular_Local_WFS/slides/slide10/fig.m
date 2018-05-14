% circular harmonics spectrum of a reproduced sound field using a continous
% and a sampled WFS driving function for a virtual plane wave

%*****************************************************************************
% Copyright (c) 2013-2018 Fiete Winter                                       *
%                         Institut fuer Nachrichtentechnik                   *
%                         Universitaet Rostock                               *
%                         Richard-Wagner-Strasse 31, 18119 Rostock, Germany  *
%                                                                            *
% This file is part of the supplementary material for Fiete Winter's         *
% scientific work and publications                                           *
%                                                                            *
% You can redistribute the material and/or modify it  under the terms of the *
% GNU  General  Public  License as published by the Free Software Foundation *
% , either version 3 of the License,  or (at your option) any later version. *
%                                                                            *
% This Material is distributed in the hope that it will be useful, but       *
% WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY *
% or FITNESS FOR A PARTICULAR PURPOSE.                                       *
% See the GNU General Public License for more details.                       *
%                                                                            *
% You should  have received a copy of the GNU General Public License along   *
% with this program. If not, see <http://www.gnu.org/licenses/>.             *
%                                                                            *
% http://github.com/fietew/publications           fiete.winter@uni-rostock.de*
%*****************************************************************************

clear all;
addpath('../../matlab');
SFS_start;

%% Parameters

r = 1.0;  % radius of evaluation
R0 = 1.5;  % radius of loudspeaker array
N0 = 40;  % number of loudspeakers

numax = 200;  %  maximum order
nuvec = linspace(-numax,numax, 2*numax+1);  % index for angular fourier transform
fvec = linspace(1, 3000, 500);  %  temporal frequency vector

[nu, f] = meshgrid(nuvec, fvec);  % grid

c = 343;  % velocity of sound
k = 2*pi*f/c;

alphapw = deg2rad(90);  % angle of ARRIVAL of virtual plane wave

%% Computation

% series of secondary source selection criterion for virtual plane wave
a0 = 1./(2*pi).*winF_rect(nuvec, pi).*exp(-1j*nuvec*alphapw);

% derivative of cylindrical bessel function
Jprime = 1./2 .* ( besselj(nu-1, k.*R0) - besselj(nu+1, k.*R0) );
% spectrum of driving function for virtual plane wave without secondary
% source selection criterion
S0 = -2 .* k .* Jprime .* 1j.^(-nu) .* exp(-1j.*nu.*alphapw);
% spectrum of continous driving function for virtual plane wave
D0 = 2*conv2(S0, a0, 'same');
% spectrum of sampled driving function for virtual plane wave
D0sampled = zeros(size(nu));
for idx=-3:3

  selector = (1+max(0, idx*N0)):(2*numax+1 + min(0, idx*N0));

  D0sampled(:, selector) =  ...
    D0sampled(:, selector) + D0(:,selector - idx*N0);
end
% spectrum of 2D greens function
G0 = -1j./4 .* besselj(nu, k.*r) .* besselh(nu, 2, k.*R0);
% reconstructed sound field using continous sound field
P = 2*pi*R0*G0.*D0;
% reconstructed sound field using continous sound field
Psampled = 2*pi*R0*G0.*D0sampled;

% gnuplot
gp_save_matrix('spectrum_P.dat', ...
  nuvec,fvec,20*log(abs(P)./max(abs(P(:)))));
gp_save_matrix('spectrum_Psampled.dat', ...
  nuvec,fvec,20*log(abs(Psampled)./max(abs(Psampled(:)))));
