# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xlswriter Extension
class XlswriterAT73 < AbstractPhpExtension
  init
  desc "Xlswriter PHP extension"
  homepage "https://github.com/viest/php-ext-xlswriter"
  url "https://pecl.php.net/get/xlswriter-1.5.7.tgz"
  sha256 "3736aab69aea238dc80fbb385fcb2a878a78fa9460551cf633e119f3854086ef"
  head "https://github.com/viest/php-ext-xlswriter.git"
  license "BSD-2-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "27db764c637c32d100a56249894103fd401cafe8515565e86b2d0da99f2b5c6d"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "4cfc42d7977ef71fd628c80f5471d1ef23d926b47e7992a897ebe0eb55b7bdb3"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "6694704b8864851e9d26b05e9aa95734f8a8c825bfbd54fa6d2e6acc85356332"
    sha256 cellar: :any_skip_relocation, ventura:        "77c244ea3eef55437df8c581d4c0b690c7187be0a84798009486186f2ae84810"
    sha256 cellar: :any_skip_relocation, monterey:       "bdc925dde7dfc27cf8b017ac9314dcd22578ecc29d4efb499ea3d6bff0eec7c8"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "7bc393daaaee69a53cd1aefe68557bf2dc7fcd886324bea96da3368cfa9408b0"
  end

  def install
    args = %w[
      --with-xlswriter
      --enable-reader
    ]
    Dir.chdir "xlswriter-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
