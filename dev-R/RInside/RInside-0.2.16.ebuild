# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit R-packages toolchain-funcs

DESCRIPTION='C++ Classes to Embed R in C++ (and C) Applications'
KEYWORDS="~amd64"
LICENSE='GPL-2+'
HOMEPAGE="
	https://cran.r-project.org/package=RInside
	http://dirk.eddelbuettel.com/code/rinside.html
	https://github.com/eddelbuettel/rinside
"
DEPEND="
	dev-R/Rcpp
"
RDEPEND="${DEPEND}"

src_prepare() {
	tc-export AR
	R-packages_src_prepare
}
