# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT80 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.47.4.tgz"
  sha256 "8f892ee4996874d389db1bb332324bd337e2420471262775e702d9222319fc0c"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "b5b3d84387409e55bb15ad715cf9dbda525362c34ec86fff977c3e8fdc46f004"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "78a38b4ad5c11ea58c83db8e6ec2b2817b0fcba7f246193d2458ea134dbfebd6"
    sha256 cellar: :any_skip_relocation, monterey:       "20f71f22b175c1fe33b2d3dbbbc7d6fb38da46b0d93436ceeadd68607587ec71"
    sha256 cellar: :any_skip_relocation, big_sur:        "c35f6c74dd22277db6b362c4b84bc08c00dde5444654d962b30db758efcea96b"
    sha256 cellar: :any_skip_relocation, catalina:       "7bb6c76e3344a5643fbf572defdc0196e18c50ba98e28e94e758bcf8e3eca529"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "c683a67b1af3c146d5a26a4d282a1f41015ce3c7d7d77ea294b485cbff2c718f"
  end

  depends_on "grpc"

  def install
    Dir.chdir "grpc-#{version}"
    safe_phpize
    system "./configure", "--enable-grpc"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
