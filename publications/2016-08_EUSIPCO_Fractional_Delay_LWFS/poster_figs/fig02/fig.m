% sound fields for comparison between WFS and local WFS

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
conf.resolution = 300;

%% === Circular secondary sources ===
conf.dimension = '2D';
conf.secondary_sources.geometry = 'circular';
conf.secondary_sources.number = 56;
conf.secondary_sources.size = 3;
conf.secondary_sources.center = [0, 0, 0];
conf.secondary_sources.x0 = [];
% tapering window
conf.usetapwin = true;
conf.tapwinlen = 0.3;

conf.driving_functions = 'default';
conf.xref = conf.secondary_sources.center;

X = [0 0 0];
xs = [0, -1.0, 0];
src = 'pw';
xrange = [-1.55, 1.55];
yrange = [-1.55, 1.55];
zrange = 0;
f = 2000;
pos = [0, 0, 0];

%% === Circular virtual secondary sources ===
conf.localsfs.method = 'wfs';
conf.localsfs.usetapwin = false;
conf.localsfs.vss.center = [0, 0, 0];
conf.localsfs.vss.geometry = 'circular';
conf.localsfs.vss.use_adaptive_placement = false;
conf.localsfs.vss.consider_target_field = true;
conf.localsfs.vss.consider_secondary_sources = false;
conf.localsfs.vss.number = 56;
conf.localsfs.vss.size = 1.5;

%%
virtualconf = conf;
virtualconf.usetapwin = conf.localsfs.usetapwin;
virtualconf.tapwinlen = conf.localsfs.tapwinlen;
virtualconf.secondary_sources.size = conf.localsfs.vss.size;
virtualconf.secondary_sources.center = conf.localsfs.vss.center;
virtualconf.secondary_sources.number = conf.localsfs.vss.number;

%% ===== WFS =============================================================

% 1st subplot
[P,x,y] = sound_field_mono_wfs(xrange, yrange, zrange,[0,0.6,0,0,-1,0],'fs',f,conf);
gp_save_matrix('sound_field_wfs_fs.dat',x,y,real(P));
% 2nd subplot
[P,x,y] = sound_field_mono_localwfs(xrange, yrange, zrange,xs,src,f,conf);
gp_save_matrix('sound_field_lwfs_ls.dat',x,y,real(P));
% 3rd subplot
[P,x,y] = sound_field_mono_wfs(xrange, yrange, zrange,xs,src,f,conf);
gp_save_matrix('sound_field_wfs_ls.dat',x,y,real(P));
%
x0 = secondary_source_positions(conf);
gp_save_loudspeakers('array.txt',x0);
%
xv = secondary_source_positions(virtualconf);
gp_save_loudspeakers('virtual_array.txt',xv);
