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

clear variables;

addpath('../../matlab');
SFS_start;  % start Sound Field Synthesis Toolbox

parameters;
conf.X = [-2,2];
conf.Y = [-4,0];

%% Parameters which should be iterated

param_names = {
  'src', ...
  'xs', ...
  'secondary_sources.geometry', ...
  'secondary_sources.number', ...
  'secondary_sources.logspread',...
  'secondary_sources.size',...
  'rc',...
  'rl',...
  'f',...
  'method',...
};

%% Compute Spatial Aliasing Frequency

param_values = {};

param_values = [param_values; allcombs( ...
  { 'ps' }, ...
  { [0,1,0] }, ...
  { 'linear' }, ...
  { 18, 35 }, ...
  { 1.0 }, ...
  { 4.0 }, ...
  { Inf },...
  { 0.1 },...
  { NaN },...
  { NaN } ...
)];

param_values

exhaustive_evaluation(@spatial_aliasing_frequency, param_names, param_values, conf, true);

%% Plot Sound Fields

param_values = {};

param_values = [param_values; allcombs( ...
  { 'ps' }, ...
  { [0,1,0] }, ...
  { 'linear' }, ...
  { 18, 35 }, ...
  { 1.0 }, ...
  { 4.0 }, ...
  { Inf },...
  { 0.1 },...
  { 700, 800, 900, 1000, 1400, 1600, 1800, 2000 },...
  { 'wfs' } ...
)];

param_values

exhaustive_evaluation(@monochromatic_sound_field, param_names, param_values, conf, true);