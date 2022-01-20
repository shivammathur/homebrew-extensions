# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Igbinary Extension
class IgbinaryAT70 < AbstractPhpExtension
  init
  desc "Igbinary PHP extension"
  homepage "https://github.com/igbinary/igbinary"
  url "https://github.com/igbinary/igbinary/archive/3.2.7.tar.gz"
  sha256 "21863908348f90a8a895c8e92e0ec83c9cf9faffcfd70118b06fe2dca30eaa96"
  head "https://github.com/igbinary/igbinary.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "5ba37a2bb77f9b322df87184a48ad39d1bc9965120bd1ca1c3ead52ccbf269fd"
    sha256 cellar: :any_skip_relocation, big_sur:       "1e92e229e35e88ef4e904ea5317c8150790866482d26ee2775e615fb95ae764f"
    sha256 cellar: :any_skip_relocation, catalina:      "e24381c12c68adcaab525d2bea6d1dc82be57bd1296f243188e2d0e62c2efbc3"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "c0d4400b13af7cf49fa2fe862521c5cad4f6edd102baf384b937cb0240b1fbee"
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
