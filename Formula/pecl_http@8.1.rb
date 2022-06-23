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

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "4f18c69fb8c7a06b8bffb3eb7a59c7369cd87eca24fe3568c7c50eeb79ca3e82"
    sha256 cellar: :any,                 arm64_big_sur:  "5a8b41953099247ee83bbfe1e8b84133208b382770739b4ff74903ff7b045515"
    sha256 cellar: :any,                 monterey:       "15471d8efd421079243973ebdf415efc376128db17d954bffbf424920a9f9c14"
    sha256 cellar: :any,                 big_sur:        "5edd3f13599e9acb6ed7416441b3f47fdd36c790a2b3addfcc440edf152680c8"
    sha256 cellar: :any,                 catalina:       "db66dce269d56096ea94a437d7f09c5949e55ec483bc5be47ee555e912410e23"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "65cabeedb95931e11521e0d8e0fafcbe2c263ef0e2f5e1828e71fc1cf1806478"
  end

  depends_on "brotli"
  depends_on "curl"
  depends_on "icu4c"
  depends_on "libevent"
  depends_on "libidn2"
  depends_on "shivammathur/extensions/raphf@8.1"

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
