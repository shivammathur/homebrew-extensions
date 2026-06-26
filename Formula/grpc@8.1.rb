# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT81 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.81.1.tgz"
  sha256 "3c9086743a29bda3b5bd323e31f9c6da6e04900288ab37f0da1df8859a2ee8f5"
  head "https://github.com/grpc/grpc.git", branch: "master"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/grpc/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "9b66686eb9b918b4835e599d843141aa00f2f8a62ab0c12c11781bf13e4a8665"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "74c8074f7d594497a03bfa6704be4b9b32f29176c463e9d745667e83b62f47a5"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "b471440a5a357d0db82c201f07abbe11f19d946530b2d92347339ddeab18c0ff"
    sha256 cellar: :any_skip_relocation, sonoma:        "685510eeb84dd9395ef9522efbedf3cdc4d2f2d018f2b97b8ddafcac3f2e8b18"
    sha256 cellar: :any,                 arm64_linux:   "4f77d16ecb52940898f073efc38f18294882d7b4b0d6701a07524360c553da6e"
    sha256 cellar: :any,                 x86_64_linux:  "74d2150031a690361f21f6a1d38987b28eafe36d06537b8c5428b3bbfd704c3d"
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
