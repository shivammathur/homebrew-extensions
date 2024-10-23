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
    rebuild 2
    sha256 cellar: :any,                 arm64_sequoia: "570ed14a401c73825c49ad71660a6af76dff340ba6a01b431206b5f47fd90fdd"
    sha256 cellar: :any,                 arm64_sonoma:  "f9f9b86190142fd8fb24a6637d104b0e7dce49da44e4a88c2e2da90f1417d18e"
    sha256 cellar: :any,                 arm64_ventura: "8d504e8fa54bce1b4863bd03bf3df42ea87088e4c797df53bd411b974520e9e7"
    sha256 cellar: :any,                 ventura:       "3dffe6566fd2664e5f114e8e79d56164a9cff0ba9870818db0afe7c0a54b54bb"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "d7e5fb91696eaf2b9534df47bc6a15fbc2b2c31fca326d084c8a7af4c3f58db0"
  end

  depends_on "brotli"
  depends_on "curl"
  depends_on "icu4c@75"
  depends_on "libevent"
  depends_on "libidn2"
  depends_on "shivammathur/extensions/raphf@8.1"
  depends_on "zlib"

  priority "30"

  def install
    args = %W[
      --with-http
      --with-http-libicu-dir=#{Formula["icu4c"].opt_prefix}
      --with-http-zlib-dir=#{Formula["zlib"].opt_prefix}
    ]
    extra_includes = %W[
      -I#{Formula["shivammathur/extensions/raphf@8.1"].opt_include}/php
    ]
    # Work around to support `icu4c` 75, which needs C++17.
    ENV.append "CXX", "-std=c++17"
    ENV.libcxx if ENV.compiler == :clang
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
