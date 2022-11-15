# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pecl_http Extension
class PeclHttpAT83 < AbstractPhpExtension
  init
  desc "Pecl_http PHP extension"
  homepage "https://github.com/m6w6/ext-http"
  url "https://pecl.php.net/get/pecl_http-4.2.3.tgz"
  sha256 "fa2ab558fc8f0928a10f35c0f566f7c4a1d32e727bd3a96579e4c28482ee9d6a"
  head "https://github.com/m6w6/ext-http.git", branch: "master"
  license "BSD-2-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any,                 arm64_monterey: "bb04f5eee9c3a699ab12a51c641137d6fa36a68e181d290885c22b8be96e52ec"
    sha256 cellar: :any,                 arm64_big_sur:  "0640531a824eda75c08c447dd1c60e7013ab119e7eee78cd635b169c9c86b98f"
    sha256 cellar: :any,                 monterey:       "8824919bb96632c6e5e188be4924bcf798d02a066a9e73dec7a6a3b670010d3a"
    sha256 cellar: :any,                 big_sur:        "927d09231ac8a652d207dc825a9218c2fb95d4dd51de2d7fecf24df3e505f2fc"
    sha256 cellar: :any,                 catalina:       "0ffa0a32439f754bf0a572f5e816718d2d50546c67471df13096ac90e5dfc923"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "27fdee3a57351050e4b63cd8241c813d722d5914183fe294d0226a14708158fd"
  end

  depends_on "brotli"
  depends_on "curl"
  depends_on "icu4c"
  depends_on "libevent"
  depends_on "libidn2"
  depends_on "shivammathur/extensions/raphf@8.3"

  priority "30"

  def install
    args = %W[
      --with-http
      --with-http-libicu-dir=#{Formula["icu4c"].opt_prefix}
      --with-http-zlib-dir=#{MacOS.sdk_path_if_needed}/usr
    ]
    extra_includes = %W[
      -I#{Formula["shivammathur/extensions/raphf@8.3"].opt_include}/php
    ]
    ENV["EXTRA_INCLUDES"] = extra_includes * " "
    Dir.chdir "pecl_http-#{version}"
    inreplace "src/php_http_api.h", "ext/raphf", "ext/raphf@8.3"
    patch_spl_symbols
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
