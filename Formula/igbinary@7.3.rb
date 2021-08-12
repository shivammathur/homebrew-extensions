# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Igbinary Extension
class IgbinaryAT73 < AbstractPhpExtension
  init
  desc "Igbinary PHP extension"
  homepage "https://github.com/igbinary/igbinary"
  url "https://github.com/igbinary/igbinary/archive/3.2.6.tar.gz"
  sha256 "87cf65d8a003a3f972c0da08f9aec65b2bf3cb0dc8ac8b8cbd9524d581661250"
  head "https://github.com/igbinary/igbinary.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "8df3c678e8076c0bf5064001412ad73d29620b558d149de38cb74e215781a2ed"
    sha256 cellar: :any_skip_relocation, big_sur:       "19cd817e89896682ff2947198e854be71b6b51e25c7872ad99ee9d8621cb028c"
    sha256 cellar: :any_skip_relocation, catalina:      "02fef88d8499716fe4c98e7ea82d0b62de98bb0c40ca289a064d6ca6b7f44b8d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "8929001086b7e28d7ea98903c2c580ac5bab60c0db66aa0f6c5d8ae31a4c86f7"
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-igbinary"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    Dir.chdir "src/php7"
    add_include_files
  end
end
