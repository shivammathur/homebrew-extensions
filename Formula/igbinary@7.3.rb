# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Igbinary Extension
class IgbinaryAT73 < AbstractPhp73Extension
  init
  desc "Igbinary PHP extension"
  homepage "https://github.com/igbinary/igbinary"
  url "https://github.com/igbinary/igbinary/archive/3.2.1.tar.gz?init=true"
  sha256 "bc26f361f750bc9894741201e6851a3445a20d185969c08bf311264b7dc9cd6b"
  head "https://github.com/igbinary/igbinary.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://dl.bintray.com/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "7ac2ca3f0745d7b41f5f70599cac0f2bb10cf8a98f4ca2d32b266bf79c5e7c35"
    sha256 cellar: :any_skip_relocation, big_sur:       "1e04b2f4fb4416cdc97a207ea5f6c1049591b3179fbc3f09129f49fa672a21d5"
    sha256 cellar: :any_skip_relocation, catalina:      "1c729f6c9992cfd651d75da2d8b35bf699ddcb2bd6214409e692c554e667a686"
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-igbinary"
    system "make"
    prefix.install "modules/#{module_name}.so"
    write_config_file
    Dir.chdir "src/php7"
    add_include_files
  end
end
