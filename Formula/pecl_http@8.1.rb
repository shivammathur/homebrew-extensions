# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pecl_http Extension
class PeclHttpAT81 < AbstractPhpExtension
  init
  desc "Pecl_http PHP extension"
  homepage "https://github.com/m6w6/ext-http"
  url "https://pecl.php.net/get/pecl_http-4.3.1.tgz"
  sha256 "1512dc02fea2356c4df50113e00943b0b7fc99bb22d34d9f624b4662f1dad263"
  revision 1
  head "https://github.com/m6w6/ext-http.git", branch: "master"
  license "BSD-2-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/pecl_http/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "27de6b241896961f410721a073beda13b573a84162574cb4f6510bdb91ea5a88"
    sha256 cellar: :any,                 arm64_sequoia: "4a5a8f840031e9d5f366767a1e93f2e50d2e89f0e29b45f1d4e5e89b24d576f0"
    sha256 cellar: :any,                 arm64_sonoma:  "c9760357e3c88e3fca8638c4a9abf7f0b8bf5b81d9685ad8c6c266f12faf9929"
    sha256 cellar: :any,                 sonoma:        "0af3da620a6f6b61db6232967154f62013d93571c970dbd399c46a589c7d5dce"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "9472705c4c1c206cc5d40fe11ee7156c75f5f1e59525f8550275d2fbd8b99bb4"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "25e8b94c6f4f6570f0be440a10944e3b38154f1ecb739a95cbe7426a3e7a89fa"
  end

  depends_on "brotli"
  depends_on "curl"
  depends_on "icu4c@78"
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
