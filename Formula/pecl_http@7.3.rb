# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pecl_http Extension
class PeclHttpAT73 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_sequoia: "a0853c0e70952ba9e2071b04a5f4a1f1d390429ba807e643409ee2ab607fcf3c"
    sha256 cellar: :any,                 arm64_sonoma:  "5a2aba83831601dfa5681a15ddbc4c5fedd407aaa97e693982f82829cfcbc9ff"
    sha256 cellar: :any,                 arm64_ventura: "2d67fefd43509601e92eb79dda8a1768e7bd72f6de9c98e1ef71137d0f9198b8"
    sha256 cellar: :any,                 ventura:       "3aac678906d725a9f715b16f8ed87fb391079e70d449d45c70a80a9e64148d2f"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "3e56af7ed4fa835af0d2fa640675f46820538b99da05f43cc20ea08b7b80d57f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "18cc2a90e2639ed83f111f939a4e4c9db8a8d65d9513cd6710256d57d7297a84"
  end

  depends_on "brotli"
  depends_on "curl"
  depends_on "icu4c@77"
  depends_on "libevent"
  depends_on "libidn2"
  depends_on "shivammathur/extensions/propro@7.3"
  depends_on "shivammathur/extensions/raphf@7.3"
  depends_on "zlib"

  priority "30"

  def install
    args = %W[
      --with-http
      --with-http-libicu-dir=#{Formula["icu4c"].opt_prefix}
      --with-http-zlib-dir=#{Formula["zlib"].opt_prefix}
    ]
    extra_includes = %W[
      -I#{Formula["shivammathur/extensions/propro@7.3"].opt_include}/php
      -I#{Formula["shivammathur/extensions/raphf@7.3"].opt_include}/php
    ]
    # Work around to support `icu4c` 75, which needs C++17.
    ENV.append "CXX", "-std=c++17"
    ENV.libcxx if ENV.compiler == :clang
    ENV["EXTRA_INCLUDES"] = extra_includes * " "
    Dir.chdir "pecl_http-#{version}"
    inreplace "src/php_http_api.h", "ext/raphf", "ext/raphf@7.3"
    inreplace "src/php_http_api.h", "ext/propro", "ext/propro@7.3"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
