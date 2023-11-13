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
    sha256 cellar: :any,                 arm64_sonoma:   "301394da9d146e06ff3fd6d4ada8cd8b83b03859989db2c903178e48a993f96e"
    sha256 cellar: :any,                 arm64_ventura:  "1df582eb0ad22fa5dce2781e1f01a74b1f36f463056fd2abeb6f6a09bcf6017d"
    sha256 cellar: :any,                 arm64_monterey: "e7a318c699ff3b2dc50f3cdaabd4ab1d7efd24e0838f984d9bd8963c0c3e65b4"
    sha256 cellar: :any,                 ventura:        "43a9e19dbcfcc601058be36ab37e737cfe85b68158d99644822f635520e188e4"
    sha256 cellar: :any,                 monterey:       "349f2d683d53635b581c248df1878c458f1fd35308346f54e09fc44ddf4b97cc"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "0bd13c74695e1cf9e080549b2ee921a2279d222479ed557c4b925782f3def853"
  end

  depends_on "brotli"
  depends_on "curl"
  depends_on "icu4c"
  depends_on "libevent"
  depends_on "libidn2"
  depends_on "shivammathur/extensions/raphf@8.3"

  priority "30"

  def install
    args = %W[
      --with-http
      --with-http-libicu-dir=#{Formula["icu4c"].opt_prefix}
      --with-http-zlib-dir=#{MacOS.sdk_path_if_needed}/usr
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
