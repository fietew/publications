publications
============

This is repository for additional material and figures of my publications.

List of Publications
--------------------

BibTeX file for all publications can be at [here](papers/papers.bib)

[F. Winter, F. Schultz, S. Spors. Localization Properties of Data-based Binaural Synthesis including Translatory Head-Movements. FORUM ACUSTICUM, 2014.](papers/2014-09_ForumAcusticum_Localization Binaural Synthesis)

[F. Winter, S. Spors. Parameter Analysis for Range Extrapolation of Head-Related Transfer Functions using Virtual Local Wave Field Synthesis. German Annual Conference on Acoustics (DAGA), 2015.](papers/2015-03_DAGA_HRTF Extrapolation Local WFS)


Usage
-----

The material for specific publications is stored under the papers directory. In
order to generate a figure of one of the publications, switch to the figXX
directory and execute the scripts in the following order (if existent):

1. MATLAB script: fixXX.m
2. gnuplot script: figXX.gnu
3. include figXX.tex, figXX.png, figXX.pdf in your LaTeX document

Requirements
------------

### LaTeX

* Tikz
* PGF-plots

### MATLAB

The code of this repository has been tested under MATLABR2013b. It uses the
following toolboxes, which you should download and add the their path to your
MATLAB path. For specific installation instructions please take a look at the
listed websites.
* Auditory Modelling Toolbox ( http://amtoolbox.sourceforge.net/ )
* LTFAT Toolbox( http://sourceforge.net/projects/ltfat/ )
* SOFIA Toolbox ( https://code.google.com/p/sofia-toolbox/ )
* Sound Field Synthesis Toolbox ( https://github.com/sfstoolbox/sfs )
* MATLAB2TIKZ ( https://github.com/nschloe/matlab2tikz )
* EKF/UKF Toolbox ( https://github.com/fietew/ekfukf )

Please also add the `./tools/matlab` directory to your MATLAB path.
