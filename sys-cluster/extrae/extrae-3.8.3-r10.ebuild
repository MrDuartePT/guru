# Copyright 2019-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( pypy3 python3_{8..10} )

inherit autotools java-pkg-opt-2 python-single-r1

DESCRIPTION="Instrumentation framework to generate execution traces of parallel runtimes"
HOMEPAGE="https://github.com/bsc-performance-tools/extrae"
SRC_URI="https://github.com/bsc-performance-tools/extrae/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"

IUSE_INSTRUMENT="
	+instrument-dynamic-memory
	+instrument-io
	+instrument-syscall
"
IUSE="${IUSE_INSTRUMENT} clustering dlsym doc dyninst heterogeneous inotify memkind
merge-in-trace nanos online opencl openmp openshmem +parallel-merge pebs-sampling
peruse +posix-clock pthread sampling +single-mpi-lib sionlib smpss spectral +xml"

#aspectj and aspectj-weaver need to both be enabled at the same time
#current dev-java/aspectj package only provides aspectj.jar
#aspectj needs foo/lib/aspectj.jar and foo/bin/ajc
#aspectj-weaver needs bar/aspectjweaver.jar
#TODO: cuda cupti gm mx
#TODO: support llvm libunwind, llvm rt, elftoolchain

CDEPEND="
	${PYTHON_DEPS}
	dev-libs/libxml2
	dev-libs/papi
	!sys-cluster/openmpi[libompitrace(+)]
	sys-libs/libunwind
	sys-libs/zlib
	virtual/mpi

	|| ( sys-devel/binutils:* sys-libs/binutils-libs )

	clustering? ( sys-cluster/clusteringsuite[treedbscan] )
	dyninst? (
		dev-libs/boost:=
		dev-libs/libdwarf
		sys-cluster/dyninst
		virtual/libelf
	)
	inotify? ( dev-libs/libevent )
	memkind? ( dev-libs/memkind )
	online? ( sys-cluster/synapse )
	opencl? ( dev-util/opencl-headers )
	openshmem? ( sys-cluster/SOS )
	peruse? ( sys-cluster/openmpi[peruse(-)] )
	sionlib? ( sys-cluster/sionlib:= )
	spectral? (
		sci-libs/fftw
		sys-cluster/spectral
	)
"
#	aspectj? ( >=dev-java/aspectj-1.9.6 )
DEPEND="
	${CDEPEND}
	java? ( virtual/jdk:1.8 )
"
RDEPEND="
	${CDEPEND}
	java? ( virtual/jre:1.8 )
	virtual/opencl
"
BDEPEND="
	doc? (
		app-text/ghostscript-gpl
		dev-python/sphinx
		dev-tex/latexmk
		dev-texlive/texlive-latexextra
	)
"

REQUIRED_USE="
	${PYTHON_REQUIRED_USE}

	|| ( ${IUSE_INSTRUMENT//+/} )

	java? ( pthread )
"
#	cupti? ( cuda )
#	aspectj? ( java )

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	export VARTEXFONTS="${T}/fonts"

	local myconf=(
		--datadir="${T}"
		--datarootdir="${T}"

		--disable-mic
		--disable-pmapi
		--disable-static

		--enable-shared

		--with-librt="${EPREFIX}/usr"
		--with-mpi="${EPREFIX}/usr"
		--with-papi="${EPREFIX}/usr"
		--with-unwind="${EPREFIX}/usr"

		--without-cupti
		--without-gm
		--without-mx

		$(use_enable doc)
		$(use_enable heterogeneous)
		$(use_enable inotify)
		$(use_enable instrument-dynamic-memory)
		$(use_enable instrument-io)
		$(use_enable instrument-syscall)
		$(use_enable merge-in-trace)
		$(use_enable nanos)
		$(use_enable online)
		$(use_enable openmp)
		$(use_enable parallel-merge)
		$(use_enable pebs-sampling)
		$(use_enable peruse)
		$(use_enable posix-clock)
		$(use_enable pthread)
		$(use_enable sampling)
		$(use_enable single-mpi-lib)
		$(use_enable smpss)
		$(use_enable xml)
	)

	use dlsym && myconf+=( "--with-pmpi-hook=dlsym" )

#	if use aspectj; then
#		myconf+=( "--with-java-aspectj=${EPREFIX}/usr/share/aspectj/lib" )
#		myconf+=( "--with-java-aspectj-weaver=${EPREFIX}/usr" )
#	else
		myconf+=( "--without-java-aspectj-weaver" )
		myconf+=( "--without-java-aspectj" )
#	fi
	if use clustering; then
		myconf+=( "--with-clustering=${EPREFIX}/usr" )
	else
		myconf+=( "--without-clustering" )
	fi
	if use dyninst; then
		myconf+=( "--with-boost=${EPREFIX}/usr" )
		myconf+=( "--with-dyninst=${EPREFIX}/usr" )
		myconf+=( "--with-dyninst-headers=${EPREFIX}/usr/include/dyninst" )
		myconf+=( "--with-dwarf=${EPREFIX}/usr" )
		myconf+=( "--with-elf=${EPREFIX}/usr" )
	else
		myconf+=( "--without-boost" )
		myconf+=( "--without-dyninst" )
		myconf+=( "--without-dwarf" )
		myconf+=( "--without-elf" )
	fi
	if use java; then
		myconf+=( "--with-java-jdk=$(java-config -O)" )
	else
		myconf+=( "--without-java-jdk" )
	fi
	if use memkind; then
		myconf+=( "--with-memkind=${EPREFIX}/usr" )
	else
		myconf+=( "--without-memkind" )
	fi
	if use online; then
		myconf+=( "--with-synapse=${EPREFIX}/usr" )
	else
		myconf+=( "--without-synapse" )
	fi
	if use opencl; then
		myconf+=( "--with-opencl=${EPREFIX}/usr" )
	else
		myconf+=( "--without-opencl" )
	fi
	if use openshmem; then
		myconf+=( "--with-openshmem=${EPREFIX}/usr" )
	else
		myconf+=( "--without-openshmem" )
	fi
	if use sionlib; then
		myconf+=( "--with-sionlib=${EPREFIX}/usr" )
		myconf+=( "--with-sionlib-headers=${EPREFIX}/usr/include/sionlib" )
	fi
	if use spectral; then
		myconf+=( "--with-fft=${EPREFIX}/usr" )
		myconf+=( "--with-spectral=${EPREFIX}/usr" )
	else
		myconf+=( "--without-fft" )
		myconf+=( "--without-spectral" )
	fi

	econf "${myconf[@]}"
}

src_install() {
	default

	#TODO: build examples

	mkdir -p "${D}/$(python_get_sitedir)/" || die
	mv "${ED}/usr/libexec/pyextrae" "${D}/$(python_get_sitedir)/" || die
	python_optimize "${D}/$(python_get_sitedir)/pyextrae"

	#super-duper workaround
	mkdir -p "${ED}/usr/share/doc/${PF}" || die
	mv "${ED}/${T}/example" "${ED}/usr/share/doc/${PF}/examples" || die
	mv "${ED}/${T}/tests" "${ED}/usr/share/doc/${PF}/" || die

	if use doc ; then
		mv "${T}/docs"/* "${ED}/usr/share/doc/${PF}/" || die
		mv "${T}/man" "${ED}/usr/share/" || die
		docompress -x "/usr/share/doc/${PF}/html"
	fi
	docompress -x "/usr/share/doc/${PF}/examples"
	docompress -x "/usr/share/doc/${PF}/tests"

	find "${ED}" -name '*.a' -delete || die
	find "${ED}" -name '*.la' -delete || die
}
