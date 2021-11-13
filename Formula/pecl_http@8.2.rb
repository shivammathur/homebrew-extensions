# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pecl_http Extension
class PeclHttpAT82 < AbstractPhpExtension
  init
  desc "Pecl_http PHP extension"
  homepage "https://github.com/m6w6/ext-http"
  url "https://github.com/m6w6/ext-http/archive/acd765555fa5ae6444093fba17783af05ae09cd0.tar.gz"
  sha256 "2395f1f2ca22d3ef5e98fd3cef4e4335f032e32a754ea6e9e8bbafc61a4ba72c"
  version "4.2.1"
  head "https://github.com/m6w6/ext-http.git"
  license "BSD-2-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_big_sur: "7a7ff609b1eb8b276cd7566333e41c5a71c776810412aab9051027eb57444094"
    sha256 cellar: :any,                 big_sur:       "46a0dfce1fc26d0c32f67f58af04f00a9e981a4d37e5ccfd75a684f3ac46af3e"
    sha256 cellar: :any,                 catalina:      "4b047e27ac8f2dd89b27b59637732fe53f91ac0088210172562d40643e84fc8b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "658bbeecd56cd0e3a8579c9aa457850198951f9b59e0c1c585a54f4aacb866a5"
  end

  depends_on "brotli"
  depends_on "curl"
  depends_on "icu4c"
  depends_on "libevent"
  depends_on "libidn2"
  depends_on "shivammathur/extensions/raphf@8.2"

  def install
    args = %W[
      --with-http
      --with-http-libicu-dir=#{Formula["icu4c"].opt_prefix}
      --with-http-zlib-dir=#{MacOS.sdk_path_if_needed}/usr
    ]
    extra_includes = %W[
      -I#{Formula["shivammathur/extensions/raphf@8.2"].opt_include}/php
    ]
    ENV["EXTRA_INCLUDES"] = extra_includes * " "
    inreplace "src/php_http_api.h", "ext/raphf", "ext/raphf@8.2"
    patch_spl_symbols
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
