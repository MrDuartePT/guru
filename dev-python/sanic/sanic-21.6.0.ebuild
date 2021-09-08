# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="8"

DISTUTILS_USE_SETUPTOOLS=rdepend
PYTHON_COMPAT=( python3_{8..9} )

inherit distutils-r1

DESCRIPTION="Async Python 3.6+ web server/framework | Build fast. Run fast."
HOMEPAGE="
	https://pypi.python.org/pypi/sanic
	https://github.com/huge-success/sanic
"
SRC_URI="https://github.com/huge-success/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-python/aiofiles-0.6.0[${PYTHON_USEDEP}]
	>=dev-python/httptools-0.0.10[${PYTHON_USEDEP}]
	>=dev-python/multidict-5.0[${PYTHON_USEDEP}]
	>=dev-python/sanic-routing-0.0.10[${PYTHON_USEDEP}]
	dev-python/ujson[${PYTHON_USEDEP}]
	dev-python/uvloop[${PYTHON_USEDEP}]
	>=dev-python/websockets-8.1[${PYTHON_USEDEP}]
"
DEPEND="
	${RDEPEND}
	test? (
		dev-python/beautifulsoup4[${PYTHON_USEDEP}]
		>=dev-python/httpcore-0.3.0[${PYTHON_USEDEP}]
		>=dev-python/pytest-5.2.1[${PYTHON_USEDEP}]
		dev-python/pytest-benchmark[${PYTHON_USEDEP}]
		dev-python/pytest-sanic[${PYTHON_USEDEP}]
		dev-python/sanic-testing[${PYTHON_USEDEP}]
		dev-python/uvicorn[${PYTHON_USEDEP}]
		www-servers/gunicorn[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
distutils_enable_sphinx docs \
				dev-python/docutils \
				dev-python/pygments \
				dev-python/sphinx_rtd_theme \
				dev-python/recommonmark \
				www-servers/gunicorn

python_test() {
	pytest -vv --deselect tests/test_keep_alive_timeout.py::test_keep_alive_client_timeout || die
}
