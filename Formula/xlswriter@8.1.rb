# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xlswriter Extension
class XlswriterAT81 < AbstractPhpExtension
  init
  desc "Xlswriter PHP extension"
  homepage "https://github.com/viest/php-ext-xlswriter"
  url "https://pecl.php.net/get/xlswriter-1.5.1.tgz"
  sha256 "101e3d244e8b4fff7391f5a2f230d4d94f01bb6a1f42cfd9539599df0f3957c8"
  head "https://github.com/viest/php-ext-xlswriter.git"
  license "BSD-2-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "6b8872be325328670b2451c092afa3f254047338ebe30e6cc373d1ddfcda6c20"
    sha256 cellar: :any_skip_relocation, big_sur:       "3642e9c42e8437200486bde6e354cea2ce6ce56a4b9073fd7b5a50293a28436a"
    sha256 cellar: :any_skip_relocation, catalina:      "a01964ee774d96c2ef2e553be2e1c78d05dd2cc95d7d2188f1820ea1ab586658"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "f2f6d91d12308b7632ac76b273a141308e09651bab51fbcff286c1c455f3b64e"
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
