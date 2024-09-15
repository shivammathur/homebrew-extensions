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
    sha256 cellar: :any_skip_relocation, arm64_sequoia:  "3ae4041fdc92f970b39e5cac06a75eed815f9b8c5d97d9e1550ba634101bebf0"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "416f8ad127f7edb2590d65df1e4636136d54d1888a3f619092ffb60d787068a2"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "ab72d2f757b67cca320207fcdc458323006f2abfc80c5fc3fa7ffeda86f2fab6"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "00affd4f19199144be1f3c606f545951f90b7c3ccbf00b3dcb5596b305b7d86c"
    sha256 cellar: :any_skip_relocation, ventura:        "f66bb41aeefeb00df03cdb335c51131b7e6bfffb6e8beb1cb96b7d31cfd196e4"
    sha256 cellar: :any_skip_relocation, monterey:       "6c88e793eab359c76c065f24cd2e6ce09d751457c3777bd4f7ae70b2b213717b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "a5702ff6e9ae2d28a12e9e0d7bb07ab4eaf88ce064f9a3cdb3793236336e7ab6"
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
