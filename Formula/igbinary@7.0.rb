# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Igbinary Extension
class IgbinaryAT70 < AbstractPhpExtension
  init
  desc "Igbinary PHP extension"
  homepage "https://github.com/igbinary/igbinary"
  url "https://github.com/igbinary/igbinary/archive/3.2.16.tar.gz"
  sha256 "941f1cf2ccbecdc1c221dbfae9213439d334be5d490a2f3da2be31e8a00b0cdb"
  head "https://github.com/igbinary/igbinary.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "7a4cedff370bd62a893475c004ed2a3e98b5452dc51844c91224e5cfb94c8210"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "bb88d93d852ae41b94b15b114e4a27c6f196fc42172900b2d7fcf0dc9e2e3178"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "2c564018dc66402a0534eccb2ee2df270875cf411035b28e8cc95c62f2f8d4f5"
    sha256 cellar: :any_skip_relocation, ventura:        "7db23760fbd2efa2d64eb7820ec9a94c14af2b5ec97d94c0c12b16d67f436296"
    sha256 cellar: :any_skip_relocation, monterey:       "6c3d4185cd563c4058cc2c2a6b617d53e4d1aec96614e2a4368a25118c0c6820"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "653eef45e877d22afc613731544b7cd4bb130c8269528112e116002ec2652388"
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
