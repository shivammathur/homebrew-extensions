# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pecl_http Extension
class PeclHttpAT83 < AbstractPhpExtension
  init
  desc "Pecl_http PHP extension"
  homepage "https://github.com/m6w6/ext-http"
  url "https://pecl.php.net/get/pecl_http-4.2.4.tgz"
  sha256 "fb1e10c2e5edfb011ff8dc2e473cdbd2bbe0127d1279dfce4d98570555ac6ded"
  head "https://github.com/m6w6/ext-http.git", branch: "master"
  license "BSD-2-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_sequoia:  "61d1aef3908fe0b95f1d9ebe9de55d9af76cb876859754bac1e62e2cfbe4d5ff"
    sha256 cellar: :any,                 arm64_sonoma:   "658a89390942c5513d0d7ca4f400049f534693c8fabce6a57f296d16e9c158e2"
    sha256 cellar: :any,                 arm64_ventura:  "26685b78082e07a56c95367bd1174f6a56b17c017bcd728d1315b2ee1c2fd49f"
    sha256 cellar: :any,                 arm64_monterey: "f84caaf0338a091941bee0c8c88fc14c98c6aa40c4e283a44902cdc5da96f2cd"
    sha256 cellar: :any,                 ventura:        "1c8de9c16ed0e19cf85c7bb037d4822c6748e14bab5da1b3778fbbfe52e78bb7"
    sha256 cellar: :any,                 monterey:       "d98d86fea5ed024e5facad97e455bcbd5b6eaa9f37f0f1ac7a5dc7b9c2c769d0"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "798ce887edcb7ef8b937e7e263d45fa83f18a68b21e1635c5ca70192b9b9c7fe"
  end

  depends_on "brotli"
  depends_on "curl"
  depends_on "icu4c"
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
