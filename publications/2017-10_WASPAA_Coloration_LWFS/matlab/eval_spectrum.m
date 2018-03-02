function eval_spectrum( conf )
% reads file generated by brs_driving_signals.m and appends the spectrum 
% of the reproduced sound field at conf.pos to it.

%*****************************************************************************
% Copyright (c) 2018      Fiete Winter                                       *
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

%% ===== Configuration ==================================================
pos = conf.pos;  % listener position
pos_shift = conf.pos_shift;  % shift for evaluation
method = conf.method;  % SFS method
src = conf.src;
xs = conf.xs;

conf.plot.useplot = conf.useplot;
conf.ir.usehcomp = false;  % no headphone compensation
conf.ir.useinterpolation = false;

% switch off the stupid warnings for not using wavwrite and wavread anymore
warning('off', 'MATLAB:audiovideo:wavwrite:functionToBeRemoved');
warning('off', 'MATLAB:audiovideo:wavread:functionToBeRemoved');

%% ===== Computation ====================================================
load( [brs_nameprefix(conf), '.mat'], 'res');

phi = res.phi;
pos = pos + pos_shift;

p = ir_generic(pos, 0, res.x0, res.d, dummy_irs(2^11, conf), conf);
if strcmp( method, 'anchor' )
  p = brs_anchor(p, conf.fs);
end

switch src
  case 'pw'
    g = 1;
  case 'ps'
    r = norm(xs - pos);
    g = 1/(4*pi*r);
end

% normalised spectrum
[Pamp, Pphase, f] = spectrum_from_signal(p(:,1)/g*size(p,1)/2, conf);
if conf.plot.useplot
  subplot(2,1,1);
  title(brs_nameprefix(conf), 'Interpreter', 'None');
end

res.f = f;
res.p = p(:,1);
res.P = Pamp.*exp(1j*Pphase);

save([res.name, '.mat'], 'res');

