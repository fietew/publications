#!/usr/bin/gnuplot

#*****************************************************************************
# Copyright (c) 2013-2019 Fiete Winter                                       *
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

load 'border.cfg'
load 'array.cfg'
load 'standalone.cfg'

set style line 11 lc rgb 'black' lt 2 lw 4 ps 0.75

################################################################################
set terminal epslatex size @intbeamerwidth,4.0cm color colortext standalone header intbeamer.footnotesize
set output 'fig.tex'

# legend
unset key
# labels
load 'labels.cfg'
set label 1 @label_northwest
set label 2 @label_northeast
# positioning
load 'positions.cfg'
# axes
set size ratio -1
set format '$%g$'
set tics scale 0.75 out nomirror
# x-axis
set xrange [-1.55:1.55]
set xtics 1 offset 0,0.5
set xlabel offset 0,1.25
LABEL_X = '$x$ / m'
# y-axis
set yrange [-1.55:1.55]
set ytics 1 offset 0.5,0
set ylabel offset 1.75,0
LABEL_Y = '$y$ / m'
# colorbar
load 'colorbar.cfg'
unset colorbox
# variables
sx = 0.30
sy = 0.7
oriy1 = 0.2
orix1 = 0*sx + 0.08
orix2 = 1*sx + 0.09
orix3 = 2*sx + 0.10

################################################################################
set multiplot

#### plot 1 #####
# palette
set palette negative
set palette maxcolor 0
load 'diverging/RdBu.plt'  # see gnuplot-colorbrewer
# c-axis
set cbrange [-1:1]
# labels
set label 1 'WFS'
# positioning
set size sx, sy
set origin orix1, oriy1
@pos_bottom_left
# plotting
plot 'Pwfs.dat' binary matrix with image, \
  'array.txt' @array_active, \

#### plot 2 #####
# positioning
set size sx, sy
set origin orix2, oriy1
@pos_bottom
# labels
set label 1 'NFC-HOA'
set label 2 '$M=10$'
# plotting
plot 'Phoa_1.dat' binary matrix with image, \
  'array.txt' @array_active, \

#### plot 3 #####
# labels
set label 1 'NFC-HOA'
set label 2 '$M=20$'
# positioning
set size sx, sy
set origin orix3, oriy1
@pos_bottom
# plotting
plot 'Phoa_2.dat' binary matrix with image, \
  'array.txt' @array_active, \

###############################################################################
unset multiplot

call 'pdflatex.gnu' 'fig'
