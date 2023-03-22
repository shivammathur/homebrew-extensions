# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Igbinary Extension
class IgbinaryAT70 < AbstractPhpExtension
  init
  desc "Igbinary PHP extension"
  homepage "https://github.com/igbinary/igbinary"
  url "https://github.com/swoole/swoole-src/archive/v5.0.2.tar.gz"
  sha256 "14d442d5e945fe67a3e912d332175b2386a50c38a674c4559d2d0211db23362e"
  head "https://github.com/igbinary/igbinary.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "71a437645d2cc5f4f646398625a906a54ff3ba42336728320dbf85b3c4ec6aa7"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "5342a4d6e4483874de660f2a971236a8a9dd7373b5dedc35dc31787140b79d3c"
    sha256 cellar: :any_skip_relocation, monterey:       "bc20e4e2a45e09c279c0d33e37db7a61cfda61f480aa51c12de78e7693d74a73"
    sha256 cellar: :any_skip_relocation, big_sur:        "df24ad3cbc26b5e6010c3e53085885d1e0aa6cae89d6b3a6d813a010cf665c21"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "b34a980608258d676ff31217ff927bd0be672ebcb88251b438e4db2c15d70a70"
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
