# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Memcache Extension
class MemcacheAT56 < AbstractPhpExtension
  init
  desc "Memcache PHP extension"
  homepage "https://github.com/websupport-sk/pecl-memcache"
  url "https://pecl.php.net/get/memcache-3.0.8.tgz"
  sha256 "2cae5b423ffbfd33a259829849f6000d4db018debe3e29ecf3056f06642e8311"
  head "https://github.com/websupport-sk/pecl-memcache.git", branch: "main"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any_skip_relocation, arm64_sequoia:  "6ed209a01d995af840cf8105be50a81111a59f7dc5775a9626d2c1a9a49cc8d1"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "247d5ba60ad3a00a3cbb5a910f9be6399e65b9e6ec439cd9818cf41086618d1d"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "07e71c24e4d89d38467ecb611436e61b1f6625abb599d9b42ef05ce13f30e376"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "b532920875491f228d3db7761c3ea8319a15db0bf339a2316ee12eab3f547897"
    sha256 cellar: :any_skip_relocation, sonoma:         "c8126b340fb1dfbd20a9e7cf1ebd7c406a9df996dcb64c1fbe287ec2ebe280de"
    sha256 cellar: :any_skip_relocation, ventura:        "b02431a40ffb9363b54fd763d074357c5c4627e892e0d6d35a5eca95f5a83335"
    sha256 cellar: :any_skip_relocation, monterey:       "b53981195df335a32b8eaa3b9a33b5d4169899433b43becb2f62c610086f2712"
    sha256 cellar: :any_skip_relocation, arm64_linux:    "674243b1ecc6c93073430d76dbf457722de5343e1ee7dbd79de57d3267d4da58"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "294a7c6ee68c5c92623fe32ccd0f5d9836ecdd202cdd625a65db9468f08d591e"
  end

  resource "inline_patch" do
    url "https://raw.githubusercontent.com/macports/macports-ports/d447a0707b5a4a6326e74968a2ae996c4d081989/php/php-memcache/files/inline.patch"
    sha256 "6157b7b75e5ceb86e2fbe7630173db90c8865fc20e908b2302208c6247b0bbd1"
  end

  resource "IS_CALLABLE_patch" do
    url "https://raw.githubusercontent.com/macports/macports-ports/d447a0707b5a4a6326e74968a2ae996c4d081989/php/php-memcache/files/IS_CALLABLE.patch"
    sha256 "96475c1bbdb0ed902f28e81697fcffa299df3671e663de3698afccdf8f886122"
  end

  resource "ntohll_patch" do
    url "https://raw.githubusercontent.com/macports/macports-ports/d447a0707b5a4a6326e74968a2ae996c4d081989/php/php-memcache/files/ntohll.patch"
    sha256 "576cbbd01cda50cf6ed10ee7c3ca8f8c2ee10d3394e8a1f40ea012c2a0b92346"
  end

  depends_on "zlib"

  def install
    args = %W[
      --enable-memcache
      --with-zlib-dir=#{Formula["zlib"].opt_prefix}
    ]
    Dir.chdir "memcache-#{version}"
    resources.each do |r|
      system "patch", "-p0", "-i", r.cached_download
    end
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
