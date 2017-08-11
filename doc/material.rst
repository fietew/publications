.. ****************************************************************************
 * Copyright (c) 2015-2017 Fiete Winter                                       *
 *                         Institut fuer Nachrichtentechnik                   *
 *                         Universitaet Rostock                               *
 *                         Richard-Wagner-Strasse 31, 18119 Rostock, Germany  *
 *                                                                            *
 * This file is part of the supplementary material for Fiete Winter's         *
 * scientific work and publications                                           *
 *                                                                            *
 * You can redistribute the material and/or modify it  under the terms of the *
 * GNU  General  Public  License as published by the Free Software Foundation *
 * , either version 3 of the License,  or (at your option) any later version. *
 *                                                                            *
 * This Material is distributed in the hope that it will be useful, but       *
 * WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY *
 * or FITNESS FOR A PARTICULAR PURPOSE.                                       *
 * See the GNU General Public License for more details.                       *
 *                                                                            *
 * You should  have received a copy of the GNU General Public License along   *
 * with this program. If not, see <http://www.gnu.org/licenses/>.             *
 *                                                                            *
 * http://github.com/fietew/publications           fiete.winter@uni-rostock.de*
 ******************************************************************************

Additional Material
===================

The material for specific publications is stored in the ``papers`` directory of 
the `github repository <https://github.com/fietew/publications/>`_. 
The figures of each paper can be found in the respective sub-directory ``figs``.
For some publications, there is also a ``slides`` or a ``poster_figs`` directory
containing the scripts for some figures on the presentations slides or the
poster, respectively. The figures are enumerated either based on their numbering
in the paper, on the slide they appear on, or in order of appearance for the
poster. In order to reproduced a figure, execute the scripts in
the following order (if existent):

1. MATLAB script: \*.m
2. gnuplot script: \*.gnu
3. include \*.tex, \*.png, \*.pdf in your LaTeX document

For the third step, I recommend the ``import`` command from the 
`LaTeX import package <https://www.ctan.org/pkg/import>`_.

Requirements & Prerequities
---------------------------

Gnuplot
~~~~~~~

Special thanks go to Hagen Wierstorf for introducing me to Gnuplot. His
`Gnuplotting Blog <http://www.gnuplotting.org/>`_ contains a lot of examples
and information about Gnuplot. You the following Gnuplot extensions

* `ColorBrewer color schemes for gnuplot <https://github.com/aschn/gnuplot-colorbrewer>`_

In order to use the extensions their directories have to be included into 
Gnuplot's search path. This is done via the ``GNUPLOT_LIB``environment variable. 
Under Linux (and possibly Mac) execute

.. code-block:: shell

    # gnuplot search path
    export GNUPLOT_LIB=~/projects/gnuplot-colorbrewer:$GNUPLOT_LIB

in a shell of your choice. You may also add this to your ``~/.bashrc`` or 
something
(depends on the shell your are using) to execute this automatically. For 
Windows, see `here <https://www.computerhope.com/issues/ch000549.htm>`_. You 
can check, if the path is correcty included via ``show loadpath`` in the 
Gnuplot command prompt. Among other lines, this should display something like

.. code-block:: shell

    loadpath from GNUPLOT_LIB is "/home/bewater/projects/gnuplot-colorbrewer"


LaTeX
~~~~~

