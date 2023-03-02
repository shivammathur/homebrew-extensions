# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xlswriter Extension
class XlswriterAT70 < AbstractPhpExtension
  init
  desc "Xlswriter PHP extension"
  homepage "https://github.com/viest/php-ext-xlswriter"
  url "https://pecl.php.net/get/xlswriter-1.5.4.tgz"
  sha256 "6df4198ac50366317bbecdfd08d34047cff517465be48261849f50b833da0b73"
  head "https://github.com/viest/php-ext-xlswriter.git"
  license "BSD-2-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "d1da78c50a36676bf60f78b5949e2f43cf74163f7ad702905e6b0ebd5f578bd1"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "7ea119a7fbaf85cb7f2d7703e600c450f642bae33808ee83ce87a4ae7cfdf1c3"
    sha256 cellar: :any_skip_relocation, monterey:       "169913dc80306e2ceb0673a34e534761d1b32d65f52712e4260c3b2e656440e5"
    sha256 cellar: :any_skip_relocation, big_sur:        "a33267579bc169b7b53d1b81819fead059a6ded710f61c11542d83f150319037"
    sha256 cellar: :any_skip_relocation, catalina:       "2ece62d84c1eeaa4880e0655d2450fe103211740d62906c0cd83bd0e68f1d5a1"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "3f302dfa5280056a164a1fb90b5f4b000c74c328170827a7693c4c971938a36a"
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
