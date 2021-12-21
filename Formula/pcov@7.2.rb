# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for PCOV Extension
class PcovAT72 < AbstractPhpExtension
  init
  desc "PCOV PHP extension"
  homepage "https://github.com/krakjoe/pcov"
  url "https://github.com/krakjoe/pcov/archive/v1.0.11.tar.gz"
  sha256 "2ca64444a8f02401e60637b2ab579b952a542e4193c5a47f4bd593c348fb4aad"
  head "https://github.com/krakjoe/pcov.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "43770ad692037c9b53f3774ecb4d66857493743dc645f0f5ea0dd4eaaefc8cb9"
    sha256 cellar: :any_skip_relocation, big_sur:       "31b69d82bffbf34daa819aac473f73adfaa78eeaa2af2dc995f3c5ced4ddb753"
    sha256 cellar: :any_skip_relocation, catalina:      "1b6ff251cbca8ce4602387a62936e87aa9decf608bc4af36c8a784e9b2915b9c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "4c6876c503304ced954e9ba1a2d771857b10ed64513b73844d254c28ca4251d8"
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-pcov"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
