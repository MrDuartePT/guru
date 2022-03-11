# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit R-packages

DESCRIPTION='Simulate Package Installation and Attach'
KEYWORDS="~amd64"
LICENSE='GPL-3'

DEPEND="
	dev-R/cli
	dev-R/desc
	dev-R/crayon
	dev-R/rprojroot
	dev-R/rlang
	dev-R/rstudioapi
	dev-R/withr
"
RDEPEND="${DEPEND}"

SUGGESTED_PACKAGES="
	dev-R/bitops
	dev-R/covr
	dev-R/pkgbuild
	dev-R/Rcpp
	dev-R/testthat
"
