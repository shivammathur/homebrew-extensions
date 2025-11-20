# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pecl_http Extension
class PeclHttpAT80 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_tahoe:   "3bb68f46774106829ec6232223e6e271cb6dc21b5439b5815a67812fe8cfe7e6"
    sha256 cellar: :any,                 arm64_sequoia: "b58ddd81d6d68f63ada3d65dfc33107ca1dcae78cc27ebc7a2e753c98e82f2e0"
    sha256 cellar: :any,                 arm64_sonoma:  "ff697d1c9631657aca5ee7a55aa318041e16f9a836242c01b63f79d12842ab97"
    sha256 cellar: :any,                 sonoma:        "83bf4ebd5c726c111f7110d3639b8b98ae0cafa6f07259ea1119f97d594633f9"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "f756354820e4c2229c1f944464cff591b47be73f2c0cd4520d450d9fc900111b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "a2353cce640a75fe0f6a2cd4386eb9851f4f9789881f309357247fcb965f2585"
  end

  depends_on "brotli"
  depends_on "curl"
  depends_on "icu4c@78"
  depends_on "libevent"
  depends_on "libidn2"
  depends_on "shivammathur/extensions/raphf@8.0"
  depends_on "zlib"

  priority "30"

  def install
    args = %W[
      --with-http
      --with-http-libicu-dir=#{Formula["icu4c"].opt_prefix}
      --with-http-zlib-dir=#{Formula["zlib"].opt_prefix}
    ]
    extra_includes = %W[
      -I#{Formula["shivammathur/extensions/raphf@8.0"].opt_include}/php
    ]
    # Work around to support `icu4c` 75, which needs C++17.
    ENV.append "CXX", "-std=c++17"
    ENV.libcxx if ENV.compiler == :clang
    ENV["EXTRA_INCLUDES"] = extra_includes * " "
    Dir.chdir "pecl_http-#{version}"
    inreplace "src/php_http_api.h", "ext/raphf", "ext/raphf@8.0"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
