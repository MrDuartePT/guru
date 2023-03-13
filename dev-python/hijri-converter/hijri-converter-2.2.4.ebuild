# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{9..11} pypy3 )

inherit distutils-r1

DESCRIPTION="Accurate Hijri-Gregorian date converter based on the Umm al-Qura calendar"
HOMEPAGE="https://github.com/dralshehri/hijri-converter"
SRC_URI="https://github.com/dralshehri/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

distutils_enable_tests pytest

distutils_enable_sphinx docs
