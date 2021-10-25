# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MYPN="${PN}-python"
PYTHON_COMPAT=( python3_{8..10} )

inherit distutils-r1

DESCRIPTION="A Thrift encoding library for Python"
HOMEPAGE="
	https://github.com/thriftrw/thriftrw-python
	https://pypi.org/project/thriftrw
"
SRC_URI="https://github.com/thriftrw/${MYPN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${MYPN}-${PV}"

SLOT="0"
LICENSE="MIT"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/ply[${PYTHON_USEDEP}]
"
DEPEND="
	${RDEPEND}
	>=dev-python/cython-0.17[${PYTHON_USEDEP}]
	test? (
		>=dev-python/pytest-benchmark-3.0.1[${PYTHON_USEDEP}]
	)
"

PATCHES=(
	"${FILESDIR}/${P}-no-install-examples.patch"
	"${FILESDIR}/${P}-tool-pytest.patch"
)

distutils_enable_tests pytest
