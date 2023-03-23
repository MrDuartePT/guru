# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYPI_NO_NORMALIZE=1
PYTHON_COMPAT=( python3_{9..11} pypy3 )

inherit distutils-r1 pypi

DESCRIPTION="Typing stubs for requests"
HOMEPAGE="
	https://pypi.org/project/types-requests/
	https://github.com/python/typeshed/tree/master/stubs/requests
"

SLOT="0"
LICENSE="Apache-2.0"
KEYWORDS="~amd64"

RDEPEND="<dev-python/types-urllib3-1.27"
DEPEND="${RDEPEND}"
