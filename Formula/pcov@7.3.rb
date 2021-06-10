# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for PCOV Extension
class PcovAT73 < AbstractPhpExtension
  init
  desc "PCOV PHP extension"
  homepage "https://github.com/krakjoe/pcov"
  url "https://github.com/krakjoe/pcov/archive/v1.0.9.tar.gz"
  sha256 "c4c2a1de8e546c00eab8bd2a666028c25d16b8d76829e43280b742ae60e78f85"
  head "https://github.com/krakjoe/pcov.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "dfff932d65ce91477bd0f8f73604c6cc7ceea6c9bfc3d62f69de035c5de0c3e2"
    sha256 cellar: :any_skip_relocation, big_sur:       "8afc12e3d09c1f947e24703f5411b5029c5897d72a6bbaaed07fd6c94c10277b"
    sha256 cellar: :any_skip_relocation, catalina:      "e6f22b8d8acb63589f52c813c06f5e795c9849074262f3d4367d6eb85a24395a"
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-pcov"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
