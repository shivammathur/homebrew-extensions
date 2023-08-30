# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for PCOV Extension
class PcovAT84 < AbstractPhpExtension
  init
  desc "PCOV PHP extension"
  homepage "https://github.com/krakjoe/pcov"
  url "https://github.com/krakjoe/pcov/archive/v1.0.11.tar.gz"
  sha256 "2ca64444a8f02401e60637b2ab579b952a542e4193c5a47f4bd593c348fb4aad"
  head "https://github.com/krakjoe/pcov.git", branch: "develop"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "b3ade73afdd96a2a8b9ef39bc4b1b962b4466ec757bb3a76cc216e758d31e8ce"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "c521cbc88b5af224180b39fdc575c71e98b167fef6f2a3e1e1dd5b89ea85130c"
    sha256 cellar: :any_skip_relocation, ventura:        "45e7df14f4999208c5ff8afae3c302d657ceb4e5e58abfcfdcc36064e7941e34"
    sha256 cellar: :any_skip_relocation, monterey:       "97d88d8275492cbffb0b083a2a73162369e2b0326ef60e3eb43b2fcb62a155c1"
    sha256 cellar: :any_skip_relocation, big_sur:        "9eec6ce1a405263fdf94a7b961bb90b7370d4bcafe35fdfa30801e4cb9985b36"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "ad6976dc510a66538c264a13a244acec65b521c14e6f485fa829e8adc6277a47"
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
