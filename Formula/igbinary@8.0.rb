# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Igbinary Extension
class IgbinaryAT80 < AbstractPhpExtension
  init
  desc "Igbinary PHP extension"
  homepage "https://github.com/igbinary/igbinary"
  url "https://github.com/igbinary/igbinary/archive/3.2.15.tar.gz"
  sha256 "6fcbd7813eea1dfe00ec72a672cedb1d1cce06b2f23ab3cb148fa5e3edfa3994"
  head "https://github.com/igbinary/igbinary.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "44b05cda0bc9b9438d37249bdb8ed7a8c0b950ef1d47de9ade7069a208001ad8"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "6fb010260b1ede6169b471974704d5502ddc570ae1a9e090b09ac8b0cb3b23cf"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "623902ede6d5ab03f2200fccab154c9d532d1043439cd9e04fc778dda3ce87a2"
    sha256 cellar: :any_skip_relocation, ventura:        "d3f0a9c0229f9db7637cc6da4a7d42d2eca942a0a81fe7a612c18bfa6e58e09c"
    sha256 cellar: :any_skip_relocation, monterey:       "dde51cccae1737df8a4f83176f6b57f7e9166646aea7e8fd2dc43989641a20a5"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "5e08427ef49e6ba5c8a57a3daf9068939ffb3e091ad57d93b52afe6718c281d6"
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
