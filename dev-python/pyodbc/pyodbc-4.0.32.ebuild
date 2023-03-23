# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{9..10} ) # pypy3 https://github.com/mkleehammer/pyodbc/issues/915

inherit distutils-r1 pypi

DESCRIPTION="Python ODBC library"
HOMEPAGE="
	https://github.com/mkleehammer/pyodbc
	https://pypi.org/project/pyodbc/
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="mssql"

RDEPEND="
	>=dev-db/unixODBC-2.3.0
	mssql? ( >=dev-db/freetds-0.64[odbc] )
"
DEPEND="${RDEPEND}"

RESTRICT="test" # need running databases
