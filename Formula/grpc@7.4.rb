# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT74 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.64.1.tgz"
  sha256 "7eedbce54e29281d8fb97b0924e34d6cb315c5ba12e8a55706ccdde977497d43"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "fd82ae1fa8f98dc891288a5b89e8c8ccebaed01fd1880a32a24fa11e0ca4ae53"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "06bd903c75a6ac8bc7d305b0a3345ff29339e46aefd5a8893c0dec39a6f9c0b0"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "eb9755feef0267520ae7dba40236bbb9ee62d43d315b25e0039c1e97352ec7ad"
    sha256 cellar: :any_skip_relocation, ventura:        "9af06110af8aca26ff08f75b59dc232424462062cb92cbb9480b2de2785b5c90"
    sha256 cellar: :any_skip_relocation, monterey:       "046b9ce30b437e11a4b0842319cfa238399048217da38419f098ed740b43f6e7"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "1b4cd972a15e582e3ebf7af029f4f1b90e85b9cfff06915f1812b5f1b1c0e827"
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
