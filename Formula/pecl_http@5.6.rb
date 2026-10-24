# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pecl_http Extension
class PeclHttpAT56 < AbstractPhpExtension
  init
  desc "Pecl_http PHP extension"
  homepage "https://github.com/m6w6/ext-http"
  url "https://pecl.php.net/get/pecl_http-2.6.0.tgz"
  sha256 "ddbf3eea3d1c7004a7dd83b5864aee5f87b1b6032bc281c08ccc62f83b9931ed"
  head "https://github.com/m6w6/ext-http.git", branch: "master"
  license "BSD-2-Clause"
  revision 5

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "653ef44ba4fe688c4ae3efe9eca9e2825a076016838fbe208a12069a29f1bc19"
    sha256 cellar: :any, arm64_tahoe:       "c095891648f259017c4bf9187feedca22f4014cab6091e2780b94da0ae52ad1f"
    sha256 cellar: :any, arm64_sequoia:     "058972b3b6b2ea6f4fb952826b7d28dc71bf201bede27fe176b4ea257ad729bd"
    sha256 cellar: :any, arm64_linux:       "2a5fcefcfcbdf96918d873e92df19aac2e56f3a78d1251ca463519a5cc6eebc3"
    sha256 cellar: :any, x86_64_linux:      "b2da2f571ba496676ba8d60215b5a18955b0a0f61b007848b07f90609e54d841"
  end

  depends_on "brotli"
  depends_on "curl"
  depends_on "icu4c@78"
  depends_on "libevent"
  depends_on "libidn2"
  depends_on "shivammathur/extensions/propro@5.6"
  depends_on "shivammathur/extensions/raphf@5.6"
  depends_on "zlib"

  priority "30"

  def install
    ENV.append "CFLAGS", "-Wno-implicit-function-declaration"
    args = %W[
      --with-http
      --with-http-zlib-dir=#{Utils::Path.formula_opt_prefix("zlib")}
    ]
    extra_includes = %W[
      -I#{Utils::Path.formula_opt_include("shivammathur/extensions/propro@5.6")}/php
      -I#{Utils::Path.formula_opt_include("shivammathur/extensions/raphf@5.6")}/php
    ]
    # Work around to support `icu4c` 75, which needs C++17.
    ENV.append "CXX", "-std=c++17"
    ENV.libcxx if ENV.compiler == :clang
    ENV["EXTRA_INCLUDES"] = extra_includes * " "
    Dir.chdir "pecl_http-#{version}"
    inreplace "src/php_http_api.h", "ext/raphf", "ext/raphf@5.6"
    inreplace "src/php_http_api.h", "ext/propro", "ext/propro@5.6"
    inreplace "config9.m4", "/ext/raphf", "/php/ext/raphf@5.6"
    inreplace "config9.m4", "/ext/propro", "/php/ext/propro@5.6"
    inreplace "config9.m4", "$abs_srcdir", "$abs_srcdir ${HOMEBREW_PREFIX}/include"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
