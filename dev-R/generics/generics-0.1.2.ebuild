# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit R-packages

DESCRIPTION="Common S3 Generics not Provided by Base R Methods Related to Model Fitting"
KEYWORDS="~amd64"
HOMEPAGE="https://cran.r-project.org/package=generics"
LICENSE="MIT"
DEPEND=">=dev-lang/R-3.2"
RDEPEND="${DEPEND}"

SUGGESTED_PACKAGES="
	dev-R/covr
	dev-R/pkgload
	>=dev-R/testthat-3.0.0
	dev-R/tibble
	dev-R/withr
"
