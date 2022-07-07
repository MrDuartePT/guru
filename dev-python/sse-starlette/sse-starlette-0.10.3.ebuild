# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..10} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1

DESCRIPTION="Server Sent Events for Starlette"
HOMEPAGE="
	https://pypi.org/project/sse-starlette/
	https://github.com/sysid/sse-starlette
"
SRC_URI="https://github.com/sysid/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-python/starlette[${PYTHON_USEDEP}]"
BDEPEND="
	test? (
		dev-python/pytest-asyncio[${PYTHON_USEDEP}]
		dev-python/requests[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
