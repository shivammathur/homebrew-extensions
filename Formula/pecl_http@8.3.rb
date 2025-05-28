# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pecl_http Extension
class PeclHttpAT83 < AbstractPhpExtension
  init
  desc "Pecl_http PHP extension"
  homepage "https://github.com/m6w6/ext-http"
  url "https://pecl.php.net/get/pecl_http-4.2.6.tgz"
  sha256 "cd33230050b3f7c5ddb6f4383ce2a81f0bcdb934432029eec72ebf0f942b876d"
  revision 1
  head "https://github.com/m6w6/ext-http.git", branch: "master"
  license "BSD-2-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/pecl_http/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "0d96d4c840e6812895b95716a6f2bf60f04994d72ad5a8bbb5b80e3331388c71"
    sha256 cellar: :any,                 arm64_sonoma:  "9716935fca7c47ac39560aa26e9534df79286da275ae27dc877d058b43da1e3d"
    sha256 cellar: :any,                 arm64_ventura: "1a6b87a2c157dba0119c4d58c74ec854cba64be8eac0dc6a27f6bbcee62aea1c"
    sha256 cellar: :any,                 ventura:       "50455908dbbf95ff3fc9270b6725dac9217e14f094e876ec907162b585147276"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "a10effa509f194175c4e7b019e94b4ef4163951c713a7769839c2a29d661b66b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "7ff2bfe863784aa0a893359084b0c156b639d312fa3afdb597e6c82308f6f27b"
  end

  depends_on "brotli"
  depends_on "curl"
  depends_on "icu4c@77"
  depends_on "libevent"
  depends_on "libidn2"
  depends_on "shivammathur/extensions/raphf@8.3"
  depends_on "zlib"

  priority "30"

  def install
    args = %W[
      --with-http
      --with-http-libicu-dir=#{Formula["icu4c"].opt_prefix}
      --with-http-zlib-dir=#{Formula["zlib"].opt_prefix}
    ]
    extra_includes = %W[
      -I#{Formula["shivammathur/extensions/raphf@8.3"].opt_include}/php
    ]
    # Work around to support `icu4c` 75, which needs C++17.
    ENV.append "CXX", "-std=c++17"
    ENV.libcxx if ENV.compiler == :clang
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
