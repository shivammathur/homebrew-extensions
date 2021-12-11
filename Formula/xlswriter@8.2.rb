# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xlswriter Extension
class XlswriterAT82 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "f073e302d0c097c8d1a96bdf265cc161e67976d0647e0d191160dbedc7d471c2"
    sha256 cellar: :any_skip_relocation, big_sur:       "4d9f2470996bacebb8d39f51f91664ba4c61bcdc07c9de0f30cf365e3c9b3a5c"
    sha256 cellar: :any_skip_relocation, catalina:      "6a0b73bcea81aabbcd91b596e56a3a4aa54ae08347eec104f9c983d2a797015b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "cb5439816bc1c2a2c1b409e73bffd2a74a3b110b3eabee99af207f448b74900b"
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
