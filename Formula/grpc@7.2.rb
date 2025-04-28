# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT72 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.72.0.tgz"
  sha256 "715fe230c0b185968e92f8f752d61a878f9eb5346873848e47ff65d0af6947dc"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/grpc/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "664b75c9aa6a4ea018697d3199326208bf8e196b9ddad515e7f83d242813a38e"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "40d4fac9d030eee771cb040d3ad4ce2d6aa7555648841319b2fd93050841590f"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "9f1a8ab39a4c724b9a0f45d8bf3e54f314d3a0d6b9e8b581b837c6c4c2a63a78"
    sha256 cellar: :any_skip_relocation, ventura:       "058beac86a61c7e646ef0cbdce39f2674f77d027de451295795d7274d36221b3"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "32c29a046cc43950043e16da286479b53ceda5b34736911a03d19bf1bccae8ec"
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
