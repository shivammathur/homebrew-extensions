# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Igbinary Extension
class IgbinaryAT82 < AbstractPhpExtension
  init
  desc "Igbinary PHP extension"
  homepage "https://github.com/igbinary/igbinary"
  url "https://github.com/igbinary/igbinary/archive/3.2.7.tar.gz"
  sha256 "21863908348f90a8a895c8e92e0ec83c9cf9faffcfd70118b06fe2dca30eaa96"
  head "https://github.com/igbinary/igbinary.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "049543534f2bcf178d33b13edbf885b7a81edd78082e9d065c1b8399b1b98770"
    sha256 cellar: :any_skip_relocation, big_sur:       "9721cf46e01bf19d20b47c9addae9d36cb41f49bf513077cf8ee88a08d4c2716"
    sha256 cellar: :any_skip_relocation, catalina:      "6f875f7d944ded2d7ccb48332ef14f2d3a0230114ab33ea12a21f7732e7c211d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "2a424cfe4c8024bad67a75aa52b47a264ee1c9762703cd412fdec6b2e91f120f"
  end

  def install
    patch_spl_symbols
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-igbinary"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    Dir.chdir "src/php7"
    add_include_files
  end
end
