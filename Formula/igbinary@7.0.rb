# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Igbinary Extension
class IgbinaryAT70 < AbstractPhpExtension
  init
  desc "Igbinary PHP extension"
  homepage "https://github.com/igbinary/igbinary"
  url "https://github.com/igbinary/igbinary/archive/3.2.14.tar.gz"
  sha256 "3dd62637667bee9328b3861c7dddc754a08ba95775d7b57573eadc5e39f95ac6"
  head "https://github.com/igbinary/igbinary.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "99aad111cbc65255750abb227c8c233375cac8868bc147d4d13834bd0c4bb637"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "71a437645d2cc5f4f646398625a906a54ff3ba42336728320dbf85b3c4ec6aa7"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "5342a4d6e4483874de660f2a971236a8a9dd7373b5dedc35dc31787140b79d3c"
    sha256 cellar: :any_skip_relocation, ventura:        "700109b665997fa03a91169b79299a9d2a9663d81e12d8cb7d3c1312470bded7"
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
