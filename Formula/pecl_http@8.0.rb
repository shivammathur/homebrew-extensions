# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pecl_http Extension
class PeclHttpAT80 < AbstractPhpExtension
  init
  desc "Pecl_http PHP extension"
  homepage "https://github.com/m6w6/ext-http"
  url "https://pecl.php.net/get/pecl_http-4.2.4.tgz"
  sha256 "fb1e10c2e5edfb011ff8dc2e473cdbd2bbe0127d1279dfce4d98570555ac6ded"
  head "https://github.com/m6w6/ext-http.git"
  license "BSD-2-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any,                 arm64_sequoia: "b13785e8ff0a9b035d0a0c30af38e2185fe101b235fc8fcc82073ff640aa4a10"
    sha256 cellar: :any,                 arm64_sonoma:  "8fcc220edb734a41a761768df06e0d197c1b0a31dbe17711bcdf842b4fa27624"
    sha256 cellar: :any,                 arm64_ventura: "281c6a6de1b9145b7d0eadbd84e3e10c3f9f03226a54359964845731c592f67c"
    sha256 cellar: :any,                 ventura:       "c8fc5aa042844a1ccaeb06017cebef4d8cd6d153a1a6d3555373c30433f8afa0"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b7749296cd196fbeb23376d0a2f4cc9c10439b9332ec07d8ded081012b6df04f"
  end

  depends_on "brotli"
  depends_on "curl"
  depends_on "icu4c@75"
  depends_on "libevent"
  depends_on "libidn2"
  depends_on "shivammathur/extensions/raphf@8.0"
  depends_on "zlib"

  priority "30"

  def install
    args = %W[
      --with-http
      --with-http-libicu-dir=#{Formula["icu4c"].opt_prefix}
      --with-http-zlib-dir=#{Formula["zlib"].opt_prefix}
    ]
    extra_includes = %W[
      -I#{Formula["shivammathur/extensions/raphf@8.0"].opt_include}/php
    ]
    # Work around to support `icu4c` 75, which needs C++17.
    ENV.append "CXX", "-std=c++17"
    ENV.libcxx if ENV.compiler == :clang
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
