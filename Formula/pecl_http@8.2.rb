# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pecl_http Extension
class PeclHttpAT82 < AbstractPhpExtension
  init
  desc "Pecl_http PHP extension"
  homepage "https://github.com/m6w6/ext-http"
  url "https://github.com/m6w6/ext-http/archive/efddbd955ca4706f06c461692a561d7d9431adb9.tar.gz"
  sha256 "6f6add7287c4397e92cb8432ef6ed1f680ac39aa1e5caf0cd703987b67056ad6"
  version "4.2.1"
  head "https://github.com/m6w6/ext-http.git"
  license "BSD-2-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_big_sur: "d41c29f4e170a7ee7fc5c75239b7d3913102db4f1a43e2359b2ee6d9c459a3bc"
    sha256 cellar: :any,                 big_sur:       "c2e30c9727da9fafaf8a6248f8359262b3517bdf2e15fd4af7dfa87030df96e2"
    sha256 cellar: :any,                 catalina:      "9497f69667c98110416342d5c9fa9f63dbed134ddc86fc8f69c1f779eb571b36"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "2323e55e559b9d1ccd04c6670fb63c3e12789c7323b28b1a90214a58410a3a24"
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
