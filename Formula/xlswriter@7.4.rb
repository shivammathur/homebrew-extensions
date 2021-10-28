# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xlswriter Extension
class XlswriterAT74 < AbstractPhpExtension
  init
  desc "Xlswriter PHP extension"
  homepage "https://github.com/viest/php-ext-xlswriter"
  url "https://pecl.php.net/get/xlswriter-1.5.1.tgz"
  sha256 "101e3d244e8b4fff7391f5a2f230d4d94f01bb6a1f42cfd9539599df0f3957c8"
  head "https://github.com/viest/php-ext-xlswriter.git"
  license "BSD-2-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "dd24795b9e69f176ea788b747b0ca2d24ff8f8ee93717c2af4cb729d61d21383"
    sha256 cellar: :any_skip_relocation, big_sur:       "589f6d9825ba46a167f6500f8e0c84c5d2761bcd14a0dcb309a080cb38f7e407"
    sha256 cellar: :any_skip_relocation, catalina:      "be2fcffaaf7e1743569bd56eb3553444b5ecca07d60ea1472cae0fda9023e7cf"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "4fb271c88f2c46fadd5b6a7c32c60618630240d6e944eed09f90f2b43f794c9f"
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
