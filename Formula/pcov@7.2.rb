# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for PCOV Extension
class PcovAT72 < AbstractPhpExtension
  init
  desc "PCOV PHP extension"
  homepage "https://github.com/krakjoe/pcov"
  url "https://github.com/krakjoe/pcov/archive/v1.0.12.tar.gz"
  sha256 "fdd07cad8e2ff42f0c9f095d84aeef11dab0fde7a008805f61883cbcb1b3f12b"
  head "https://github.com/krakjoe/pcov.git", branch: "develop"
  license "PHP-3.01"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "a225bdc7e068210d03280002c05b69e57fc00c2ab911a0ca464b9fdcee62dd83"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "7b33a3ebe9e0a9dbf4daaa8e3b68983754104f41dd780021db110d798ec88d68"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "f48326c116a6f14bc9ec5062d6894c4fbe333350bad0879cd1bd671ff65d4a89"
    sha256 cellar: :any_skip_relocation, ventura:       "d7207e8595adaadb7a55d22c3882aee2dae384ab7e97870e77b52432eeaa2cd9"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "603e8331002935381c7a3c41ae9054c5ebd57c13f6c89f954262faabd10506db"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "7ade2be9e4b9da4facd19ad13762f799d5c05764769601a00ce4c2afe888aab3"
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-pcov"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
