# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT83 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "6512332fd20c38d6e2cf2194ed1642458328d2a18cb0f0376bd8fd29963e1c63"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "7ddf8cf37bb3b790c854c749bd0924ec8a1ffc4acc2a2ea6f888c2d18282fffb"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "3086ec86584de8b9a3eae19cf21843323f3b5df86f642c522e0ae080f8baecde"
    sha256 cellar: :any_skip_relocation, sonoma:        "574b8e9d8f735ec4d15c66c3844837a2764e6fb56b53a495b9643b59011292af"
    sha256 cellar: :any,                 arm64_linux:   "ca597ae3873eae895e5d55c203582f55fe0f0b4ad21b1effe5a662304c9a94ab"
    sha256 cellar: :any,                 x86_64_linux:  "ab698f4a719d44d69362723110fb0b6d9f6a82af9efed1b3936bd5373a3be01c"
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
