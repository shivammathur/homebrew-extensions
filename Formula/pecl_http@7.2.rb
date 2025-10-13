# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pecl_http Extension
class PeclHttpAT72 < AbstractPhpExtension
  init
  desc "Pecl_http PHP extension"
  homepage "https://github.com/m6w6/ext-http"
  url "https://pecl.php.net/get/pecl_http-3.3.0.tgz"
  sha256 "9194524be3997328b6788ef37e37485253e03eadc4bf51abd740358d03d2f536"
  head "https://github.com/m6w6/ext-http.git"
  license "BSD-2-Clause"
  revision 2

  livecheck do
    url "https://pecl.php.net/rest/r/pecl_http/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "1981e23ae1748f341abb183a88f43d20e5ebe3e396c6001e5fd868bfc7e3bbda"
    sha256 cellar: :any,                 arm64_sonoma:  "effb385aad485d0e1d99c040fdb08c6def9f9d72836e3631af2186d863525120"
    sha256 cellar: :any,                 arm64_ventura: "3d7cd79ddf56c5e8dcebbc12ca0377a18ab5ba973643bb0780b91bfb7e37a12a"
    sha256 cellar: :any,                 sonoma:        "61e58112635cb21da06d39ec8a7c5b16b01ecdbbc37ae872a1dc51b3aba296d6"
    sha256 cellar: :any,                 ventura:       "fc11dea0b4c55753428d7b1c997a6f95a258e57e57a5943e7982562440248399"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "0525c01cdba7c2d6cc3e0943b99b4e1723fc10d01c474790c127aae7929eb697"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "335a6e7b5037598aaa31efea675fb2822e714f541e75438b849d99d27c375090"
  end

  depends_on "brotli"
  depends_on "curl"
  depends_on "icu4c@77"
  depends_on "libevent"
  depends_on "libidn2"
  depends_on "shivammathur/extensions/propro@7.2"
  depends_on "shivammathur/extensions/raphf@7.2"
  depends_on "zlib"

  priority "30"

  def install
    args = %W[
      --with-http
      --with-http-libicu-dir=#{Formula["icu4c"].opt_prefix}
      --with-http-zlib-dir=#{Formula["zlib"].opt_prefix}
    ]
    extra_includes = %W[
      -I#{Formula["shivammathur/extensions/propro@7.2"].opt_include}/php
      -I#{Formula["shivammathur/extensions/raphf@7.2"].opt_include}/php
    ]
    # Work around to support `icu4c` 75, which needs C++17.
    ENV.append "CXX", "-std=c++17"
    ENV.libcxx if ENV.compiler == :clang
    ENV["EXTRA_INCLUDES"] = extra_includes * " "
    Dir.chdir "pecl_http-#{version}"
    inreplace "src/php_http_api.h", "ext/raphf", "ext/raphf@7.2"
    inreplace "src/php_http_api.h", "ext/propro", "ext/propro@7.2"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