I am using pdfLaTeX, but it might be possible to get the scipts running with
other LaTeX compilers (I don't know at all).

MATLAB
~~~~~~

The code of this repository has been tested under MATLABR2015a. Please add
the ``./tools/matlab`` directory to your MATLAB path. The software uses the
following toolboxes, which you should download and add the their path to your
MATLAB path. For specific installation instructions please take a look at the
listed websites.

* `Auditory Modelling Toolbox (AMT) <http://amtoolbox.sourceforge.net/>`_
* `The Large Time/Frequency Analysis Toolbox (LTFAT) <http://sourceforge.net/projects/ltfat/>`_
* `Sound Field Analysis Toolbox (SOFiA) <https://code.google.com/p/sofia-toolbox/>`_
* `Sound Field Synthesis Toolbox (SFS) <https://github.com/sfstoolbox/sfs/>`_
* `MATLAB2TikZ <https://github.com/nschloe/matlab2tikz/>`_
* `EKF/UKF Toolbox <https://github.com/fietew/ekfukf/>`_

Specific Dependencies
---------------------

If you just want to get the material of one specific publication, you may
not need all the requirements. The table shows, which publication needs which
requirement. The shown versions or commits have to be interpreted as 
"successfully tested under".

+------------------------------+-------------------------------------------------------+---------+
| Publication                  | MATLAB                                                | Gnuplot |
|                              +-----+-------+-------+-----------+-----------+---------+         |
|                              | AMT | LTFAT | SOFiA | SFS       | MAT2TikZ  | EKF/UKF |         | 
+==============================+=====+=======+=======+===========+===========+=========+=========+
| :cite:`Winter2014-FA`        | X   | X     | X     | X         | X         |         |         |
+------------------------------+-----+-------+-------+-----------+-----------+---------+---------+
| :cite:`Winter2015-DAGA`      |     |       |       | |1.2.0|_  |           |         | |5.0.3|_|
+------------------------------+-----+-------+-------+-----------+-----------+---------+---------+
| :cite:`Winter2015-AES`       |     |       |       | X         | X         |         |         |
+------------------------------+-----+-------+-------+-----------+-----------+---------+---------+
| :cite:`Winter2015-EuroNoise` |     |       |       | X         | X         |         | |5.0.3|_|
+------------------------------+-----+-------+-------+-----------+-----------+---------+---------+
| :cite:`Winter2016-TASL`      |     |       |       | |f14513|_ |           |         |         |
+------------------------------+-----+-------+-------+-----------+-----------+---------+---------+
| :cite:`Winter2016-DAGA`      |     |       |       | X         |           |         |         |
+------------------------------+-----+-------+-------+-----------+-----------+---------+---------+
| :cite:`Winter2016-EUSIPCO`   |     |       |       | |2.2.1|_  |           |         |         |
+------------------------------+-----+-------+-------+-----------+-----------+---------+---------+
| :cite:`Winter2017-DAGA`      |     |       |       | |2.3.0|_  |           |         |         |
+------------------------------+-----+-------+-------+-----------+-----------+---------+---------+
| :cite:`Winter2017-AES`       |     |       |       | |2.3.0|_  |           |         | |5.0.3|_|
+------------------------------+-----+-------+-------+-----------+-----------+---------+---------+
| :cite:`Winter2017-AESb`      |     |       |       |           |           |         |         |
+------------------------------+-----+-------+-------+-----------+-----------+---------+---------+
| :cite:`Winter2017-Acoustics` |     |       |       | |7db339|_ |           |         | |5.0.3|_|
+------------------------------+-----+-------+-------+-----------+-----------+---------+---------+

.. |f14513| replace:: f14513
.. |1.2.0| replace:: 1.2.0
.. |2.2.1| replace:: 2.2.1
.. |2.3.0| replace:: 2.3.0
.. |7db339| replace:: 7db339

.. |5.0.3| replace:: 5.0.3

.. _f14513: https://github.com/sfstoolbox/sfs/tree/f14513a43aa59e4fbbe10f96fe1f737470beb96e
.. _1.2.0: http://dx.doi.org/10.5281/zenodo.18230
.. _2.2.1: http://dx.doi.org/10.5281/zenodo.60606
.. _2.3.0: http://dx.doi.org/10.5281/zenodo.345435
.. _7db339: https://github.com/sfstoolbox/sfs-matlab/tree/7db3395da99713f3a94bfcff0c1ff666283d63ce

.. _5.0.3: http://www.gnuplot.info

