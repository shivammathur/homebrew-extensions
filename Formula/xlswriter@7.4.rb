# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xlswriter Extension
class XlswriterAT74 < AbstractPhpExtension
  init
  desc "Xlswriter PHP extension"
  homepage "https://github.com/viest/php-ext-xlswriter"
  url "https://pecl.php.net/get/xlswriter-1.5.7.tgz"
  sha256 "3736aab69aea238dc80fbb385fcb2a878a78fa9460551cf633e119f3854086ef"
  head "https://github.com/viest/php-ext-xlswriter.git"
  license "BSD-2-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "a0e6182bbba621562c26298de7948213d2c4e91bf5d783524c8d1352b177a054"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "c7d3500b24cf3feb76bccb2bf2b0dccc37e9b92f545e0dc345b0e4a64d95bfd4"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "7e68162c9ca1d0b2998eb38d73b10a6dd6da6b8b53a515a0102a9a3cbc4242d4"
    sha256 cellar: :any_skip_relocation, ventura:        "8a8b7e9742f28e1182b3230a106b68dc9989fb2be9188d7599af40eb6378fe77"
    sha256 cellar: :any_skip_relocation, monterey:       "02cde6a944af38a7cde24aad2fbb1bd77b19eaef64115c7ef8468a4952f0ff7c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "0b366f0ae7d2d43247e2ef862fb045b9b12ccb781c6b513cc3293d98c6b1449f"
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
