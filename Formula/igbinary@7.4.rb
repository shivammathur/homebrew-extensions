# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Igbinary Extension
class IgbinaryAT74 < AbstractPhpExtension
  init
  desc "Igbinary PHP extension"
  homepage "https://github.com/igbinary/igbinary"
  url "https://github.com/igbinary/igbinary/archive/3.2.14.tar.gz"
  sha256 "3dd62637667bee9328b3861c7dddc754a08ba95775d7b57573eadc5e39f95ac6"
  head "https://github.com/igbinary/igbinary.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "8e9073316436e98bda3f581cc69acb03e97e1c8871c8bcd4978fa80b32a2610a"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "a54081fb7d8ef12980e0af04f24131d96540fec35021f054abe0fa22667870d2"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "36ef67cdcaae66185f7e7108b46992323d4b8f000c6ee435c7f47d004dafd629"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "1e88be2ceba0324c6799e63e5b38a8abd0d9ce2e71240cad0beb4aa26d6befdf"
    sha256 cellar: :any_skip_relocation, ventura:        "fd5a8e73417d89b10f6a290f3e2289a5fc598ea20b4967059b8c6e2860728980"
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
