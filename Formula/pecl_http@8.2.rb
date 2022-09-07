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

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any,                 arm64_monterey: "0eef4b36e977bf63fe1f1c9452ba7ba51efa82adab3f889d3e6dcb92de7b38f0"
    sha256 cellar: :any,                 arm64_big_sur:  "0b15949123ca51f79194be17793b93847c2730656992f244294600702cf6291d"
    sha256 cellar: :any,                 monterey:       "56e26b041fab0ce82d64136c9d1f679521b2f6b84bff8195c3ead626da0a8059"
    sha256 cellar: :any,                 big_sur:        "118ebe2e5b9e3019b5e94a01bc74e7872d87f22387093b2c16d19fb585bbeca8"
    sha256 cellar: :any,                 catalina:       "3736c8a8a96e8f038b4cdebfa26db346985fe89b021c5d0a3b78bdfd1cd277ba"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "902a4e3ce158a034bdeeaaafd3ba52e20a10cadab0518c35973e5e6601b5a18b"
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
