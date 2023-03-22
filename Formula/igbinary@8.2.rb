# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Igbinary Extension
class IgbinaryAT82 < AbstractPhpExtension
  init
  desc "Igbinary PHP extension"
  homepage "https://github.com/igbinary/igbinary"
  url "https://github.com/igbinary/igbinary/archive/3.2.14.tar.gz"
  sha256 "3dd62637667bee9328b3861c7dddc754a08ba95775d7b57573eadc5e39f95ac6"
  head "https://github.com/igbinary/igbinary.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "cb852ec0cff28b901d2e50cbc6477239c94d812f243ce25671b5bbce848fa6eb"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "63e7d8f2abf572b4dfabcf1a34012cb47000049d7966e44fe63e8e1bed63c10e"
    sha256 cellar: :any_skip_relocation, monterey:       "eaf31cf1d1fd8df5d3c7ee86c611359bf53007a21457953fc88a1a44bd7ebf11"
    sha256 cellar: :any_skip_relocation, big_sur:        "f3af1f1e4220d19fe019c39937cdd4616a6c46fc293aecc7c7357ce92330f46d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "733fb6c1412314a074216b92125851eff70e14a78a799ba03250f83a221ad0c5"
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
