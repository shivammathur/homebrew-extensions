# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for PCOV Extension
class PcovAT80 < AbstractPhpExtension
  init
  desc "PCOV PHP extension"
  homepage "https://github.com/krakjoe/pcov"
  url "https://github.com/krakjoe/pcov/archive/v1.0.11.tar.gz"
  sha256 "2ca64444a8f02401e60637b2ab579b952a542e4193c5a47f4bd593c348fb4aad"
  head "https://github.com/krakjoe/pcov.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "47ea0f429f16c78d5d74864b931213c2fe970136caaf36a42360b6932f424331"
    sha256 cellar: :any_skip_relocation, big_sur:       "195d80639b8e243851fece59d084fccfcebc71e8160cf62fb2fd505ae26d3d28"
    sha256 cellar: :any_skip_relocation, catalina:      "569b9d36b64d32aa21cc58fc670f2d3d260a93b3e12f5c4fd1a362568c16a2ed"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "beaa97726b0fc5674db0c99366211b2f78935a59ee0fe6bd3505dfab995f6e8a"
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-pcov"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
