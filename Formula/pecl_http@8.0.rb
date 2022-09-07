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
    rebuild 1
    sha256 cellar: :any,                 arm64_monterey: "2039cc15d27b2b51e359b2197a56bf522657324deec3855886ad479da8fe90e3"
    sha256 cellar: :any,                 arm64_big_sur:  "501d30581085c2aed5d7a2e5ba8474ec5023dad51a982c137f166fc5cc4db836"
    sha256 cellar: :any,                 monterey:       "a542bebce92a5cf0fb8d46734fc4209279daa49d96fd83278c22425b0cf42251"
    sha256 cellar: :any,                 big_sur:        "430be1051542332557182caf8c87ed2d127314a02216d1d419d73a3418073af9"
    sha256 cellar: :any,                 catalina:       "808704daf0eb1818d52b686cf2a4b7258c4931091b478034f5bcba069ad86e0f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "fdf9291d5d3986e5def0c8b6aa1ba01ccdc1bf8fe4f6236efeab667fc471d5eb"
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
