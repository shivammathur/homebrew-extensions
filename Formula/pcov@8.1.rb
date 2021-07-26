# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for PCOV Extension
class PcovAT81 < AbstractPhpExtension
  init
  desc "PCOV PHP extension"
  homepage "https://github.com/krakjoe/pcov"
  url "https://github.com/krakjoe/pcov/archive/v1.0.9.tar.gz"
  sha256 "c4c2a1de8e546c00eab8bd2a666028c25d16b8d76829e43280b742ae60e78f85"
  head "https://github.com/krakjoe/pcov.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "676e37e7a9177101eba884745bfc4a02ef022e228507400bdb63c6fb940a6d9b"
    sha256 cellar: :any_skip_relocation, big_sur:       "db358fc96661381215b3cd6ccea8c14ca06de1ca7708e1b1c1b46b16a378ac2e"
    sha256 cellar: :any_skip_relocation, catalina:      "718d44a40baebd50fe26aca4b863b83b0e496ac465e62ce959c562cfe6ddc911"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "2a4007cd038771638e37e2be23679e7f0467d8e674c04b118bbd62b446849ab9"
  end

  def install
    patch_spl_symbols
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-pcov"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
