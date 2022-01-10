# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..10} )
DOCS_BUILDER="mkdocs"
DOCS_DEPEND="dev-python/mkdocs-material"
DOCS_DIR="docs"
inherit distutils-r1 docs

DESCRIPTION="Create decorators easily in python"
HOMEPAGE="https://pypi.org/project/decopatch/ https://github.com/smarie/python-decopatch"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

# ImportError: cannot import name 'case_name' from 'pytest_cases'
RESTRICT="test"

RDEPEND="dev-python/makefun[${PYTHON_USEDEP}]"
BDEPEND="
	dev-python/setuptools_scm[${PYTHON_USEDEP}]
	test? ( dev-python/pytest-cases[${PYTHON_USEDEP}] )
"

distutils_enable_tests pytest

python_prepare_all() {
	sed "s/'pytest-runner', //" -i setup.py || die
	distutils-r1_python_prepare_all
}

python_compile_all() {
	docs_compile
}
