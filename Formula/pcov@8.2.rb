# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for PCOV Extension
class PcovAT82 < AbstractPhpExtension
  init
  desc "PCOV PHP extension"
  homepage "https://github.com/krakjoe/pcov"
  url "https://github.com/krakjoe/pcov/archive/v1.0.12.tar.gz"
  sha256 "fdd07cad8e2ff42f0c9f095d84aeef11dab0fde7a008805f61883cbcb1b3f12b"
  head "https://github.com/krakjoe/pcov.git"
  license "PHP-3.01"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "93a9420ca826b1505edfb20eb16ea5bc90a3b2b9cf33c55900ae67d15f602379"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "b359f383054ed5a6dcdde40f410a9aaa213336d0fb5a9526f99ea3fda1d98bbe"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "b61cc0cb38bf94331005ca89f3b0c7720349f105bc45200d8e3cefd5e57411b0"
    sha256 cellar: :any_skip_relocation, ventura:       "ccf839be6736494ed469acede0a5b42f3601ca00cd5149da5624c7cf447651c7"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "200154e938c0cc5a29754cfa94325e9f9d664fee2b215d3aac97ab60849fc944"
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
