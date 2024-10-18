# typed: true
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
    rebuild 4
    sha256 cellar: :any,                 arm64_sequoia:  "d5c33f582e459d6e74efcfea473c17ab18b24b1b51bf1a9cfeb39335193621cb"
    sha256 cellar: :any,                 arm64_sonoma:   "9a3eaa58ecaad9296fc5bd3de4fb01033d129b38b55f464959fa4fa8b24cf1b2"
    sha256 cellar: :any,                 arm64_ventura:  "bd73ad61544900717b839901b52af23675c15084b2ef0b1593dd6d1a9dae1320"
    sha256 cellar: :any,                 arm64_monterey: "abf2e6415a03a5c666a445f25bcf1dfb232f17a0c071f4ddf6e84efec3354416"
    sha256 cellar: :any,                 ventura:        "34b1c1f27b0e558888738a894456c4091bd9c8b40738e60b8a186a02b26ef185"
    sha256 cellar: :any,                 monterey:       "e1b79ee27cd613bc6d00ab0c44f6b69bb6f5064b7cc71e60c4b64d4456aaa1c0"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "739d15fa36c08df15d66f7ffc91e22986ba1a33a605f87aea72c9db7957e58fe"
  end

  depends_on "brotli"
  depends_on "curl"
  depends_on "icu4c"
  depends_on "libevent"
  depends_on "libidn2"
  depends_on "shivammathur/extensions/propro@7.4"
  depends_on "shivammathur/extensions/raphf@7.4"
  depends_on "zlib"

  priority "30"

  def install
    args = %W[
      --with-http
      --with-http-libicu-dir=#{Formula["icu4c"].opt_prefix}
      --with-http-zlib-dir=#{Formula["zlib"].opt_prefix}
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
