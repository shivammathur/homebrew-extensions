# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pecl_http Extension
class PeclHttpAT81 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_monterey: "d80d992afacffc37bdeaff32eea454ae1fd7295c5bd020c25ded221cd6f197ff"
    sha256 cellar: :any,                 arm64_big_sur:  "2f7f96e317278760432b29d2b797f5707968e7850c52b9db5c0c5f46400b7f1d"
    sha256 cellar: :any,                 monterey:       "7c2b05ab14876d92cad488b75add997309981c8f4daccb3dcd692b663f35dac7"
    sha256 cellar: :any,                 big_sur:        "21d51159b9bc2907682cbedb115cc50d0d5470453f4e00685e5cea099d5bdab2"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "fcb8cd7fd4d0b028b59a92bafec92dacb213892876b877c86e8ba4bc62df8a9f"
  end

  depends_on "brotli"
  depends_on "curl"
  depends_on "icu4c"
  depends_on "libevent"
  depends_on "libidn2"
  depends_on "shivammathur/extensions/raphf@8.1"

  priority "30"

  def install
    args = %W[
      --with-http
      --with-http-libicu-dir=#{Formula["icu4c"].opt_prefix}
      --with-http-zlib-dir=#{MacOS.sdk_path_if_needed}/usr
    ]
    extra_includes = %W[
      -I#{Formula["shivammathur/extensions/raphf@8.1"].opt_include}/php
    ]
    ENV["EXTRA_INCLUDES"] = extra_includes * " "
    Dir.chdir "pecl_http-#{version}"
    inreplace "src/php_http_api.h", "ext/raphf", "ext/raphf@8.1"
    patch_spl_symbols
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
