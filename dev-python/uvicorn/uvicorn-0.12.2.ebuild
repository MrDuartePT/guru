# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7,8} )

DISTUTILS_USE_SETUPTOOLS=rdepend

DOCS_BUILDER="mkdocs"
DOCS_DEPEND="dev-python/mkdocs-material"

inherit distutils-r1 docs optfeature

DESCRIPTION="The lightning-fast ASGI server"
HOMEPAGE="https://www.uvicorn.org/
	https://github.com/encode/uvicorn"
SRC_URI="https://github.com/encode/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
KEYWORDS="~amd64 ~x86"
SLOT="0"

RDEPEND="
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/h11[${PYTHON_USEDEP}]
	dev-python/typing-extensions[${PYTHON_USEDEP}]
"

BDEPEND="test? (
	dev-python/colorama[${PYTHON_USEDEP}]
	dev-python/pytest-mock[${PYTHON_USEDEP}]
	dev-python/python-dotenv[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
	dev-python/trustme[${PYTHON_USEDEP}]
	>=dev-python/uvloop-0.14.0[${PYTHON_USEDEP}]
	>=dev-python/websockets-8.0[${PYTHON_USEDEP}]
	dev-python/httptools[${PYTHON_USEDEP}]
	>=dev-python/watchgod-0.6[${PYTHON_USEDEP}]
	dev-python/wsproto[${PYTHON_USEDEP}]
)"

distutils_enable_tests pytest

python_prepare_all() {
	# do not install LICENSE to /usr/
	sed -i -e '/data_files/d' setup.py || die

	# Remove pytest-cov dep
	sed -i -e '21,22d' setup.cfg || die

	distutils-r1_python_prepare_all
}

pkg_postinst() {
	optfeature "asyncio event loop on top of libuv" dev-python/uvloop
	optfeature "websockets support using wsproto" dev-python/wsproto
	optfeature "websockets support using websockets" dev-python/websockets
	optfeature "httpstools package for http protocol" dev-python/httptools
	optfeature "efficient debug reload" dev-python/watchgod
}
