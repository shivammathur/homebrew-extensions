# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pecl_http Extension
class PeclHttpAT82 < AbstractPhpExtension
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
    rebuild 1
    sha256 cellar: :any,                 arm64_monterey: "ab9b3a24049b5b45cab4ba3836bc6f9fc195b6245c68f6674b982eaf03efa6d2"
    sha256 cellar: :any,                 arm64_big_sur:  "14c1e819ec97b9399365ab1f81cd7f2b5c628480164263805c8d36e929ff9f6a"
    sha256 cellar: :any,                 monterey:       "44bc5c7594e2d2b7551880080c429289b83fecb33095acfb91382a5137ddac10"
    sha256 cellar: :any,                 big_sur:        "23e460b843b1da73bcfa12fdbd84c4f453e14f886f56135a0e8f173f5ba7ca77"
    sha256 cellar: :any,                 catalina:       "eb178195b8d556626678e5206647568edc9f47f2468a8495b0fabe845136f134"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "dd83704c20f8176b91b7b1ce866d15c0c13f2d73d355e366660d14b8520e5562"
  end

  depends_on "brotli"
  depends_on "curl"
  depends_on "icu4c"
  depends_on "libevent"
  depends_on "libidn2"
  depends_on "shivammathur/extensions/raphf@8.2"

  priority "30"

  def install
    args = %W[
      --with-http
      --with-http-libicu-dir=#{Formula["icu4c"].opt_prefix}
      --with-http-zlib-dir=#{MacOS.sdk_path_if_needed}/usr
    ]
    extra_includes = %W[
      -I#{Formula["shivammathur/extensions/raphf@8.2"].opt_include}/php
    ]
    ENV["EXTRA_INCLUDES"] = extra_includes * " "
    Dir.chdir "pecl_http-#{version}"
    inreplace "src/php_http_api.h", "ext/raphf", "ext/raphf@8.2"
    patch_spl_symbols
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
