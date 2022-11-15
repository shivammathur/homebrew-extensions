# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pecl_http Extension
class PeclHttpAT81 < AbstractPhpExtension
  init
  desc "Pecl_http PHP extension"
  homepage "https://github.com/m6w6/ext-http"
  url "https://pecl.php.net/get/pecl_http-4.2.3.tgz"
  sha256 "fa2ab558fc8f0928a10f35c0f566f7c4a1d32e727bd3a96579e4c28482ee9d6a"
  head "https://github.com/m6w6/ext-http.git"
  license "BSD-2-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any,                 arm64_monterey: "0f636e9895a9cb7c9c2defdcd1bdb0749c09abbf7808ea14e49122a561be09e5"
    sha256 cellar: :any,                 arm64_big_sur:  "8cdacfeafd94db0e455bcc28728fbe7e25562195c377f645d73c8e63bcffd282"
    sha256 cellar: :any,                 monterey:       "3d2805a1ce9e722c37b190abaecce01dcd7b5e8290e5df29d6dab38b4e5dbfce"
    sha256 cellar: :any,                 big_sur:        "384640bd9e06a16de6bb758ce026ee69a137de072a00a7028a86d61e4fb7c007"
    sha256 cellar: :any,                 catalina:       "c6e909bf73b63461780f77445e0366b1e31281914617b3d5dc4129c0e5126e57"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "3f14a0676fd59e7740ae9774dfd20aa38eb56462ad89346c70a710152a880c64"
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
