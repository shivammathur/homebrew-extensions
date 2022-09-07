# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pecl_http Extension
class PeclHttpAT56 < AbstractPhpExtension
  init
  desc "Pecl_http PHP extension"
  homepage "https://github.com/m6w6/ext-http"
  url "https://pecl.php.net/get/pecl_http-2.6.0.tgz"
  sha256 "ddbf3eea3d1c7004a7dd83b5864aee5f87b1b6032bc281c08ccc62f83b9931ed"
  head "https://github.com/m6w6/ext-http.git"
  license "BSD-2-Clause"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any_skip_relocation, arm64_monterey: "96bbc29c23c144909e4e7e8bd8d658261ae59012d631f21ee36bbb78ee6e1c27"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "cc4b2a1b480dc217b26530965fdaebf2ce771c2462fa3e851f14f6b2d1a0ca13"
    sha256 cellar: :any,                 monterey:       "bd6e25a8c1f8e58c475f0c7e29c8b3e2463a2f4c67416f065623935b14ade675"
    sha256 cellar: :any,                 big_sur:        "444310631b1523bd3462830acaf2e839eb3f2f787bd4d7133ce483a9a35da57e"
    sha256 cellar: :any,                 catalina:       "c5df121361d116e5411cc68e3a4f594737cfb1f21e5c93c1d3f08c8b46d6d0af"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "fa98d90cb0d12eab67195470cf624a57d202b026351553b95078441e582635a4"
  end

  depends_on "brotli"
  depends_on "curl"
  depends_on "icu4c"
  depends_on "libevent"
  depends_on "libidn2"
  depends_on "shivammathur/extensions/propro@5.6"
  depends_on "shivammathur/extensions/raphf@5.6"

  def install
    args = %W[
      --with-http
      --with-http-zlib-dir=#{MacOS.sdk_path_if_needed}/usr
    ]
    extra_includes = %W[
      -I#{Formula["shivammathur/extensions/propro@5.6"].opt_include}/php
      -I#{Formula["shivammathur/extensions/raphf@5.6"].opt_include}/php
    ]
    ENV["EXTRA_INCLUDES"] = extra_includes * " "
    Dir.chdir "pecl_http-#{version}"
    inreplace "src/php_http_api.h", "ext/raphf", "ext/raphf@5.6"
    inreplace "src/php_http_api.h", "ext/propro", "ext/propro@5.6"
    inreplace "config9.m4", "/ext/raphf", "/php/ext/raphf@5.6"
    inreplace "config9.m4", "/ext/propro", "/php/ext/propro@5.6"
    inreplace "config9.m4", "$abs_srcdir", "$abs_srcdir ${HOMEBREW_PREFIX}/include"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
