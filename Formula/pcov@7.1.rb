# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for PCOV Extension
class PcovAT71 < AbstractPhpExtension
  init
  desc "PCOV PHP extension"
  homepage "https://github.com/krakjoe/pcov"
  url "https://github.com/krakjoe/pcov/archive/v1.0.11.tar.gz"
  sha256 "2ca64444a8f02401e60637b2ab579b952a542e4193c5a47f4bd593c348fb4aad"
  head "https://github.com/krakjoe/pcov.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "2095ac3715847111fea85bfcc7667f06fdead2d17e562aa9c29591725f5b4a12"
    sha256 cellar: :any_skip_relocation, big_sur:       "29f11e5ed3f37151b627a09feff9d07e301d2067fca44b762c258ee2398c0845"
    sha256 cellar: :any_skip_relocation, catalina:      "5fd6ca65b465038625ea0d588d5f536daa87442e955f833f7c0900e696950268"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "1c9ca9cd1d81baaf7e617728b8fcf8cb93a105b385f06670b0cb5ccf6a02f11e"
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-pcov"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
