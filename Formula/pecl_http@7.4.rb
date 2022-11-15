# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pecl_http Extension
class PeclHttpAT74 < AbstractPhpExtension
  init
  desc "Pecl_http PHP extension"
  homepage "https://github.com/m6w6/ext-http"
  url "https://pecl.php.net/get/pecl_http-3.3.0.tgz"
  sha256 "9194524be3997328b6788ef37e37485253e03eadc4bf51abd740358d03d2f536"
  head "https://github.com/m6w6/ext-http.git"
  license "BSD-2-Clause"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_monterey: "bde30d3acf2f0ee697bb00b7d6a067b37c4a51b4204b43e1af2bb185abed8467"
    sha256 cellar: :any,                 arm64_big_sur:  "74c41fea89e48799bf38776e9497b7af7feaf2344aca3efd94bc765065eb0ab9"
    sha256 cellar: :any,                 monterey:       "5a0e08348115505fd94a7edd172770c1b28f35a73b249a2177a82bacfa662f0c"
    sha256 cellar: :any,                 big_sur:        "38b1059afeb709cbca9f4c4aa0ae8bce8af41c4f7367755ab7f4b128f254b867"
    sha256 cellar: :any,                 catalina:       "3c969495722410eba3adee9340d886fb24af1d4c2e000fe58712f00f8164172b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "ff19f7a4566828daa6ff005484881077017f173685d0145c39604b216b3c9d62"
  end

  depends_on "brotli"
  depends_on "curl"
  depends_on "icu4c"
  depends_on "libevent"
  depends_on "libidn2"
  depends_on "shivammathur/extensions/propro@7.4"
  depends_on "shivammathur/extensions/raphf@7.4"

  priority "30"

  def install
    args = %W[
      --with-http
      --with-http-libicu-dir=#{Formula["icu4c"].opt_prefix}
      --with-http-zlib-dir=#{MacOS.sdk_path_if_needed}/usr
    ]
    extra_includes = %W[
      -I#{Formula["shivammathur/extensions/propro@7.4"].opt_include}/php
      -I#{Formula["shivammathur/extensions/raphf@7.4"].opt_include}/php
    ]
    ENV["EXTRA_INCLUDES"] = extra_includes * " "
    Dir.chdir "pecl_http-#{version}"
    inreplace "src/php_http_api.h", "ext/raphf", "ext/raphf@7.4"
    inreplace "src/php_http_api.h", "ext/propro", "ext/propro@7.4"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
