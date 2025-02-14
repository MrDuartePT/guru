# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Auto-Generated by cargo-ebuild 0.5.4

EAPI=8

CRATES="
	aho-corasick-1.0.1
	ansi_term-0.12.1
	anstyle-1.0.0
	assert_cmd-2.0.11
	atty-0.2.14
	autocfg-1.1.0
	bitflags-1.3.2
	bstr-1.4.0
	cc-1.0.79
	cfg-if-1.0.0
	clap-3.2.25
	clap_complete-3.2.5
	clap_lex-0.2.4
	clap_mangen-0.1.11
	config-file-0.2.3
	core-foundation-sys-0.8.4
	crossbeam-channel-0.5.8
	crossbeam-deque-0.8.3
	crossbeam-epoch-0.9.14
	crossbeam-utils-0.8.15
	difflib-0.4.0
	directories-4.0.1
	dirs-sys-0.3.7
	doc-comment-0.3.3
	either-1.8.1
	errno-0.3.1
	errno-dragonfly-0.1.2
	fastrand-1.9.0
	getrandom-0.2.9
	hashbrown-0.12.3
	hermit-abi-0.1.19
	hermit-abi-0.2.6
	hermit-abi-0.3.1
	indexmap-1.9.3
	instant-0.1.12
	io-lifetimes-1.0.10
	itertools-0.10.5
	lazy_static-1.4.0
	libc-0.2.142
	linux-raw-sys-0.3.7
	lscolors-0.13.0
	memchr-2.5.0
	memoffset-0.8.0
	ntapi-0.4.1
	nu-ansi-term-0.46.0
	num_cpus-1.15.0
	once_cell-1.17.1
	os_str_bytes-6.5.0
	overload-0.1.1
	predicates-3.0.3
	predicates-core-1.0.6
	predicates-tree-1.0.9
	proc-macro2-1.0.56
	quote-1.0.26
	rayon-1.7.0
	rayon-core-1.11.0
	redox_syscall-0.2.16
	redox_syscall-0.3.5
	redox_users-0.4.3
	regex-1.8.1
	regex-automata-0.1.10
	regex-syntax-0.7.1
	roff-0.2.1
	rustix-0.37.19
	scopeguard-1.1.0
	serde-1.0.162
	serde_derive-1.0.162
	stfu8-0.2.6
	strsim-0.10.0
	syn-2.0.15
	sysinfo-0.27.8
	tempfile-3.5.0
	termcolor-1.2.0
	terminal_size-0.2.6
	termtree-0.4.1
	textwrap-0.16.0
	thiserror-1.0.40
	thiserror-impl-1.0.40
	thousands-0.2.0
	toml-0.5.11
	unicode-ident-1.0.8
	unicode-width-0.1.10
	wait-timeout-0.2.0
	wasi-0.11.0+wasi-snapshot-preview1
	winapi-0.3.9
	winapi-i686-pc-windows-gnu-0.4.0
	winapi-util-0.1.5
	winapi-x86_64-pc-windows-gnu-0.4.0
	windows-sys-0.45.0
	windows-sys-0.48.0
	windows-targets-0.42.2
	windows-targets-0.48.0
	windows_aarch64_gnullvm-0.42.2
	windows_aarch64_gnullvm-0.48.0
	windows_aarch64_msvc-0.42.2
	windows_aarch64_msvc-0.48.0
	windows_i686_gnu-0.42.2
	windows_i686_gnu-0.48.0
	windows_i686_msvc-0.42.2
	windows_i686_msvc-0.48.0
	windows_x86_64_gnu-0.42.2
	windows_x86_64_gnu-0.48.0
	windows_x86_64_gnullvm-0.42.2
	windows_x86_64_gnullvm-0.48.0
	windows_x86_64_msvc-0.42.2
	windows_x86_64_msvc-0.48.0
"

inherit cargo

DESCRIPTION="A more intuitive version of du"
HOMEPAGE="https://github.com/bootandy/dust"
SRC_URI="https://github.com/bootandy/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
SRC_URI+=" $(cargo_crate_uris)"

LICENSE="Apache-2.0 BSD BSD-2 MIT Unicode-DFS-2016"
SLOT="0"
KEYWORDS="~amd64 ~x86"
# Prevent portage from trying to fetch bunch of *.crate from mirror despite they are not mirrored.
RESTRICT="mirror"

# rust does not use *FLAGS from make.conf, silence portage warning
# update with proper path to binaries this crate installs, omit leading /
QA_FLAGS_IGNORED="usr/bin/${PN}"

src_install() {
	cargo_src_install

	dodoc README.md
	doman man-page/${PN}.1
}
