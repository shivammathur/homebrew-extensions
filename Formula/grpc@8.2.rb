# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT82 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "4f4aca5f629523f2f42f540f31592d9404613a3f8ba4424acf3728aadca1ede4"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "6d4fff777cfb8526da746d8590ebb52adf1795bd674170c57122ddd7f3fee7a9"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "f8a4f375fabea4442aba50cf2d1154a83abbaeb14e248f857e8c1310d3602535"
    sha256 cellar: :any_skip_relocation, ventura:       "ee6f2eaf4b1d0ab4f3e16660a96dc2b7969feb7a9687f0a708f8514afc8f6e6b"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "8fbdfe15d5f83945de750394e1a8f862452290c07945fd8fabcab736443d3cd0"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "2b104eb1d7b8ebc5c0ee285a58d95d22c3d223aeb181351f97b0eb8c871aa696"
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
