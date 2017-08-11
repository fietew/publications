#!/usr/bin/gnuplot

#*****************************************************************************
# Copyright (c) 2015      Fiete Winter                                       *
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
load 'sequential/Blues.plt'
load 'array.cfg'
load 'labels.cfg'
load 'colorbar.cfg'

################################################################################
set t epslatex size 11cm,4cm color colortext
set output 'tmp.tex';

unset key

# labels
set label 1 @label_northeast
set label 2 @label_northwest

# axes
set size ratio -1

set xrange [-1.55:1.55]
set yrange [-0.05:3.05]
set cbrange [-20:0]

set xtics 1 offset 0,0.5
set ytics 1 offset 0.5,0
set cbtics 5
set tics scale 0.75 out nomirror

set xlabel '$x$ / m' offset 0,1
set ylabel '$y$ / m' offset 3,0
set format '\footnotesize $%g$'
unset colorbox

# margins
set bmargin 0
set tmargin 0

################################################################################
set multiplot layout 1,2

# plot 1
set lmargin 3
set rmargin 0
set label 1 '\footnotesize $L_l = 2\mathrm{m}, L_0 = 10\mathrm{m}$'
set label 2 '\footnotesize LWFS'
plot 'sound_field_lwfs_L10.dat' binary matrix with image,\
     'array_L10.txt' @array_continuous, \
     'virtual_array.txt' @array_virtual

# plot 2
set format y '' # remove labels of tics
unset ylabel # remove label of y-axis
set lmargin 0
set rmargin 3
set colorbox @colorbar_east
set label 1 '\footnotesize $L_0 = 1\mathrm{m}$'
set label 2 '\footnotesize WFS'
plot 'sound_field_wfs_L1.dat' binary matrix with image,\
     'array_L1.txt' @array_continuous

unset multiplot

################################################################################
set output # Closes the temporary output files.
!sed 's|includegraphics{tmp}|includegraphics{fig}|' < tmp.tex > fig.tex
!epstopdf tmp.eps --outfile='fig.pdf'
