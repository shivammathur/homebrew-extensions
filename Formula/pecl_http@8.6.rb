# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pecl_http Extension
class PeclHttpAT86 < AbstractPhpExtension
  init
  desc "Pecl_http PHP extension"
  homepage "https://github.com/m6w6/ext-http"
  url "https://pecl.php.net/get/pecl_http-4.3.1.tgz"
  sha256 "1512dc02fea2356c4df50113e00943b0b7fc99bb22d34d9f624b4662f1dad263"
  head "https://github.com/m6w6/ext-http.git", branch: "master"
  license "BSD-2-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/pecl_http/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "25e24b82e560100d4de90388a1f3240d7126faf366c2a762e77c5a60d8b4091a"
    sha256 cellar: :any,                 arm64_sequoia: "9b6162b5f9f667f3805a46d3726e53d11c7e18f30b565f3123cd068d486aa032"
    sha256 cellar: :any,                 arm64_sonoma:  "8d75d87b1b517f2a059fc79470f9bbd479f8cb8913e2653dd49c8bc92b2beb60"
    sha256 cellar: :any,                 sonoma:        "3404760682a134de5bd2aa8654e4e2bb835b5415b503c4a4d75e94022d5f6808"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "6e87e3fa53a4641d2a4bcf6963670b08e97667b0e80385ab9e7b0f59be282019"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "d710fd5a7aa6ba0785b5b10b7e89cc232bc4ee67828be330f42627f889cb4323"
  end

  depends_on "brotli"
  depends_on "curl"
  depends_on "icu4c@77"
  depends_on "libevent"
  depends_on "libidn2"
  depends_on "shivammathur/extensions/raphf@8.6"
  depends_on "zlib"

  priority "30"

  def install
    args = %W[
      --with-http
      --with-http-libicu-dir=#{Formula["icu4c"].opt_prefix}
      --with-http-zlib-dir=#{Formula["zlib"].opt_prefix}
    ]
    extra_includes = %W[
      -I#{Formula["shivammathur/extensions/raphf@8.6"].opt_include}/php
    ]
    # Work around to support `icu4c` 75, which needs C++17.
    ENV.append "CXX", "-std=c++17"
    ENV.libcxx if ENV.compiler == :clang
    ENV["EXTRA_INCLUDES"] = extra_includes * " "
    Dir.chdir "pecl_http-#{version}"
    inreplace "src/php_http_api.h", "ext/raphf", "ext/raphf@8.6"
    inreplace "src/php_http_message_body.c", "standard/php_lcg.h", "random/php_random.h"
    inreplace "src/php_http_misc.c", "standard/php_lcg.h", "random/php_random.h"
    patch_spl_symbols
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
