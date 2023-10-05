# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pecl_http Extension
class PeclHttpAT80 < AbstractPhpExtension
  init
  desc "Pecl_http PHP extension"
  homepage "https://github.com/m6w6/ext-http"
  url "https://pecl.php.net/get/pecl_http-4.2.4.tgz"
  sha256 "fb1e10c2e5edfb011ff8dc2e473cdbd2bbe0127d1279dfce4d98570555ac6ded"
  head "https://github.com/m6w6/ext-http.git"
  license "BSD-2-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 3
    sha256 cellar: :any,                 arm64_ventura:  "5da4388ae2c0a8e98dea4a6a5bc40b4dff45412785700db7c4843e7f0797c8af"
    sha256 cellar: :any,                 arm64_monterey: "61cb7e67a1e5eca8feac8efd4b8ca7f9bf03b0b2dcba7295be2b8fcbaee87b93"
    sha256 cellar: :any,                 arm64_big_sur:  "54341ceb23f504ba7382f860361104357417330e704145df5ad245ffc4871209"
    sha256 cellar: :any,                 ventura:        "81fbccebff59dcd374e4abe440b22f5d1dc015546d811f423169bf2fd1a203b3"
    sha256 cellar: :any,                 monterey:       "f897291e4750ce0c7bd71539a96c611ee576a090d1544a8236340986fc2f374a"
    sha256 cellar: :any,                 big_sur:        "54dfaf4d9b43afdb2f1661e08cd59f19de7e48dbdb036dad996ce16a97595505"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "234fb86c15f9aa00c187fe2ef7a5fa7de190d9a01e54f892d13d924c60b5abe1"
  end

  depends_on "brotli"
  depends_on "curl"
  depends_on "icu4c"
  depends_on "libevent"
  depends_on "libidn2"
  depends_on "shivammathur/extensions/raphf@8.0"

  priority "30"

  def install
    args = %W[
      --with-http
      --with-http-libicu-dir=#{Formula["icu4c"].opt_prefix}
      --with-http-zlib-dir=#{MacOS.sdk_path_if_needed}/usr
    ]
    extra_includes = %W[
      -I#{Formula["shivammathur/extensions/raphf@8.0"].opt_include}/php
    ]
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
