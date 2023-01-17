# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pecl_http Extension
class PeclHttpAT82 < AbstractPhpExtension
  init
  desc "Pecl_http PHP extension"
  homepage "https://github.com/m6w6/ext-http"
  url "https://pecl.php.net/get/pecl_http-4.2.3.tgz"
  sha256 "fa2ab558fc8f0928a10f35c0f566f7c4a1d32e727bd3a96579e4c28482ee9d6a"
  head "https://github.com/m6w6/ext-http.git"
  license "BSD-2-Clause"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any,                 arm64_monterey: "e45c086fab047d3da293bd630f617be9dd4a5d8f18ae6345f0d38560a8a1d0fc"
    sha256 cellar: :any,                 arm64_big_sur:  "e7890c40b502cf441d4cbbd6cb2a74f11829ea2d49b86e1877385726920984ae"
    sha256 cellar: :any,                 monterey:       "f99a8a24d5c01954ea69d3f3e515e93a5b2ecb3d7aa0cb7bf0e84b974ad33349"
    sha256 cellar: :any,                 big_sur:        "86b7eb188ace6f6810b57e9db5cbaa92be505c9fb1b5d6004441bd37f6b44502"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "b4c65ee997eadf26e5642dcd6aea93ca106e4704e67550bd9fc75de4a811858c"
  end

  depends_on "brotli"
  depends_on "curl"
  depends_on "icu4c"
  depends_on "libevent"
  depends_on "libidn2"
  depends_on "shivammathur/extensions/raphf@8.2"

  priority "30"

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
    Dir.chdir "pecl_http-#{version}"
    inreplace "src/php_http_api.h", "ext/raphf", "ext/raphf@8.2"
    patch_spl_symbols
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
