# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pecl_http Extension
class PeclHttpAT74 < AbstractPhpExtension
  init
  desc "Pecl_http PHP extension"
  homepage "https://github.com/m6w6/ext-http"
  url "https://pecl.php.net/get/pecl_http-4.2.6.tgz"
  sha256 "cd33230050b3f7c5ddb6f4383ce2a81f0bcdb934432029eec72ebf0f942b876d"
  head "https://github.com/m6w6/ext-http.git"
  license "BSD-2-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/pecl_http/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 7
    sha256 cellar: :any,                 arm64_sequoia: "1963b69d1da46c0bbd5fce8513939b6fcf989b6054acf790ead721481ae16ee3"
    sha256 cellar: :any,                 arm64_sonoma:  "1ae33658af193230222f9018b47e48153bf54f0134f007a540d1dd0abc147f9f"
    sha256 cellar: :any,                 arm64_ventura: "bbd449e3ab8c63446eb1c66409717d1502f7e74bb7e2e043914126c28f33b913"
    sha256 cellar: :any,                 ventura:       "d61685e1e45b9ad4a1cf24a93d07ec184f0b92d783151360e70197699aa34caf"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "6e3aa37b84a7308b40f46ac6d9c7dd42d5741f88cc99d8e8ee9704a0290bfec6"
  end

  depends_on "brotli"
  depends_on "curl"
  depends_on "icu4c@76"
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
    # Work around to support `icu4c` 75, which needs C++17.
    ENV.append "CXX", "-std=c++17"
    ENV.libcxx if ENV.compiler == :clang
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
