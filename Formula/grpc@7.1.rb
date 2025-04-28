# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT71 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "1f4cac31562cc5d950d81f626e3a248f6c3d40a4e39213faeed5a995acbaab4a"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "952d210e1d6ee1f7bf1b58429b1856ef7668c16d7343863e80f51677a281cd47"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "f3e9712c50b3364ec21c57ed2273cf30f33982ac6fb8d4f95ce2588a9f8c125f"
    sha256 cellar: :any_skip_relocation, ventura:       "c538fb452f7935a9a0928c1a54fd3121f9a6618f4e47b32ab1412d9a4b2ea18c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "167a048b46d65e1da3ea70af0046c246a294def771028dba89f457aa65c46667"
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
