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
    sha256 cellar: :any,                 arm64_big_sur: "6b6c4dd1e16eff65457c7f20f353cc5188cb7575c2195a9e432e81f068b6b0d9"
    sha256 cellar: :any,                 monterey:      "47737f8f3dac7d2f9e77a76ec25582c0515bb3457589122a7a9127325bf688ed"
    sha256 cellar: :any,                 big_sur:       "6388e7d7c061652150fbb5db61d6209eaccc4efbd6fb6e072885e490cc7c8e2a"
    sha256 cellar: :any,                 catalina:      "e5d23a665a03b9a2b716bc03545205d8108951023199d9d8ee07798ef1e4c67f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "02d3d73ad1fd9e81eee8a46ba8d09604513e0cc983075aad5ea66228ec2b457e"
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
