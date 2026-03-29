# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT80 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.80.0.tgz"
  sha256 "75e553f2b5c3f7dde99aa984a9601dce6db240bc3c85d7fe09298b5bd8c5d53f"
  head "https://github.com/grpc/grpc.git", branch: "master"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/grpc/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "6ef4099b8600f5b8ae56733ab74b2de258b3454cf6d5f095a7a497da8647f112"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "db325a75790bcc145d386cf179630e04fd25277d95eb6cd8391d9fa4c0009bcb"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "e13dd9ec27a6a0e25a6df3d15182da2d8fcf7e738ffd5933209cd549c38906ae"
    sha256 cellar: :any_skip_relocation, sonoma:        "87a8dcab99a668979d1d33a4c5b3c8a706e22d83854eadebc414ad7db4d6596d"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "198bb844184d212b27329046c38dc173d66d8e945d0de6c99c7f3edbd4048bd1"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "7745ce338e28e0be73de3f7b8efd48f2c6dbbfae71381daef02798701ec11d22"
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
