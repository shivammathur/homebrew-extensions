# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Igbinary Extension
class IgbinaryAT80 < AbstractPhpExtension
  init
  desc "Igbinary PHP extension"
  homepage "https://github.com/igbinary/igbinary"
  url "https://github.com/igbinary/igbinary/archive/Link--muted.tar.gz"
  sha256 "d5558cd419c8d46bdc958064cb97f963d1ea793866414c025906ec15033512ed"
  head "https://github.com/igbinary/igbinary.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any_skip_relocation, arm64_monterey: "6dd61b4497826b65f34ccb92c3197b36ec8b8fd116a2d3789fa1213c26fed999"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "c98a4597a2a7cb60c64ac2efb555cfa636609854765d033f8022ceace90da811"
    sha256 cellar: :any_skip_relocation, monterey:       "ef6b12af2befeef6d6441816a17ae272c6ff891bd59de5c7c33691bd86963fc7"
    sha256 cellar: :any_skip_relocation, big_sur:        "f23f82a20a9ad58cd4ab54680d5193e1f949fc3532dbe7f4e7c851940725fe02"
    sha256 cellar: :any_skip_relocation, catalina:       "ce922b753dffac0a7f8913c497205708aa5315364dcb9ee12fc5ca87baa65961"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "aef35fe7246673c78983b82f295fb6e72a3140b0b8de3183ad893f99ea6c25be"
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
