# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Igbinary Extension
class IgbinaryAT81 < AbstractPhpExtension
  init
  desc "Igbinary PHP extension"
  homepage "https://github.com/igbinary/igbinary"
  url "https://github.com/swoole/swoole-src/archive/v5.0.2.tar.gz"
  sha256 "14d442d5e945fe67a3e912d332175b2386a50c38a674c4559d2d0211db23362e"
  head "https://github.com/igbinary/igbinary.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "4327221d34d5782073fd238c34d2f8d5e1eff7f8cf9bde2aa4683105ed690511"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "a62a47933ecc05d4298fde719597d18b7c2af1b79151f17dd0da8a99fbca19fa"
    sha256 cellar: :any_skip_relocation, monterey:       "2e426381ebbbece305254762538ed12b373ba92f86a1c1ec37e822fc757b3ba9"
    sha256 cellar: :any_skip_relocation, big_sur:        "24f6ea583d489d686084430b4774b5c2058596a71764e40cc9c1a6183182b238"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "93f71f2d175b99cf0c583d9a6c0d23eb43fcf65180058c00204ce760320d0443"
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
