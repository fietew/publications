% reproduced sound field for 2.5D WFS of monochromatic point source +
% ground truth, local wavenumber vector and stationary phase approx. (SPA)

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

clear variables;

addpath('../../matlab');
SFS_start;  % start Sound Field Synthesis Toolbox

parameters;

conf.idSPA = 130;

%% Parameters which should be iterated

param_names = {
  'src', ...
  'xs', ...
  'secondary_sources.geometry', ...
  'secondary_sources.number',...
  'secondary_sources.size', ...
  'f', ...
  'eta' ...
  'method', ...
};

%% Parameter Values

param_values = allcombs( ...
  { 'ps' }, ...
  { [0,1,0] }, ...
  { 'linear' }, ...
  { 257 }, ...
  { 64 }, ...
  { 1000 }, ...
  { 0 }, ...
  { 'wfs' } ...
);

%% Evaluation

% ray approximation of aliasing
exhaustive_evaluation(@spatial_aliasing_rays, param_names, param_values, conf, true);

exhaustive_evaluation(@spatial_aliasing_components, param_names, param_values, conf, true);

exhaustive_evaluation(@monochromatic_sound_field, param_names, param_values, conf, true);
