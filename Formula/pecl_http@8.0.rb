# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pecl_http Extension
class PeclHttpAT80 < AbstractPhpExtension
  init
  desc "Pecl_http PHP extension"
  homepage "https://github.com/m6w6/ext-http"
  url "https://pecl.php.net/get/pecl_http-4.2.1.tgz"
  sha256 "ab07d55ccdfa897c897c26f1c0851b557b363431766c9ea4c799ea61443bdcdc"
  head "https://github.com/m6w6/ext-http.git"
  license "BSD-2-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_big_sur: "dde2073cd73690f3599e1c803c717a9a2265c0abbd3a670e33fd47c6e02e4251"
    sha256 cellar: :any,                 big_sur:       "cda09eb5cc0e38b8fbd1dfcded87e4ad33afa9492661860ca8a48bdb07f0b09f"
    sha256 cellar: :any,                 catalina:      "14141bf82a810f003be7aeee50379d55a2a0a2b7615e1de4f2eb66e1d2564899"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "f8821f09a9108f61bfe67a21b21307e3d31b30480361309a510f0ab188871ce1"
  end

  depends_on "brotli"
  depends_on "curl"
  depends_on "icu4c"
  depends_on "libevent"
  depends_on "libidn2"
  depends_on "shivammathur/extensions/raphf@8.0"

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
