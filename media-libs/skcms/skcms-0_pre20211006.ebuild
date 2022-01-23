# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs

DESCRIPTION="A complete 2D graphic library for drawing Text, Geometries, and Images"
HOMEPAGE="https://skia.googlesource.com/skcms"
SRC_URI="https://drive.google.com/uc?export=download&id=1BmWRhwDnribygNRsR2UwaxIMrAB7GZw4 -> ${PF}.tar.gz"
S="${WORKDIR}"

KEYWORDS="~amd64"
LICENSE="BSD"
SLOT="0"
IUSE="test"

RDEPEND=""
DEPEND="${RDEPEND}"

RESTRICT="!test? ( test )"

src_compile() {
	tc-export CC CXX

	${CXX} ${CXXFLAGS} ${LDFLAGS} -fPIC -shared -I./src -Wl,-soname,libskcms.so skcms.cc -o libskcms.so || die
	${CC} ${CFLAGS} -fPIC -I./src -c test_only.c || die
	${CC} ${CFLAGS} ${LDFLAGS} -fPIE -I./src test_only.o iccdump.c -o iccdump -ldl -L. -lskcms || die
	${CC} ${CFLAGS} ${LDFLAGS} -fPIE -I./src test_only.o tests.c -o tests -L. -lskcms || die
}

src_install() {
	dolib.so libskcms.so
	dobin iccdump
	doheader skcms.h
}

src_test() {
	LD_LIBRARY_PATH="./:${LD_LIBRARY_PATH}" ./tests || die
}
