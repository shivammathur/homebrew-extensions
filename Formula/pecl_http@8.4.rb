# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pecl_http Extension
class PeclHttpAT84 < AbstractPhpExtension
  init
  desc "Pecl_http PHP extension"
  homepage "https://github.com/m6w6/ext-http"
  url "https://pecl.php.net/get/pecl_http-4.2.3.tgz"
  sha256 "fa2ab558fc8f0928a10f35c0f566f7c4a1d32e727bd3a96579e4c28482ee9d6a"
  head "https://github.com/m6w6/ext-http.git", branch: "master"
  license "BSD-2-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_monterey: "19973b91c06f25dbce2648dbfdc7180f16854fb0dbf9eba9c4762387663416ec"
    sha256 cellar: :any,                 arm64_big_sur:  "7439a0d0579c0a82016f434bdb83da008b064e4d1870fca5fd1158b24d9e239f"
    sha256 cellar: :any,                 ventura:        "0a061ed619dc838a7c937823f11d8b4e0a89344d75c37d7bf9d1da3f201c64a3"
    sha256 cellar: :any,                 monterey:       "1671b475e8c633c401c9eaf64cf3109e34f68ac4470c3e1b5067e547ada2e914"
    sha256 cellar: :any,                 big_sur:        "9866a6c042ea2f66d5ce750fabcfe76ac82acb4248d39891512d62841690fd74"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "c471e330d774b392fe0374622de2b814f8db134fa7cbbe90fce0d3c21b43a9a6"
  end

  depends_on "brotli"
  depends_on "curl"
  depends_on "icu4c"
  depends_on "libevent"
  depends_on "libidn2"
  depends_on "shivammathur/extensions/raphf@8.4"

  priority "30"

  def install
    args = %W[
      --with-http
      --with-http-libicu-dir=#{Formula["icu4c"].opt_prefix}
      --with-http-zlib-dir=#{MacOS.sdk_path_if_needed}/usr
    ]
    extra_includes = %W[
      -I#{Formula["shivammathur/extensions/raphf@8.4"].opt_include}/php
    ]
    ENV["EXTRA_INCLUDES"] = extra_includes * " "
    Dir.chdir "pecl_http-#{version}"
    inreplace "src/php_http_api.h", "ext/raphf", "ext/raphf@8.4"
    patch_spl_symbols
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
