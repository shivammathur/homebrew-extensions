# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for PCOV Extension
class PcovAT82 < AbstractPhpExtension
  init
  desc "PCOV PHP extension"
  homepage "https://github.com/krakjoe/pcov"
  url "https://github.com/krakjoe/pcov/archive/v1.0.11.tar.gz"
  sha256 "2ca64444a8f02401e60637b2ab579b952a542e4193c5a47f4bd593c348fb4aad"
  head "https://github.com/krakjoe/pcov.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "cc6f0ff15485222f9941ba716976d23e8a1aac54cc70dc7178ade892c853c11b"
    sha256 cellar: :any_skip_relocation, big_sur:       "a4a109433afb62cb5f110a3075daa3e63f1f159430ec34991312eacb4376ee7a"
    sha256 cellar: :any_skip_relocation, catalina:      "d6cb2160af8ee2e9f7735ee36e3860ad85a45088078bc5d1e8d7757f8744b601"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "ebb16767ddda960f7dff3a0796970ed1286ced2457decb6e4c7cc5338f8f6926"
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
