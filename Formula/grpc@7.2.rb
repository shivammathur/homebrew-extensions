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
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "9fd6c5c259f792197e4c5c27df640c1d59327ed4e6901bd7788c7613b4089490"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "d55016ac9af20167b95a508a00aee0bd14ce497c0fc0450699ef4d41aeec3063"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "e2fc44819eff6c6fa72cc7c7651cc78a1254b2cd26e01b6e87041fa203a83c5c"
    sha256 cellar: :any_skip_relocation, ventura:       "9390106ffdb38116326d5f9fae3b14599cc89fcabd267f4c77786f8af4b90fea"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "9a851a41dc4fc1bf8af205d3362012f1f4a5cd7045a2463b833e6cb405a0399c"
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
