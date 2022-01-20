# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Igbinary Extension
class IgbinaryAT81 < AbstractPhpExtension
  init
  desc "Igbinary PHP extension"
  homepage "https://github.com/igbinary/igbinary"
  url "https://github.com/igbinary/igbinary/archive/3.2.7.tar.gz"
  sha256 "21863908348f90a8a895c8e92e0ec83c9cf9faffcfd70118b06fe2dca30eaa96"
  head "https://github.com/igbinary/igbinary.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "4748977684be2394b28e77ecb1b8a921b96d02f1e8e28f0b905ec97bce62a5fd"
    sha256 cellar: :any_skip_relocation, big_sur:       "621d38e3637fcdf4e81eeb46dde425606b6e486deb5949cfa12fd5ff6f6d8200"
    sha256 cellar: :any_skip_relocation, catalina:      "2257bbdec394266fd2e1ce38960b594e023dea99e2a845b459cb1704f8a77f8c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "44628c0b615374529e755a7ca63f4fe0a29150a46b5485bed7ff3facd8440184"
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
