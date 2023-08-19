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
    rebuild 4
    sha256 cellar: :any,                 arm64_monterey: "722d47533f6a4aa4dee0449f34131b8ac663ad33446904ff2a691dc98e6b4f9f"
    sha256 cellar: :any,                 arm64_big_sur:  "9b01b387f9ae90d84eacfaa2e276b74e75f190704edcd16de3b999059060c39c"
    sha256 cellar: :any,                 ventura:        "bd91cd6193b9283ec1d4ec04178d72e2407bdb833e7f4b3d63c0d35f2bb412e1"
    sha256 cellar: :any,                 monterey:       "4156ac94ee0273499776709b3995fbaeee37f09a722e9e656a6ed7ec84e1b6e5"
    sha256 cellar: :any,                 big_sur:        "1378854116e42cafa86ccc6989c77ddfc704fa5ccd5b9f5189d91b988f26350c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "1066696e4735ebea48ab880c50b79da0cf3fa54f3d0552a54ad80c7370408748"
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
