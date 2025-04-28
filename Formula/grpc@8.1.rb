# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT81 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "b1d0df55e0e4d113f8b6a46022cfdf87068b006c0dac685117f6144781690a35"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "3fce996126eb2996ac708d51f82a1f8aaa1d117e9cd9fc0700d0ef42bd65962f"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "597c2aef80baad3763447d051194471991738309929282e2d3e920c45265fedd"
    sha256 cellar: :any_skip_relocation, ventura:       "05fb2c28b753aa2fdbac8980ca93e734085f7782ae7a3f106f8b9cb34bf60e1f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "e6b059ef319e05cd43692ab040ccb955db4042bfd83b41ecfe85111a162434ea"
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
