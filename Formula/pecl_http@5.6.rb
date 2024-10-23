# typed: true
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
  revision 2

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 3
    sha256 cellar: :any_skip_relocation, arm64_sequoia:  "eb8440c89f68d45c626ec051c04d73c4ace2fe5d65b0262c84f5b5b6d6d26dc2"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "434edb13558478ef3c07aeb462964de3cc2c6d68463edcd5b92cd008dc075b14"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "0b1af736be8682b2481c5114e0725dc585cceb946b09933a9c578f905996c96a"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "5e2110126b8cd7e76a43b218d9a2c63b0d270d8930fd44d5979f1936001bb47d"
    sha256 cellar: :any,                 ventura:        "6a091629ca567e3a272a6042d9a69807d0aca0b0fdaaef010ea9967ac86e2f5e"
    sha256 cellar: :any,                 monterey:       "86e1dd37ac4d8b3f414cbaa9a42fc3a27720b4b2c3f74c71d8d35bb2a467b875"
    sha256 cellar: :any,                 big_sur:        "1f55a5dec4494ab375399bde7b216caa95e92c802a10c48cbe30cacba9be6fd7"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "1a8bec98d435a1bea6f1a1a9b466787202da86bf21c70d8cb2118f11cc74acd1"
  end

  depends_on "brotli"
  depends_on "curl"
  depends_on "icu4c"
  depends_on "libevent"
  depends_on "libidn2"
  depends_on "shivammathur/extensions/propro@5.6"
  depends_on "shivammathur/extensions/raphf@5.6"
  depends_on "zlib"

  priority "30"

  def install
    ENV.append "CFLAGS", "-Wno-implicit-function-declaration"
    args = %W[
      --with-http
      --with-http-zlib-dir=#{Formula["zlib"].opt_prefix}
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
