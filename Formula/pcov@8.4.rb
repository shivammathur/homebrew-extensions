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
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_monterey: "900a85aa767f748258034b656aa7c544d29b88e7cfb1bba8745d1ae9bcad6d07"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "8b6912634c078ebbb5104a8d26289ef3f8ee16d260badf510eecb14ac348614e"
    sha256 cellar: :any_skip_relocation, ventura:        "ef462365587a6fdd7d985080afe955f9afdad06a50d51c0e145ff74f9afe6338"
    sha256 cellar: :any_skip_relocation, monterey:       "92ca58022ed139a35852cc29da72ada14bd3a41492314ebfcc8722df6098b63f"
    sha256 cellar: :any_skip_relocation, big_sur:        "717c20af02c34718b177ff166e639c1565d6cbef0c935b5ae0a5df6485b2f523"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "bd9eb1b0b8c3a7aabe2b33b14fd5b2951a7bc93474d032c1f1c42eb6b2179625"
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
