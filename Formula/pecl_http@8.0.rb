# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pecl_http Extension
class PeclHttpAT80 < AbstractPhpExtension
  init
  desc "Pecl_http PHP extension"
  homepage "https://github.com/m6w6/ext-http"
  url "https://pecl.php.net/get/pecl_http-4.2.3.tgz"
  sha256 "fa2ab558fc8f0928a10f35c0f566f7c4a1d32e727bd3a96579e4c28482ee9d6a"
  head "https://github.com/m6w6/ext-http.git"
  license "BSD-2-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any,                 arm64_monterey: "e749b984e5ec59613ed6d1723f22d955320d2642cb5e799edaa5f14c8f76ef70"
    sha256 cellar: :any,                 arm64_big_sur:  "5d34335b020195d9cf25fe0aa6cd358733fb4e34812798c450545d5d554ef69c"
    sha256 cellar: :any,                 monterey:       "937c25745d17bd77acf362d22d03c39eeddaea3997345746a393372bf4606d68"
    sha256 cellar: :any,                 big_sur:        "a663a9628c032649bec6eb249c5a717774377686a4d9abdd5337dbc3dacd4f92"
    sha256 cellar: :any,                 catalina:       "8bc8d478020bd4e0839b820131562e05ed4bea45ebba4da78d58cda50e1c708a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "254fc7caf991b9899ad7532ea3dce0cfb3ac533062100cf548d02e7e3c9b90c5"
  end

  depends_on "brotli"
  depends_on "curl"
  depends_on "icu4c"
  depends_on "libevent"
  depends_on "libidn2"
  depends_on "shivammathur/extensions/raphf@8.0"

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
