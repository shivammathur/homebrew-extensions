# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pecl_http Extension
class PeclHttpAT82 < AbstractPhpExtension
  init
  desc "Pecl_http PHP extension"
  homepage "https://github.com/m6w6/ext-http"
  url "https://pecl.php.net/get/pecl_http-4.2.6.tgz"
  sha256 "cd33230050b3f7c5ddb6f4383ce2a81f0bcdb934432029eec72ebf0f942b876d"
  revision 1
  head "https://github.com/m6w6/ext-http.git"
  license "BSD-2-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/pecl_http/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "18d7a9ddc3444947c83b4bc20af40b5a0b6bb1ac59308b6134ddf411c2e124e3"
    sha256 cellar: :any,                 arm64_sonoma:  "9829d00a8aea5fee9d930494ff4087f738721897a74b5be73b417584ead0f0f2"
    sha256 cellar: :any,                 arm64_ventura: "fc82b2d4df23d50e74a811dd64512fc1c03f054915c2abc8e343149c10b26575"
    sha256 cellar: :any,                 ventura:       "21b5d9bb4b51eaedbd42151dc326c5777757ce3a55dc26c5b77e4f25cce76956"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "dd6aa96a9b60bedbcfcf9c5730d74134a0700f55053baa123d4f9b700177f3e9"
  end

  depends_on "brotli"
  depends_on "curl"
  depends_on "icu4c@77"
  depends_on "libevent"
  depends_on "libidn2"
  depends_on "shivammathur/extensions/raphf@8.2"
  depends_on "zlib"

  priority "30"

  def install
    args = %W[
      --with-http
      --with-http-libicu-dir=#{Formula["icu4c"].opt_prefix}
      --with-http-zlib-dir=#{Formula["zlib"].opt_prefix}
    ]
    extra_includes = %W[
      -I#{Formula["shivammathur/extensions/raphf@8.2"].opt_include}/php
    ]
    # Work around to support `icu4c` 75, which needs C++17.
    ENV.append "CXX", "-std=c++17"
    ENV.libcxx if ENV.compiler == :clang
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
