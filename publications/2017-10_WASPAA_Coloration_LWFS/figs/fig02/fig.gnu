#!/usr/bin/gnuplot

#*****************************************************************************
# Copyright (c) 2017      Fiete Winter                                       *
#                         Institut fuer Nachrichtentechnik                   *
#                         Universitaet Rostock                               *
#                         Richard-Wagner-Strasse 31, 18119 Rostock, Germany  *
#                                                                            *
# This file is part of the supplementary material for Fiete Winter's         *
# scientific work and publications                                           *
#                                                                            *
# You can redistribute the material and/or modify it  under the terms of the *
# GNU  General  Public  License as published by the Free Software Foundation *
# , either version 3 of the License,  or (at your option) any later version. *
#                                                                            *
# This Material is distributed in the hope that it will be useful, but       *
# WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY *
# or FITNESS FOR A PARTICULAR PURPOSE.                                       *
# See the GNU General Public License for more details.                       *
#                                                                            *
# You should  have received a copy of the GNU General Public License along   *
# with this program. If not, see <http://www.gnu.org/licenses/>.             *
#                                                                            *
# http://github.com/fietew/publications           fiete.winter@uni-rostock.de*
#*****************************************************************************

reset
set macros
set loadpath '../../../../tools/gnuplot/'

load 'xyborder.cfg'

################################################################################
set t epslatex size 16.8cm,6.0cm color colortext header '\newcommand\ft\footnotesize\newcommand\st\scriptsize'
set output 'tmp.tex';

unset key # deactivate legend

# color palette
load 'qualitative/Paired.plt'
# positioning
load 'positions.cfg'
SPACING_HORIZONTAL = 1.0
SPACING_VERTICAL = 4.0
OUTER_RATIO_L = 1.0
OUTER_RATIO_R = 0.0
OUTER_RATIO_B = 0.5
# variables
Nspec = 8
offset = 40  # shift in dB
# x-axis
set xrange [0.1:20]
set logscale x 10
set xtics offset 0,0.5
set xlabel offset 0,1.5
LABEL_X = '\ft $f / \mathrm{kHz}$'
# y-axis
set yrange [-20:(Nspec-1)*offset+20]
set ytics 40 offset 0.5,0
set mytics 2
set ylabel  offset 4,0
LABEL_Y = '\ft normalised Magnitude / dB'
# grid
load 'grid.cfg'
set grid xtics ytics mxtics mytics
# labels
load 'labels.cfg'
set label 1 @label_northwest tc ls 2
set label 2 @label_northeast tc ls 6
set label 3 at graph 0.0, 1.12 left front tc ls 2
set label 4 at graph 1.0, 1.12 right front tc ls 6
do for [ii=1:Nspec] {
  set label 10+ii at 0.15, (ii-0.70)*offset left front
}

################################################################################

set multiplot layout 1,2

################################################################################
#### plot 1 #####
# labels
set label 1  '\ft $\sfpos = [-0.085,0,0]^\mathrm{T}$~m'
set label 2  '\ft $\sfpos = [-0.585,0.75,0]^\mathrm{T}$~m'
set label 3  '\ft $\sfposc = [0,0,0]^\mathrm{T}$~m'
set label 4  '\ft $\sfposc = [-0.5,0.75,0]^\mathrm{T}$~m'
set label 11 '\ft WFS'
set label 12 '\ft NFC-HOA'
set label 13 '\ft Stereo'
do for [ii=1:5] {
  set label 13+ii sprintf('\ft LWFS %d 27', 2**(11-ii))
}
# positioning
@pos_bottom_left
# plotting
plot for[ii=1:Nspec] 'data.txt' u ($1/1000):(column(ii+1+Nspec)+(ii-1)*offset) w l ls 5 lw 4,\
     for[ii=1:Nspec] 'data.txt' u ($1/1000):(column(ii+1)+(ii-1)*offset) w l ls 2 lw 2,\

#### plot 2 #####
# labels
unset label 1
set label 2 tc rgb 'black'
unset label 3
set label 4 tc rgb 'black'
set label 11 '\ft WFS'
do for [ii=1:7] {
  set label 11+ii sprintf('\ft LWFS 1024 %d', 27-(ii-1)*4)
}
# positioning
@pos_bottom_right
# plotting
plot 'data.txt' u ($1/1000):10 w l lc rgb 'black' lw 2,\
     'data.txt' u ($1/1000):($13+offset) w l lc rgb 'black' lw 2,\
     for[ii=1:6] 'data.txt' u ($1/1000):(column(ii+17)+(ii+1)*offset) w l lc rgb 'black' lw 2,\

################################################################################
unset multiplot

set output # Closes the temporary output files.
!sed 's|includegraphics{tmp}|includegraphics{fig}|' < tmp.tex > fig.tex
!epstopdf tmp.eps --outfile='fig.pdf'