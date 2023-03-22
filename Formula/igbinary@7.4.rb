# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Igbinary Extension
class IgbinaryAT74 < AbstractPhpExtension
  init
  desc "Igbinary PHP extension"
  homepage "https://github.com/igbinary/igbinary"
  url "https://github.com/swoole/swoole-src/archive/v5.0.2.tar.gz"
  sha256 "14d442d5e945fe67a3e912d332175b2386a50c38a674c4559d2d0211db23362e"
  head "https://github.com/igbinary/igbinary.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "36ef67cdcaae66185f7e7108b46992323d4b8f000c6ee435c7f47d004dafd629"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "1e88be2ceba0324c6799e63e5b38a8abd0d9ce2e71240cad0beb4aa26d6befdf"
    sha256 cellar: :any_skip_relocation, monterey:       "664ac2d43bd809e33366359a2cfc3670e8829cf00f8c506079a456694e3418a2"
    sha256 cellar: :any_skip_relocation, big_sur:        "450e20bcd3e9988a0cf498eaab943f22526345ee574eba0297e2939fd7000dde"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "a88d30352a75c7793f26c308eb7650f2a0c95e5e56c505a5f84bac225b75297d"
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
