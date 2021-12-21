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
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "3bd21b07e2984751d685404a486c2373794d3c5f6b49225b70131763b0b4f1e3"
    sha256 cellar: :any_skip_relocation, big_sur:       "8771c25d54e42298d532748fe415df0e74a0742ee3ddc7c444f87acf82b123c5"
    sha256 cellar: :any_skip_relocation, catalina:      "8f2b095b6187e8f78bcf45d7fe294968f97a76e08b0a90ed4cd6bc30bfb1bfe2"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b0d26f6428fe7715f42e1e3ca2fbcdce552cee938b5aa35f78bf68a5e700e8a4"
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
