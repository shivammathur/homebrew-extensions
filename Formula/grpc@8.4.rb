# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT84 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.57.0.tgz"
  sha256 "b1ae19706fd3968584ed3079986b4cf1d6e557fc336761a336d73a435b9a7e60"
  head "https://github.com/grpc/grpc.git", branch: "master"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "fb4db74ecf6b93816173057087906e8a0db534b5fc3ef4a434fcb1aa7f0e2fad"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "f40ef739f4b77aa776c9c59aa9ddecd8fc7f2b5a25dac4484e4a1b30f6a7989c"
    sha256 cellar: :any_skip_relocation, ventura:        "a4202d99a80278d55bd1216baf57ec11a7a6be82299c57b6a4e47992146ce58b"
    sha256 cellar: :any_skip_relocation, monterey:       "0e74a7387b8960410a1319b156003467755154a269931822be2d00ebc4c09317"
    sha256 cellar: :any_skip_relocation, big_sur:        "7ed33adc64a2dd54491c78fe07e0ee6f7abdc90213e727ed91299899d5a13a58"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "4cc6e502b013ab8fc2d5d0323457b1be189f49f0ebf2854b488d39db80e7319e"
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
