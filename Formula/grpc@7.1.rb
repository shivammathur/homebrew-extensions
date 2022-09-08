# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT71 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.48.1.tgz"
  sha256 "74e22f8eaf833e605e72ef77df3d432bc6d99647df532d972f161874053859e0"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "c98921c2a7c6f2a1004a0727a14fe902566cdd171ea2a4867647c2f3c21c22fa"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "5171e0a337c54abaead85ce53132996a74a9a8d2ceecaa670976943ba61f366f"
    sha256 cellar: :any_skip_relocation, monterey:       "f0f2c43393407a0787840d25e0c8c710cb6d63a0b7ba1541f3756fd08fb1de5f"
    sha256 cellar: :any_skip_relocation, big_sur:        "417cd52aa024aee2cda620eece4263bb428a58e9b5152342494106dc35ed2e46"
    sha256 cellar: :any_skip_relocation, catalina:       "3f6b9e1c9322a5f7d228704d88da4ac052c3c04788fd967a7c4f729eaabacb4c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "128954f52085a0fae60548baae39052f0359d24ba125a6f0c1a900dc2c1bddf9"
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
