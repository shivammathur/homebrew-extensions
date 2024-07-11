# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT84 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.65.0.tgz"
  sha256 "bee9d16d8512189498708bb72b4bc893c1480cc39012045561de67f9872d6ca0"
  head "https://github.com/grpc/grpc.git", branch: "master"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "7353bc0c639ec8c9888b840783123ffb1c01ef0bbeee7867fdaac99e285f672d"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "cc75f76915ff90defc694ee54c649264da6bd5ee576106da1a00b4bee70dcd3b"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "bf9ec0bc1e82319d60fe630e534455f470d82c98cb12778f2840ba0371ad3bfd"
    sha256 cellar: :any_skip_relocation, ventura:        "ca218816482a28d5ee5708dc219085e66c49b8cb347094e56050cd86bad6a2ad"
    sha256 cellar: :any_skip_relocation, monterey:       "eda90391dea086cb911d92c91cc60f18441c5a56c078bd93a42b81acd7d6cd90"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "fc9db40386469d5ec3bac84c2583a4756d8d786c115fa0848655ee3c13c1ad8e"
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
