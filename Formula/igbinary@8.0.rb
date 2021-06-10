# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Igbinary Extension
class IgbinaryAT80 < AbstractPhpExtension
  init
  desc "Igbinary PHP extension"
  homepage "https://github.com/igbinary/igbinary"
  url "https://github.com/igbinary/igbinary/archive/3.2.3.tar.gz"
  sha256 "c6bb38235e166ddf5713f464f9ab6d16e85783eefa7825824efd252eea6ac4e5"
  head "https://github.com/igbinary/igbinary.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "00f3be8b9ac165bda72337cea664bc1cf90e31428388ca0b313c89be1ef63cab"
    sha256 cellar: :any_skip_relocation, big_sur:       "3fe59f84292daba32fe22401327969aecc08407626ec65a0d642dd221ae36669"
    sha256 cellar: :any_skip_relocation, catalina:      "bcb11da9e1c31b0161edf5df785b5a594bfde7fb2c6fbfc49a6ea9394b7c6a55"
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
