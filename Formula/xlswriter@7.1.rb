# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xlswriter Extension
class XlswriterAT71 < AbstractPhpExtension
  init
  desc "Xlswriter PHP extension"
  homepage "https://github.com/viest/php-ext-xlswriter"
  url "https://pecl.php.net/get/xlswriter-1.5.0.tgz"
  sha256 "05698726e123e4c339ccaaab80f0a81705b9bc9c21377f0951c9ad51df4718c6"
  head "https://github.com/viest/php-ext-xlswriter.git"
  license "BSD-2-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "e657231c229a7b5665a2a31af092b55cf13f7cd5452abb8429e68b17d3c815fb"
    sha256 cellar: :any_skip_relocation, big_sur:       "e95457edf516447bf796dbf57536a5b961afcc0400c75b3b3960a949883cdb6b"
    sha256 cellar: :any_skip_relocation, catalina:      "dead7c7844c440f3bc575b234ebc4df7208e5956a4e5c4ed36d810228201afa6"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "d06a109e333cc91332811672765b0766334d47780b4ccd8f61be81dc9501f4db"
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
