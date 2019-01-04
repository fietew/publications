% spectrum of reproduced sound field at the reference position

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
SOFAstart;  % start SOFA

parameters;

%% Parameters which should be iterated
xref = [0,0,0
  -0.5,0,0
  0,-0.5,0
  0,+0.5,0];
xeval = bsxfun(@plus, xref, [-0.000,0,0]);

% parameters which should be varied for the evaluation
param_names = {
  'src', ...
  'xs', ...
  'method', ...
  'xref', ...
  'xeval', ...
};

%% Parameter Values

param_values = {};

param_values = [param_values; allcombs( ...
  { 'ps', 'pw' }, ...
  { [0,2.5,0], [0 -1 0] }, ...
  { 'gt', 'wfs' }, ...
  { [0 0 0] }, ...
  num2cell(xeval,2), ...
  [1, 1, 3, 4, 5] ...
)];

param_values = [param_values; allcombs( ...
  { 'ps', 'pw' }, ...
  { [0,2.5,0], [0 -1 0] }, ...
  { 'lwfs-sbl' }, ...
  num2cell(xref,2), ...
  num2cell(xeval,2), ...
  [1, 1, 3, 4, 4] ...
)];

param_values

%% evaluation
% calculate impulse responses at xref
exhaustive_evaluation(@eval_sfs_imp, param_names, param_values, conf, true);
% calculate magnitude spectra
delete(conf.datafile);
exhaustive_evaluation(@eval_gnuplot_spectrum, param_names, param_values, conf, ...
  false);
