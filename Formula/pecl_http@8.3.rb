# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pecl_http Extension
class PeclHttpAT83 < AbstractPhpExtension
  init
  desc "Pecl_http PHP extension"
  homepage "https://github.com/m6w6/ext-http"
  url "https://pecl.php.net/get/pecl_http-4.2.3.tgz"
  sha256 "fa2ab558fc8f0928a10f35c0f566f7c4a1d32e727bd3a96579e4c28482ee9d6a"
  head "https://github.com/m6w6/ext-http.git", branch: "master"
  license "BSD-2-Clause"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 5
    sha256 cellar: :any,                 arm64_ventura:  "6e603826cba0bcb2528fd9cb80465291710fcb9e496601aa7bc4a757fca7e488"
    sha256 cellar: :any,                 arm64_monterey: "74f226254ef381d3aaefdb25a68b37cd1fb71d09525decdf619d109bbd4dfdba"
    sha256 cellar: :any,                 arm64_big_sur:  "e5dcf0844da4ce79ec9159625cf27975ea0320729dd76bc6a403d3f1d9551c08"
    sha256 cellar: :any,                 ventura:        "b9d34310e630a7a11e0e0f437d60ac53137257ef70f38b350d8897cbcceda932"
    sha256 cellar: :any,                 monterey:       "d4ad1e43f309f9d7f8bbd1feefd843194e4c6ea6d34aa1fc7b1e2453395963a4"
    sha256 cellar: :any,                 big_sur:        "e419e8c5546cdfcc51b69ec20b8ad859b445d4bd66bda35fbbf3d3cbd4bba876"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "a97ddb0e07761129c8c4c52f3e0b922123f7415e258c6e510797ec3184fb6d54"
  end

  depends_on "brotli"
  depends_on "curl"
  depends_on "icu4c"
  depends_on "libevent"
  depends_on "libidn2"
  depends_on "shivammathur/extensions/raphf@8.3"

  priority "30"

  def install
    args = %W[
      --with-http
      --with-http-libicu-dir=#{Formula["icu4c"].opt_prefix}
      --with-http-zlib-dir=#{MacOS.sdk_path_if_needed}/usr
    ]
    extra_includes = %W[
      -I#{Formula["shivammathur/extensions/raphf@8.3"].opt_include}/php
    ]
    ENV["EXTRA_INCLUDES"] = extra_includes * " "
    Dir.chdir "pecl_http-#{version}"
    inreplace "src/php_http_api.h", "ext/raphf", "ext/raphf@8.3"
    patch_spl_symbols
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
