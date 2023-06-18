# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pecl_http Extension
class PeclHttpAT83 < AbstractPhpExtension
  init
  desc "Pecl_http PHP extension"
  homepage "https://github.com/m6w6/ext-http"
  url "https://pecl.php.net/get/pecl_http-4.2.3.tgz"
  sha256 "fa2ab558fc8f0928a10f35c0f566f7c4a1d32e727bd3a96579e4c28482ee9d6a"
  head "https://github.com/m6w6/ext-http.git", branch: "master"
  license "BSD-2-Clause"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 3
    sha256 cellar: :any,                 arm64_monterey: "d87b4f44d6c57b76c37066cc2dd1b668bb3ad9fc5a12408c8f7aa213a7b7b57b"
    sha256 cellar: :any,                 arm64_big_sur:  "4e0fecdae351e5c8e9e1dea1bb480b01f34dc3fb2cbd4834aa342d8ae10f2c0b"
    sha256 cellar: :any,                 ventura:        "e4c509056e9ff695f52bffbcc1692c424252d2c920ba108319ae2e2e62eda715"
    sha256 cellar: :any,                 monterey:       "e3c4a3681c2fcae31d65054b13aa8f077b761a898454fc33fc6e15c37a91663c"
    sha256 cellar: :any,                 big_sur:        "c4ff2c1c1c8c223fe78c6d9c354e48754b16b8cdbac5d5e0249a5c5cae5ac9f7"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "0366b717747187abb62e6c3282b67e14c3e51ab2b650976a9c77e482bdf10979"
  end

  depends_on "brotli"
  depends_on "curl"
  depends_on "icu4c"
  depends_on "libevent"
  depends_on "libidn2"
  depends_on "shivammathur/extensions/raphf@8.3"

  priority "30"

  def install
    args = %W[
      --with-http
      --with-http-libicu-dir=#{Formula["icu4c"].opt_prefix}
      --with-http-zlib-dir=#{MacOS.sdk_path_if_needed}/usr
    ]
    extra_includes = %W[
      -I#{Formula["shivammathur/extensions/raphf@8.3"].opt_include}/php
    ]
    ENV["EXTRA_INCLUDES"] = extra_includes * " "
    Dir.chdir "pecl_http-#{version}"
    inreplace "src/php_http_api.h", "ext/raphf", "ext/raphf@8.3"
    patch_spl_symbols
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
