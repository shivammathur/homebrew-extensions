# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for PCOV Extension
class PcovAT73 < AbstractPhpExtension
  init
  desc "PCOV PHP extension"
  homepage "https://github.com/krakjoe/pcov"
  url "https://github.com/krakjoe/pcov/archive/v1.0.11.tar.gz"
  sha256 "2ca64444a8f02401e60637b2ab579b952a542e4193c5a47f4bd593c348fb4aad"
  head "https://github.com/krakjoe/pcov.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "49336d3804cce5f765dc7074a5e4ae649be040f659fc2ac1508f27bcb10ffc83"
    sha256 cellar: :any_skip_relocation, big_sur:       "d776ea2b35549ef345d5cb98086e5837a9f1c90bb6b49ca245dcc28acec2070f"
    sha256 cellar: :any_skip_relocation, catalina:      "266a6f6ec2bbe64346a9d98ff2291c70240bdc34ab87526ddc5fe18f733aa17d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "fdf3bc09c8a5c1e744c00f710c7bff689fcb954415e0c5443674a00d6206010b"
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-pcov"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
