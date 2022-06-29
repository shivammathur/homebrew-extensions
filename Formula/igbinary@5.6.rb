# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Igbinary Extension
class IgbinaryAT56 < AbstractPhpExtension
  init
  desc "Igbinary PHP extension"
  homepage "https://github.com/igbinary/igbinary"
  url "https://github.com/igbinary/igbinary/archive/2.0.8.tar.gz"
  sha256 "96d2ff56db2b307b03f848028decb780cb2ae7c75fa922871f5f3063c7a66cb2"
  head "https://github.com/igbinary/igbinary.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any_skip_relocation, arm64_monterey: "cbfebbb94d5c640321ad00dd67e5a5889b594129b7508c3611a297da4de267f0"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "3f1f3f1b3d771fa2a5640a595013ca852c849f1d1b4896e01d79de94d79ae30e"
    sha256 cellar: :any_skip_relocation, monterey:       "0056fb6614d5048cc337b5634afb0f9b4711efa45c59ccfa55da129c3c0168b5"
    sha256 cellar: :any_skip_relocation, big_sur:        "552ac69251f7f275ad55c380c572d4e5a75f1f1b2d8e12faa77f67814ecddb71"
    sha256 cellar: :any_skip_relocation, catalina:       "d78de0516515ec5ba3d46b8a6ab8445b7abd3b01a5fa245a34a2f4052300f37b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "287c226c612e502f456953128a7e8ffa35fccfd7d77e153beaf1a0fe5293a8e1"
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-igbinary"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    Dir.chdir "src/php5"
    add_include_files
  end
end
