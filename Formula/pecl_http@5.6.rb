# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pecl_http Extension
class PeclHttpAT56 < AbstractPhpExtension
  init
  desc "Pecl_http PHP extension"
  homepage "https://github.com/m6w6/ext-http"
  url "https://pecl.php.net/get/pecl_http-2.6.0.tgz"
  sha256 "ddbf3eea3d1c7004a7dd83b5864aee5f87b1b6032bc281c08ccc62f83b9931ed"
  head "https://github.com/m6w6/ext-http.git"
  license "BSD-2-Clause"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 3
    sha256 cellar: :any_skip_relocation, arm64_monterey: "96bbc29c23c144909e4e7e8bd8d658261ae59012d631f21ee36bbb78ee6e1c27"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "cc4b2a1b480dc217b26530965fdaebf2ce771c2462fa3e851f14f6b2d1a0ca13"
    sha256 cellar: :any,                 monterey:       "d93e433325e07a5e16b5d0b524b77aff7d29eb4e9e5e20f97184e35a339ebccd"
    sha256 cellar: :any,                 big_sur:        "cd5b2b62fb73e08639696583a9292607de1d011f89aaebd8a8e45fc8c78a3c22"
    sha256 cellar: :any,                 catalina:       "2c2bac4117e294382f1fc500a5a123af4969a06d4845a974dbb51db4b6d9056c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "7e09a341eba42500b3cccebada9cd19f4ada74849c7d60b18b68448f0bc3cea2"
  end

  depends_on "brotli"
  depends_on "curl"
  depends_on "icu4c"
  depends_on "libevent"
  depends_on "libidn2"
  depends_on "shivammathur/extensions/propro@5.6"
  depends_on "shivammathur/extensions/raphf@5.6"

  def install
    args = %W[
      --with-http
      --with-http-zlib-dir=#{MacOS.sdk_path_if_needed}/usr
    ]
    extra_includes = %W[
      -I#{Formula["shivammathur/extensions/propro@5.6"].opt_include}/php
      -I#{Formula["shivammathur/extensions/raphf@5.6"].opt_include}/php
    ]
    ENV["EXTRA_INCLUDES"] = extra_includes * " "
    Dir.chdir "pecl_http-#{version}"
    inreplace "src/php_http_api.h", "ext/raphf", "ext/raphf@5.6"
    inreplace "src/php_http_api.h", "ext/propro", "ext/propro@5.6"
    inreplace "config9.m4", "/ext/raphf", "/php/ext/raphf@5.6"
    inreplace "config9.m4", "/ext/propro", "/php/ext/propro@5.6"
    inreplace "config9.m4", "$abs_srcdir", "$abs_srcdir ${HOMEBREW_PREFIX}/include"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
