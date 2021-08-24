# Copyright 2019-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="runtime that implements the OmpSs-2 parallel programming model"
HOMEPAGE="https://github.com/bsc-pm/nanos6"
SRC_URI="https://github.com/bsc-pm/nanos6/archive/refs/tags/version-${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-version-${PV}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="debug dlb execution-workflow extrae memkind mercurium papi test unwind"
#jemalloc require custom stuff
#TODO: cuda pqos babeltrace2
#TODO: llvm-libunwind

RDEPEND="
	>=dev-libs/boost-1.59:=
	sys-apps/hwloc
	sys-process/numactl
	virtual/libelf

	dlb? ( sys-cluster/dlb )
	extrae? ( sys-cluster/extrae[nanos] )
	memkind? ( dev-libs/memkind )
	mercurium? ( sys-cluster/mcxx[ompss2] )
	papi? ( dev-libs/papi )
	unwind? ( sys-libs/libunwind )
"
#	jemalloc? ( dev-libs/jemalloc )
DEPEND="${RDEPEND}"

# https://github.com/bsc-pm/nanos6/issues/3
RESTRICT="test"
#RESTRICT="!test? ( test )"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	local myconf=(
		--disable-embed-code-changes
		--disable-openacc
		--disable-static

		--enable-shared

		--with-boost="${EPREFIX}/usr"
		--with-libnuma="${EPREFIX}/usr"
		--with-pic

		--without-git
		--without-k1om
		--without-nanos6-clang
		--without-pgi

		$(use_enable debug extra-debug)
	)
	use dlb && myconf+=( "--with-dlb=${EPREFIX}/usr" )
	use memkind && myconf+=( "--with-memkind=${EPREFIX}/usr" )

#	if use babeltrace; then
#		myconf+=( "--with-babeltrace2=${EPREFIX}/usr" )
#	else
#		myconf+=( "--without-babeltrace2" )
#	fi
	if use extrae; then
		myconf+=( "--with-extrae=${EPREFIX}/usr" )
	else
		myconf+=( "--without-extrae" )
	fi
#	if use jemalloc; then
#		myconf+=( "--with-jemalloc=${EPREFIX}/usr" )
#	else
#		myconf+=( "--without-jemalloc" )
#	fi
	if use mercurium; then
		myconf+=( "--with-nanos6-mercurium=${EPREFIX}/usr" )
	else
		myconf+=( "--without-nanos6-mercurium" )
	fi
	if use papi; then
		myconf+=( "--with-papi=${EPREFIX}/usr" )
	else
		myconf+=( "--without-papi" )
	fi
	if use unwind; then
		myconf+=( "--with-libunwind=${EPREFIX}/usr" )
	else
		myconf+=( "--without-libunwind" )
	fi

	econf "${myconf[@]}"
}
#		--without-pqos
#		--without-cuda

src_install() {
	default
	dodoc CHANGELOG.md
	rm -r docs/Doxyfile* || die
	dodoc -r docs/.

	docompress -x "/usr/share/doc/${PF}/paraver-cfg"
	docompress -x "/usr/share/doc/${PF}/scripts"
}

pkg_postinst() {
	elog "install media-gfx/graphviz and app-text/pdfjam or >=app-text/texlive-core-2021 to generate graphical representations of the dependency graph"
	elog "install sys-process/parallel to generate the graph representation in parallel"
}
