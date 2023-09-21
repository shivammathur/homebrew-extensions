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
    rebuild 3
    sha256 cellar: :any,                 arm64_ventura:  "0a1e6c30389ba60e24944187b423fcddaf31ee5cf24e9e558c6433e792bd6e1d"
    sha256 cellar: :any,                 arm64_monterey: "11037232648ae7cac3a161a7e7d71e2dbdf6f1ca0c65892eaedb3423453410ec"
    sha256 cellar: :any,                 arm64_big_sur:  "a2bebce5bd70aa7c242a832f0f896efdd343d04fba6a02cf01cfdda6659553f2"
    sha256 cellar: :any,                 ventura:        "661e530f8c3e13be43df8bed099adfa6dea4a9f344ea04da6a0a7462668bf81c"
    sha256 cellar: :any,                 monterey:       "0998429e0868be0efbf17aec2adba0104b7adb3fa25a976f16200b323bbb162c"
    sha256 cellar: :any,                 big_sur:        "f404de408aff37d6f1ad27a4a662b7049be159245f4d5688d63cc4690c68026b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "3105165aaccb7b5e660ab1ec335d18b893ff6e244e4eced07d6eccc70e4e3652"
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
