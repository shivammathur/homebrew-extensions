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
  revision 2

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_monterey: "6875416b3f2700593edc145092aee55f26e481b02c62b8e8d7007e29b7b5ea4e"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "6855221b69104d8cc473ea936936db12b2a648d6a9c81807ea168450de865003"
    sha256 cellar: :any,                 monterey:       "c3984dfc2a9ce30fdd3c4fe82fceb90716e239c688fad5eacf20906964bc67dd"
    sha256 cellar: :any,                 big_sur:        "1f55a5dec4494ab375399bde7b216caa95e92c802a10c48cbe30cacba9be6fd7"
    sha256 cellar: :any,                 catalina:       "0a5e12dc2dca705890ff7534135f24b392e1823281c4cd1ac1772817fc2a8a5f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "1168725e5b4895b454f19f7a12ef0e8eb093407f9b57adeff75071656e44def4"
  end

  depends_on "brotli"
  depends_on "curl"
  depends_on "icu4c"
  depends_on "libevent"
  depends_on "libidn2"
  depends_on "shivammathur/extensions/propro@5.6"
  depends_on "shivammathur/extensions/raphf@5.6"

  priority "30"

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
