# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pecl_http Extension
class PeclHttpAT82 < AbstractPhpExtension
  init
  desc "Pecl_http PHP extension"
  homepage "https://github.com/m6w6/ext-http"
  url "https://github.com/m6w6/ext-http/archive/b9e1564632b6d00d1120ee7c73574759af9e6167.tar.gz"
  sha256 "f0a8c55e9c3ba672173dee49bfef6b5ef873776b1e698b1507d58902bb7da760"
  version "4.1.0"
  head "https://github.com/m6w6/ext-http.git"
  license "BSD-2-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_big_sur: "80ea80b1ade7e30b2e378f9aca83238c8ece1c15266181922e714dc73a063ac7"
    sha256 cellar: :any,                 big_sur:       "66e2e7dfa8d0848c5d9f00e1d7666e40368d66512b3435ecf447417bd7b16f15"
    sha256 cellar: :any,                 catalina:      "00da058cef831bb0dee2d358fe391a395991ae9c5ec3c887d6e380a5e07d5a7d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "bdb87b147f716f7a815c1ac2edf6c3a83267b61c315d45d5fccb832e3bd468dc"
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
