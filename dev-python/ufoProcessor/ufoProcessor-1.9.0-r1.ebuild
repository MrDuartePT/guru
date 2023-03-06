# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..10} )

inherit distutils-r1

DESCRIPTION="A Python package for processing and generating UFO files"
HOMEPAGE="https://github.com/LettError/ufoProcessor"
SRC_URI="https://github.com/LettError/ufoProcessor/archive/refs/tags/${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
IUSE="test"
KEYWORDS="~amd64"

RDEPEND="
	${PYTHON_DEPS}
	>=dev-python/defcon-0.6.0[${PYTHON_USEDEP}]
	>=dev-python/fontMath-0.4.9[${PYTHON_USEDEP}]
	>=dev-python/fontParts-0.8.2[${PYTHON_USEDEP}]
	>=dev-python/fonttools-3.32.0[${PYTHON_USEDEP}]
	>=dev-python/MutatorMath-2.1.2[${PYTHON_USEDEP}]
"
DEPEND="
	${RDEPEND}
	test? ( dev-python/unicodedata2[${PYTHON_USEDEP}] )
"
BDEPEND="dev-python/setuptools-scm[${PYTHON_USEDEP}]"

RESTRICT="!test? ( test )"

pkg_setup() {
	export SETUPTOOLS_SCM_PRETEND_VERSION="${PV%_*}"
}

python_test() {
	"${EPYTHON}" Tests/tests.py || die "Tests failed with ${EPYTHON}"
}
