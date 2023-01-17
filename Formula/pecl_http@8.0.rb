# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pecl_http Extension
class PeclHttpAT80 < AbstractPhpExtension
  init
  desc "Pecl_http PHP extension"
  homepage "https://github.com/m6w6/ext-http"
  url "https://pecl.php.net/get/pecl_http-4.2.3.tgz"
  sha256 "fa2ab558fc8f0928a10f35c0f566f7c4a1d32e727bd3a96579e4c28482ee9d6a"
  head "https://github.com/m6w6/ext-http.git"
  license "BSD-2-Clause"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any,                 arm64_monterey: "ec2779c7d344e96a0acce156c5388f6b7576de759364e933a15241cdc927e54b"
    sha256 cellar: :any,                 arm64_big_sur:  "a981a02c303061967eadaa8c65e6918e7b56fdd1d399b6d4233a44501dd0ed2b"
    sha256 cellar: :any,                 monterey:       "32c6ba49a5f83a198ab22b92ff90650e4de1e4b524b3ad715f281290611fba14"
    sha256 cellar: :any,                 big_sur:        "8da906366bf410d9b172c9a9cfcbe38ee4c4f708776ab897dd435048f13c7b43"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "dbf897495e9709316744a341eef8e1e53e45d9207cbeb4e2693ae5d96ade8c64"
  end

  depends_on "brotli"
  depends_on "curl"
  depends_on "icu4c"
  depends_on "libevent"
  depends_on "libidn2"
  depends_on "shivammathur/extensions/raphf@8.0"

  priority "30"

  def install
    args = %W[
      --with-http
      --with-http-libicu-dir=#{Formula["icu4c"].opt_prefix}
      --with-http-zlib-dir=#{MacOS.sdk_path_if_needed}/usr
    ]
    extra_includes = %W[
      -I#{Formula["shivammathur/extensions/raphf@8.0"].opt_include}/php
    ]
    ENV["EXTRA_INCLUDES"] = extra_includes * " "
    Dir.chdir "pecl_http-#{version}"
    inreplace "src/php_http_api.h", "ext/raphf", "ext/raphf@8.0"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
