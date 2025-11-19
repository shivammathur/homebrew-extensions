# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pecl_http Extension
class PeclHttpAT82 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_tahoe:   "cadb580dcfe6692e91d70f2aa6b562e3558efb9b1eefe9339c026024f69085b6"
    sha256 cellar: :any,                 arm64_sequoia: "55d66b11d52e17bd3c369a56414520b07b65f66022e5053d2dabbf3a878fdfda"
    sha256 cellar: :any,                 arm64_sonoma:  "54615aea6aee2af50b3d58de157f20c27e99103b9a83ece5dd77e2c51830a857"
    sha256 cellar: :any,                 sonoma:        "53bade25aab1f47cecc72fbd1e261fd02c319f3d2d27b870170f1fceb21af0f4"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "49d275855930d8053a54b046f4ce2b36fa501d4cf0023a063c5e681c342981ca"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "1cd8bb5969152479ca3449d21f9e68c5de53bac3d0ead071294ac52429c77f1a"
  end

  depends_on "brotli"
  depends_on "curl"
  depends_on "icu4c@78"
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
