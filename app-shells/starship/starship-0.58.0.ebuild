# Copyright 2020-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
	ahash-0.4.7
	aho-corasick-0.7.18
	ansi_term-0.11.0
	ansi_term-0.12.1
	arrayref-0.3.6
	arrayvec-0.5.2
	async-io-1.6.0
	attohttpc-0.17.0
	atty-0.2.14
	autocfg-1.0.1
	base64-0.13.0
	battery-0.7.8
	bitflags-0.9.1
	bitflags-1.2.1
	blake2b_simd-0.5.11
	block-0.1.6
	block-buffer-0.7.3
	block-padding-0.1.5
	byte-tools-0.3.1
	byte-unit-4.0.12
	byteorder-1.4.3
	bytes-1.1.0
	cache-padded-1.1.1
	cc-1.0.70
	cfg-if-0.1.10
	cfg-if-1.0.0
	chrono-0.4.19
	clap-2.33.3
	concurrent-queue-1.2.2
	constant_time_eq-0.1.5
	core-foundation-0.7.0
	core-foundation-0.9.1
	core-foundation-sys-0.7.0
	core-foundation-sys-0.8.2
	crossbeam-channel-0.5.1
	crossbeam-deque-0.8.1
	crossbeam-epoch-0.9.5
	crossbeam-utils-0.8.5
	derivative-2.2.0
	difference-2.0.0
	digest-0.8.1
	directories-next-2.0.0
	dirs-1.0.5
	dirs-sys-next-0.1.2
	dlv-list-0.2.3
	downcast-0.10.0
	dtoa-0.4.8
	either-1.6.1
	enumflags2-0.6.4
	enumflags2_derive-0.6.4
	fake-simd-0.1.2
	fastrand-1.5.0
	float-cmp-0.8.0
	fnv-1.0.7
	foreign-types-0.3.2
	foreign-types-shared-0.1.1
	form_urlencoded-1.0.1
	fragile-1.0.0
	futures-0.3.17
	futures-channel-0.3.17
	futures-core-0.3.17
	futures-executor-0.3.17
	futures-io-0.3.17
	futures-lite-1.12.0
	futures-macro-0.3.17
	futures-sink-0.3.17
	futures-task-0.3.17
	futures-util-0.3.17
	generic-array-0.12.4
	gethostname-0.2.1
	getrandom-0.1.16
	getrandom-0.2.3
	git2-0.13.22
	hashbrown-0.9.1
	hashbrown-0.11.2
	hermit-abi-0.1.19
	http-0.2.4
	idna-0.2.3
	indexmap-1.7.0
	instant-0.1.10
	itertools-0.10.1
	itoa-0.4.8
	jobserver-0.1.24
	lazy_static-1.4.0
	lazycell-1.3.0
	libc-0.2.102
	libgit2-sys-0.12.23+1.2.0
	libz-sys-1.1.3
	linked-hash-map-0.5.4
	log-0.4.14
	mac-notification-sys-0.3.0
	mach-0.3.2
	malloc_buf-0.0.6
	maplit-1.0.2
	matches-0.1.9
	memchr-2.4.1
	memoffset-0.6.4
	minimal-lexical-0.1.3
	mockall-0.10.2
	mockall_derive-0.10.2
	native-tls-0.2.8
	nb-connect-1.2.0
	nix-0.17.0
	nix-0.19.1
	nix-0.22.1
	nom-7.0.0
	normalize-line-endings-0.3.0
	notify-rust-4.5.3
	num-integer-0.1.44
	num-traits-0.2.14
	num_cpus-1.13.0
	objc-0.2.7
	objc-foundation-0.1.1
	objc_id-0.1.1
	once_cell-1.8.0
	opaque-debug-0.2.3
	open-2.0.1
	openssl-0.10.36
	openssl-probe-0.1.4
	openssl-src-111.16.0+1.1.1l
	openssl-sys-0.9.66
	ordered-multimap-0.3.1
	os_info-3.0.7
	parking-2.0.0
	path-slash-0.1.4
	pathdiff-0.2.0
	percent-encoding-2.1.0
	pest-2.1.3
	pest_derive-2.1.0
	pest_generator-2.1.3
	pest_meta-2.1.3
	pin-project-lite-0.2.7
	pin-utils-0.1.0
	pkg-config-0.3.19
	polling-2.1.0
	ppv-lite86-0.2.10
	predicates-1.0.8
	predicates-core-1.0.2
	predicates-tree-1.0.3
	proc-macro-crate-0.1.5
	proc-macro-crate-1.1.0
	proc-macro-hack-0.5.19
	proc-macro-nested-0.1.7
	proc-macro2-1.0.29
	process_control-3.1.0
	quick-xml-0.22.0
	quote-0.3.15
	quote-1.0.9
	rand-0.8.4
	rand_chacha-0.3.1
	rand_core-0.6.3
	rand_hc-0.3.1
	rayon-1.5.1
	rayon-core-1.9.1
	redox_syscall-0.1.57
	redox_syscall-0.2.10
	redox_users-0.3.5
	redox_users-0.4.0
	regex-1.5.4
	regex-syntax-0.6.25
	remove_dir_all-0.5.3
	rust-argon2-0.8.3
	rust-ini-0.17.0
	ryu-1.0.5
	schannel-0.1.19
	scoped-tls-1.0.0
	scopeguard-1.1.0
	security-framework-2.3.1
	security-framework-sys-2.4.2
	semver-1.0.4
	serde-1.0.130
	serde_derive-1.0.130
	serde_json-1.0.68
	serde_repr-0.1.7
	serde_urlencoded-0.6.1
	sha-1-0.8.2
	shadow-rs-0.7.1
	shell-words-1.0.0
	slab-0.4.4
	socket2-0.4.2
	starship-0.58.0
	starship_module_config_derive-0.2.1
	static_assertions-1.1.0
	strsim-0.8.0
	strsim-0.10.0
	strum-0.8.0
	strum_macros-0.8.0
	syn-0.11.11
	syn-1.0.76
	synom-0.11.3
	sys-info-0.9.0
	tempfile-3.2.0
	term_size-0.3.2
	textwrap-0.11.0
	thiserror-1.0.29
	thiserror-impl-1.0.29
	time-0.1.44
	tinyvec-1.4.0
	tinyvec_macros-0.1.0
	toml-0.5.8
	treeline-0.1.0
	typenum-1.14.0
	ucd-trie-0.1.3
	unicode-bidi-0.3.6
	unicode-normalization-0.1.19
	unicode-segmentation-1.8.0
	unicode-width-0.1.9
	unicode-xid-0.0.4
	unicode-xid-0.2.2
	uom-0.30.0
	url-2.2.2
	urlencoding-2.1.0
	utf8-width-0.1.5
	vcpkg-0.2.15
	vec_map-0.8.2
	version_check-0.9.3
	versions-3.0.3
	void-1.0.2
	waker-fn-1.1.0
	wasi-0.9.0+wasi-snapshot-preview1
	wasi-0.10.0+wasi-snapshot-preview1
	wepoll-ffi-0.1.2
	which-4.2.2
	wildmatch-1.1.0
	winapi-0.3.9
	winapi-i686-pc-windows-gnu-0.4.0
	winapi-x86_64-pc-windows-gnu-0.4.0
	winrt-0.4.0
	winrt-notification-0.2.4
	xml-rs-0.6.1
	yaml-rust-0.4.5
	zbus-1.9.1
	zbus_macros-1.9.1
	zvariant-2.8.0
	zvariant_derive-2.8.0
"

inherit cargo

DESCRIPTION="The minimal, blazing-fast, and infinitely customizable prompt for any shell!"
HOMEPAGE="https://github.com/starship/starship"
SRC_URI="$(cargo_crate_uris ${CRATES})"

LICENSE="
	|| ( Apache-2.0 Apache-2.0-with-LLVM-exceptions MIT )
	|| ( Apache-2.0 Boost-1.0 )
	|| ( Apache-2.0 MIT )
	|| ( Apache-2.0 MIT ZLIB )
	|| ( MIT Unlicense )
	Apache-2.0
	BSD-2
	ISC
	MIT
	MPL-2.0
"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+battery +http tls-vendored"

DEPEND="
	>=dev-libs/libgit2-1.2.0:=
	!tls-vendored? ( dev-libs/openssl:0= )
"
RDEPEND="${DEPEND}
"

DOCS=( README.md )

# Rust packages ignore CFLAGS and LDFLAGS so let's silence the QA warnings
QA_FLAGS_IGNORED="usr/bin/starship"

src_configure() {
	myfeatures=(
		$(usev battery)
		$(usev http)
		$(usev tls-vendored)
	)
	cargo_src_configure --no-default-features
}

src_install() {
	cargo_src_install

	einstalldocs
}
