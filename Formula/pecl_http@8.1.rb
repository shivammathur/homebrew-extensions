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
    rebuild 3
    sha256                               arm64_big_sur: "2184cce5663001bb95db918c5d003ff36e6724362a36a2d9cce68b588a5be076"
    sha256                               big_sur:       "2bee12bad7aa60a87e5019fef2ddc01323ecb72c813c56f6d500d211802cc6ab"
    sha256                               catalina:      "062c1463972ec9199d1a799c67d3769dad17ca396887ea3aee5bce25d51efb7a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "773ab7fb62dcb61eeefb6dfec31ef9157dddc24fece97d71797b803eeaf1fb46"
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
