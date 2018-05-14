function mono_soundfield( conf )
% Monochromatic Sound Field Plots

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

%% ===== Configuration ==================================================
xs = conf.xs;  % source position
src = conf.src;  % source type
pos = conf.pos;  % listener position
method = conf.method;  % SFS method
f = conf.f;  % frequency
c = conf.c;  % speed of sound

% switch off the stupid warnings for not using wavwrite and wavread anymore
warning('off', 'MATLAB:audiovideo:wavwrite:functionToBeRemoved');
warning('off', 'MATLAB:audiovideo:wavread:functionToBeRemoved');

%% ===== Computation ====================================================
X = [-1.6, 1.6];
Y = [-1.6, 1.6];
Z = 0;

switch method
  case {'ref', 'anchor'}
    % === Reference & Anchor ===    
    x0 = [xs 0 -1 0 1];
    D = 1;
    [P,x,y] = sound_field_mono(X,Y,Z,x0,src,D,f,conf);
    rM = NaN;
  case 'stereo'
    % === Stereo ===
    xsl = [-1.4434 2.5 0]; % left loudspeaker
    xsr = [1.4434 2.5 0];  % right loudspeaker
    
    x0 = [xsl 0 -1 0 1; xsr 0 -1 0 1];
    D = [1, 1];
    [P,x,y] = sound_field_mono(X,Y,Z,x0,src,D,f,conf);
    rM = NaN;
  case 'wfs'
    % === WFS ===
    [P,x,y,~,x0] = sound_field_mono_wfs(X,Y,Z,xs,src,f,conf);
    rM = NaN;
  case 'nfchoa'
    % === NFC-HOA ===
    [P,x,y,~,x0] = sound_field_mono_nfchoa(X,Y,Z,xs,src,f,conf);
    rM = conf.nfchoa.order/(2*pi*f)*c;
  case 'lwfs-sbl'
    % === Local WFS using Spatial Bandwidth Limitation ===
    conf.xref = pos;
    [P,x,y,~,x0] = sound_field_mono_localwfs_sbl(X,Y,Z,xs,src,f,conf);
    rM = conf.localwfs_sbl.order/(2*pi*f)*c;
end

% radius of high accuracy defined by modal order
phitmp = (0:360).';  
rM = [rM*cosd(phitmp)+pos(1), rM*sind(phitmp)+pos(2)];  

% normalise sound field
switch src
  case 'ps'
    P = P*4*pi*norm(xs - pos);
end

if conf.plot.useplot
  hold on;
  plot(rM(:,1), rM(:,2), 'g--');
  hold off;
  title(brs_nameprefix(conf), 'Interpreter', 'none');
end

%% ===== Save File =======================================================
gp_save_matrix([brs_nameprefix(conf) sprintf('_Pf%d.dat', f)], x, y, real(P));
gp_save_loudspeakers([brs_nameprefix(conf) '_ls.txt'], x0);
if strcmp(method, 'lwfs-sbl')
  gp_save([brs_nameprefix(conf) '_xc.txt'], pos(:,1:2));
  gp_save([brs_nameprefix(conf) sprintf('_rMf%d.txt', f)], rM);
end
