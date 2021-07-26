# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT80 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.39.0.tgz"
  sha256 "912bd2d2bd9d5b6e2ed861a79316a14811aac6f8e1a93c82dfc993430639d004"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "58f71b4fdfe9c90a12aa34510033a90146168d90c4b6d309b73b8f435698bc8b"
    sha256 cellar: :any_skip_relocation, big_sur:       "ae43598743a51bf45c4b47f6cb7c304bacccfee1ee6c37edc78454d65d963a58"
    sha256 cellar: :any_skip_relocation, catalina:      "0e2806402ddbce83b869729c99e8de9d401217214f75907e15e8ff29aab45788"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "a78ed90012bfd7bde8fa10097b9487b9a62ba33e5fb45fa8d770ac84657a06de"
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
