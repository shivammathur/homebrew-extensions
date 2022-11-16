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
    rebuild 1
    sha256 cellar: :any,                 arm64_monterey: "b2bac55921a9ca62956a40391469c6279a794eed13465fe4f505f0f6c6638b7e"
    sha256 cellar: :any,                 arm64_big_sur:  "9b6f969e8dfe277943075bd128ccaa1d7975307f044c3081647a03dcd74fb3c9"
    sha256 cellar: :any,                 monterey:       "fa6dfb42456728f2ef779ea38ccdbf530366ba7060d9351ef55fdd94bdf09e0f"
    sha256 cellar: :any,                 big_sur:        "3f77aba0f76737fd257525b778e33b8ac96bfdc0743919dcba88cf93e1c15752"
    sha256 cellar: :any,                 catalina:       "ba4b6f82bd53c6147f73fc882c07147f23611fd3c05de26398dbc36436966976"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "d68883e01a32553cf2bbd954c47a138841330e284d89c5102a03c1d3da120acc"
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
