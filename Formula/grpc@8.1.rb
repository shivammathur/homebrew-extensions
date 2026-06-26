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
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "82ad6f6e066e4f6796620293c5218456322ceac46f2d120ed673e5202da3959c"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "4ff2c235468bc47b52d039be70b3e2f07482a8f65b94a8597df6ecdd2b840f10"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "a6183cb30a3db41dc21eddf662b42fea336b22e1394a51ff1f401f88d0e6bb59"
    sha256 cellar: :any_skip_relocation, sonoma:        "c18b6f4f5b882c98e4b797b6ea68bf82af7e58068e0fbb9d51d657e4f79efcab"
    sha256 cellar: :any,                 arm64_linux:   "2af36b5fc3421a53a6587683cc05538eb1b06dc1b05d25b658da9e457d8136b0"
    sha256 cellar: :any,                 x86_64_linux:  "7ed6d059a29b10e692a78a4f16f80b048c634baf3cc593293b3e75c0afadcf5f"
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
