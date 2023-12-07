# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Igbinary Extension
class IgbinaryAT71 < AbstractPhpExtension
  init
  desc "Igbinary PHP extension"
  homepage "https://github.com/igbinary/igbinary"
  url "https://github.com/igbinary/igbinary/archive/3.2.15.tar.gz"
  sha256 "6fcbd7813eea1dfe00ec72a672cedb1d1cce06b2f23ab3cb148fa5e3edfa3994"
  head "https://github.com/igbinary/igbinary.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "6d02710bbc4e8e8dff8c2b60f8795212982e6d59afd2037fd59a1aaa3664efc6"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "bc6086d048765e177b666521e1834746ccd699005ab2dcfb3358dceb23f09edb"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "e90fda06c1db3e36fb0f341d6bbb2aa551815e01ba111419e0679633ad8d7919"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "aab4ef9fdf873c2d7dbb1e4437b91423b959ac1ea6fa128772d75796b012b4b0"
    sha256 cellar: :any_skip_relocation, ventura:        "c7436822dc9c651ad4bd5c61942613fd7afcfe4b0c8ed3ed514e749f29b83584"
    sha256 cellar: :any_skip_relocation, monterey:       "76672f53a9f0b47ede5cc7a700516dc83f1c9decffd5706f59ae79515505c51c"
    sha256 cellar: :any_skip_relocation, big_sur:        "6ad7022e149b4475791302596c45636ca4dac53756fac320c5520fe26e8b32f4"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "a76b4735936bd083eb8ac6647f6629f2a1bab1d6e61215096555ed088777f95d"
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
