# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pecl_http Extension
class PeclHttpAT81 < AbstractPhpExtension
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
    rebuild 4
    sha256 cellar: :any,                 arm64_big_sur: "5436a9694daa6fb7a6d1bd4029dafea270800935a0bfd81cf2e2282c0c81bde0"
    sha256 cellar: :any,                 big_sur:       "08059b08c8c3640c40a9dc87632b2fb6f65b2d3606221f963905c94b43e9917c"
    sha256 cellar: :any,                 catalina:      "0bdbb4a29eeee346c2b1b18bfe799dbb7db60a0113ab61ca37131c5cafce42fe"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "40d55f51ed6d259ea8c5e92ed8b0512ec85dc3e0594528595ae3037abd178144"
  end

  depends_on "brotli"
  depends_on "curl"
  depends_on "icu4c"
  depends_on "libevent"
  depends_on "libidn2"
  depends_on "shivammathur/extensions/raphf@8.1"

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
    inreplace "src/php_http_api.h", "ext/raphf", "ext/raphf@8.1"
    patch_spl_symbols
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
