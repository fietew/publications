function f = aliasing(x0, kSx0, x, conf)
%ALIASING aliasing frequency at position x
%
%   Usage: f = aliasing(x0, kSx0, x, conf)
%
%   Input options:
%       x0              - position, direction, and sampling distance of 
%                         secondary sources [N0x7] / m
%       kSx0            - normalised local wavenumber vector kS(x0) 
%                         of virtual sound field at x0 [N0x3]
%       x               - position for which aliasing frequency is calculated
%                         [Nx3]
%       conf            - configuration struct (see SFS_config)
%
%   Output parameters:
%       f   - aliasing frequency [Nx1]
%

%*****************************************************************************
% Copyright (c) 2013-2019 Fiete Winter                                       *
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

% the position x is a circular area with radius 0
minmax_kGt_fun = @(x0p,xp) minmax_kt_circle(x0p,xp,0);

% no restriction with respect to kSt(x0) (tangential component of kS(x0) )
minmax_kSt_fun = @(x0p) minmax_kt_circle(x0p,[0,0,0],Inf);

f = aliasing_extended_control(x0, kSx0, x, minmax_kGt_fun, minmax_kSt_fun, ...
  conf);
