# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..9} )

inherit distutils-r1

DESCRIPTION="Interrogate and manipulate UFO, TTF and OTF fonts with a common interface"
HOMEPAGE="https://github.com/simoncozens/babelfont"
SRC_URI="https://github.com/simoncozens/babelfont/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
KEYWORDS="~amd64"
LICENSE="MIT"
SLOT="0"

RDEPEND="
	dev-python/defcon[${PYTHON_USEDEP}]
	dev-python/fontParts[${PYTHON_USEDEP}]
	dev-python/fonttools[${PYTHON_USEDEP}]
	dev-python/glyphsLib[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}"

distutils_enable_tests pytest
