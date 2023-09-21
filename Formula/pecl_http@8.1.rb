# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pecl_http Extension
class PeclHttpAT81 < AbstractPhpExtension
  init
  desc "Pecl_http PHP extension"
  homepage "https://github.com/m6w6/ext-http"
  url "https://pecl.php.net/get/pecl_http-4.2.3.tgz"
  sha256 "fa2ab558fc8f0928a10f35c0f566f7c4a1d32e727bd3a96579e4c28482ee9d6a"
  head "https://github.com/m6w6/ext-http.git"
  license "BSD-2-Clause"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 3
    sha256 cellar: :any,                 arm64_ventura:  "1ecd77c5fddf8eee55ca708b21d51b7700db39b4dbd5ce28e1dab6e776e1a582"
    sha256 cellar: :any,                 arm64_monterey: "841650176e603d4a9bdeb1e00ed70fd341814c4fcca7a3784b2c7acd72bbf680"
    sha256 cellar: :any,                 arm64_big_sur:  "857f71503751a46681ead308b9392a6e0426b760538da74d0bf528e3fb39cd4e"
    sha256 cellar: :any,                 ventura:        "73811a5b47513c471cd0040de27d3cd0626aee878095178114e922babbca904c"
    sha256 cellar: :any,                 monterey:       "c35ca54a00a2888ca11a3b6f988022b10beeba9e8d1373cf48cd304edfa365f3"
    sha256 cellar: :any,                 big_sur:        "c0a7f43e88a6fe427656cf6b6de8637f29a6e3231d20f10db6a406886d24babd"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "1c937f3a86364489c888199ad6c432bc116fd7991d1b37c7fb6b30e97f816871"
  end

  depends_on "brotli"
  depends_on "curl"
  depends_on "icu4c"
  depends_on "libevent"
  depends_on "libidn2"
  depends_on "shivammathur/extensions/raphf@8.1"

  priority "30"

  def install
    args = %W[
      --with-http
      --with-http-libicu-dir=#{Formula["icu4c"].opt_prefix}
      --with-http-zlib-dir=#{MacOS.sdk_path_if_needed}/usr
    ]
    extra_includes = %W[
      -I#{Formula["shivammathur/extensions/raphf@8.1"].opt_include}/php
    ]
    ENV["EXTRA_INCLUDES"] = extra_includes * " "
    Dir.chdir "pecl_http-#{version}"
    inreplace "src/php_http_api.h", "ext/raphf", "ext/raphf@8.1"
    patch_spl_symbols
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
