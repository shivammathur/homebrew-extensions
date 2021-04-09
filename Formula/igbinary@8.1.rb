# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Igbinary Extension
class IgbinaryAT81 < AbstractPhp81Extension
  init
  desc "Igbinary PHP extension"
  homepage "https://github.com/igbinary/igbinary"
  url "https://github.com/igbinary/igbinary/archive/3.2.1.tar.gz"
  sha256 "bc26f361f750bc9894741201e6851a3445a20d185969c08bf311264b7dc9cd6b"
  head "https://github.com/igbinary/igbinary.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 19
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "44e435ccc998bd3e3afb84ea740918f4388dc61b1ab1ec1772c8f43f5f6820d1"
    sha256 cellar: :any_skip_relocation, big_sur:       "e672d0d26f23b971d893d963994084da4f957ea4957af0708c067bf567b5db97"
    sha256 cellar: :any_skip_relocation, catalina:      "a0d11c59d96140723e26ec52906c33f166372219c2787b0d0963d9942ec886b3"
  end

  def install
    patch_spl_symbols
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-igbinary"
    system "make"
    prefix.install "modules/#{module_name}.so"
    write_config_file
    Dir.chdir "src/php7"
    add_include_files
  end
end
