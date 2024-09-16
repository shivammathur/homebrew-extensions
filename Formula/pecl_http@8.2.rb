# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pecl_http Extension
class PeclHttpAT82 < AbstractPhpExtension
  init
  desc "Pecl_http PHP extension"
  homepage "https://github.com/m6w6/ext-http"
  url "https://pecl.php.net/get/pecl_http-4.2.4.tgz"
  sha256 "fb1e10c2e5edfb011ff8dc2e473cdbd2bbe0127d1279dfce4d98570555ac6ded"
  head "https://github.com/m6w6/ext-http.git"
  license "BSD-2-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_sequoia:  "ef5244d6b6ac3e580aa6c2dd0e3bde098ab0ee45fb99a70e026fc9e370273716"
    sha256 cellar: :any,                 arm64_sonoma:   "0e2e2b09b5d671ceb667a2cced0d04540d435c366143ae9a5382776b3bbff032"
    sha256 cellar: :any,                 arm64_ventura:  "ab94e5f2145def9e573b0ccf52d6612ddff8b1c4413ec5843156bc2869027ec9"
    sha256 cellar: :any,                 arm64_monterey: "62f4cf763d7bc30267c6bb183a47810ace8caca91d3535371c6443bdfb6083d0"
    sha256 cellar: :any,                 ventura:        "0c985edbe4d461358a03671f80ab183daf15276c17534a155d9862501e71bead"
    sha256 cellar: :any,                 monterey:       "f684539e63b7fda15d2d0250922e73674ab12f138f278da087b98ca89cb09e57"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "05daf4f3025450612f8a1480fbc3edf4d0446c1bbb0f0b34d73e68b171ce5f96"
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
