# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Igbinary Extension
class IgbinaryAT72 < AbstractPhpExtension
  init
  desc "Igbinary PHP extension"
  homepage "https://github.com/igbinary/igbinary"
  url "https://github.com/igbinary/igbinary/archive/3.2.3.tar.gz"
  sha256 "c6bb38235e166ddf5713f464f9ab6d16e85783eefa7825824efd252eea6ac4e5"
  head "https://github.com/igbinary/igbinary.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "7942945c3b7a32e581d53809fe27cc2068cffd349df189891ce694ae435029b0"
    sha256 cellar: :any_skip_relocation, big_sur:       "d5bd955c579284a231c94898e6232b9a40106bcb0944ce360f6e4764c1b10fe3"
    sha256 cellar: :any_skip_relocation, catalina:      "083c94487d15b313fe7c8e58e6c55f81f2403c1188434c3d7778111a83ee1813"
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
