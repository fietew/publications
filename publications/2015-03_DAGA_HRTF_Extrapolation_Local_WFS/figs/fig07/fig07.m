% sound fields for WFS at different frequencies

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

clear all
SFS_start;

%% Parameters
conf = SFS_config_example;
% plotting settings
conf.plot.useplot = true;
conf.plot.usegnuplot = false;
conf.plot.loudspeakers = true;
conf.plot.realloudspeakers = false;

conf.showprogress = true;
conf.resolution = 500;
conf.usetapwin = true;

%% === Circular secondary sources ===
% config for real loudspeaker array
conf.dimension = '2.5D';
conf.tapwinlen = 1.0;
conf.secondary_sources.geometry = 'circular';
conf.secondary_sources.number = 56;
conf.secondary_sources.size = 2;
conf.secondary_sources.center = [0, 0, 0];
conf.driving_functions = 'default';
conf.xref = conf.secondary_sources.center;

X = [0 0 0];
xs = [0, 1.5, 0];
src = 'ps';
xrange = [-1.05, 1.05];
yrange = [-1.05, 1.05];
zrange = 0;
pos = [0, 0, 0];

%% ===== WFS =============================================================
%
f = 1000;
[P,x,y] = sound_field_mono_wfs(xrange, yrange, zrange,xs,src,f,conf);
gp_save_matrix('sound_field_wfs_f1000.dat',x,y,real(P));
%
f = 3000;
[P,x,y] = sound_field_mono_wfs(xrange, yrange, zrange,xs,src,f,conf);
gp_save_matrix('sound_field_wfs_f3000.dat',x,y,real(P));
%
f = 5000;
[P,x,y] = sound_field_mono_wfs(xrange, yrange, zrange,xs,src,f,conf);
gp_save_matrix('sound_field_wfs_f5000.dat',x,y,real(P));
%
x0 = secondary_source_positions(conf);
gp_save_loudspeakers('array.txt',x0);
