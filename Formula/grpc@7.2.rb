# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT72 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.56.0.tgz"
  sha256 "bb3c58314cc4c4c043b70bf7162a4ebae507834bf5c2a014b67ebd8d70109dfe"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "8a4282edca0f96a762f378ce4b5cb1f634a97d482091eae032807d99cf2c53b8"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "a40e7b0eb10fb55008d4a3b4194b20f9f194c1da831f95e970f7279f717f7055"
    sha256 cellar: :any_skip_relocation, ventura:        "91ceaf2a9b6b57e5db67088d83cd3c421536173736753dd31b2a7a25fd7d6a0d"
    sha256 cellar: :any_skip_relocation, monterey:       "13bda1f779bf1762876063bdfe1366d7049dba3c65bd7415c6e0a3ce2a504a4d"
    sha256 cellar: :any_skip_relocation, big_sur:        "81b30216b3681e26086b1efc929e250584d36bee50bf725d396986e21538cc76"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "6d59e2477fe2c28c4ccef613c22e3f5ffdd9465fb69286a31bb384b82d5159b8"
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
