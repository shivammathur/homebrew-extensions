# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pecl_http Extension
class PeclHttpAT81 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_sequoia:  "9084ceaa512ab13b136634d48fc8a581d5bc5c54660be7cbaa07639fabf74770"
    sha256 cellar: :any,                 arm64_sonoma:   "d07e688fd6f73825bee25feb92ef007911da600ce8294d0088db9236b9100009"
    sha256 cellar: :any,                 arm64_ventura:  "2e6c5a88d852faa6056a0c348497c33f1f6cfee5f477b85c1f734969e7a05601"
    sha256 cellar: :any,                 arm64_monterey: "b72d8ec8311e1d0565542e9e961cd235f6d6fc0f21a5fca45867413d357e96fe"
    sha256 cellar: :any,                 ventura:        "caafcb849c4c8c5c193e236e30efabbc99321edb7a67c6fddcebd02fe9238938"
    sha256 cellar: :any,                 monterey:       "0864a2d15157a902aeffede733e8e3d4108e3a93b0d01808733ca0c3dac3c845"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "76ec5348aafbf1fcda686dff2eff0aeac0371f9d8a2229ede26dd96053128144"
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
