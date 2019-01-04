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

################################################################################
set t epslatex size 5cm,7.25cm color colortext header "\\newcommand{\\ft}[0]{\\footnotesize}"
set output 'tmp.tex'

# variables
gt_angles=''  # Gammatone Center Frequencies
stats 'gt_angles.txt' u 1:(gt_angles = gt_angles.sprintf('%4.0f ',$1)) nooutput
# colorbar
unset colorbox
# style
set style fill solid 0.5 border -1
set style line 1 lc rgb 'forest-green'
# border
load 'border.cfg'
# grid
load 'grid.cfg'
set grid mytics mxtics
# legend
unset key
# y-axis
set ytics offset 0.5,0
set mytics 2
set ylabel offset 5,0
# x-axis
set xlabel offset 0,1
set xtics offset 0,0.5
set mxtics 5
# margins
set lmargin 6
set rmargin 0
# labels
set label 1 at graph 1.0, 0.9 right front

################################################################################
set multiplot layout 2,1

#### plot 1 #####
# margins
set tmargin 1
set bmargin 2
# labels
set label 1 '\ft 2012'
# axes
set format '\ft %g'
# x-axis
set xlabel '\ft time per trial / s'
set xrange [0:30]
set xtics 10
# y-axis
set ylabel '\ft Relative Frequency'
set yrange [0:0.2]
set ytics 0.1
# plotting
plot '2012_time_hist.txt' u 1:2 with boxes ls 1

#### plot 2 #####
# margins
set tmargin 1
set bmargin 2
# axes
set format x '\ft %g'
# labels
set label 1 '\ft 2017'
# plotting
plot '2017_time_hist.txt' u 1:2 with boxes ls 1

################################################################################
unset multiplot

set output # Closes the temporary output files.
!sed 's|includegraphics{tmp}|includegraphics{fig}|' < tmp.tex > fig.tex
!epstopdf tmp.eps --outfile='fig.pdf'
