# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT83 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.53.0.tgz"
  sha256 "10b214a785205bf8c5b3b8ebbeeddfdabce63a9c44399f250ba26763ae5646ab"
  head "https://github.com/grpc/grpc.git", branch: "master"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "942e94c35f3b5504b5b14eeb1964531edd14f63b720815c0c415c48793fd002f"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "c2e4fb16784daa740f5a96457ca82b105e292fcceaf87d53d60272338fa19fcb"
    sha256 cellar: :any_skip_relocation, monterey:       "ff5a766c73de001086720ec4db2584ed69c3a083a1d60a0f100cba3e61c0a864"
    sha256 cellar: :any_skip_relocation, big_sur:        "b4ca6eebeaa4f27b106563f04eba42599c2de274a8d593b67060b040a7bac0ee"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "311cb6cfd6ad22a91111fdd5786cf32a094c518adc56a9af1190258935b4dc6d"
  end

  depends_on "grpc"

  def install
    Dir.chdir "grpc-#{version}"
    patch_spl_symbols
    safe_phpize
    system "./configure", "--enable-grpc"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
