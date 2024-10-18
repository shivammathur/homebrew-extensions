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
    rebuild 1
    sha256 cellar: :any,                 arm64_sequoia:  "77c6136e87bf82102d2bed4eb8797c8dc15052ee05df21cecf1af0dcdd6b6a9c"
    sha256 cellar: :any,                 arm64_sonoma:   "877cba85c964cab53d9990bc2985a11e182f1dc68c78c47e06b71a1f50083158"
    sha256 cellar: :any,                 arm64_ventura:  "358f12d0658e565e6a9ded276797044b0dbc22646621fe181bde25ec3dd39e14"
    sha256 cellar: :any,                 arm64_monterey: "e424ee91bf59d3618b6f6be58a15df5347202e8c62ba8022822097602693b3b8"
    sha256 cellar: :any,                 ventura:        "d2e23f90339641bf90fb7595d2aae0cd937a64eae2bbb78c21b145b8eaa10479"
    sha256 cellar: :any,                 monterey:       "4c17f3785bc863f72b2abf665a142b671daa9f8ea50f49a5567476c9998a8e63"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "90b6f7cb92e00e74886e2d71fa9eebf89d5cd4b4e72a28dd0f760ea4987679e8"
  end

  depends_on "brotli"
  depends_on "curl"
  depends_on "icu4c"
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
