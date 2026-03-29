# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT70 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "b805d61de62acb97c47198e215eb30b79c5b7f8166b4698795506d2ed42929c8"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "b3d0a7e64a8a9688b3c4bd5b05fec9e8079d2c221b1c8fba78a37f4ff8df0e0f"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "178523d46f92476046113db89aaa8ea3c87dabfe47167be120dd8c4fc0333270"
    sha256 cellar: :any_skip_relocation, sonoma:        "8c0b4ee9e98498c76c63636d9c0c6ee50a05520d9b19ca778388b9f310926a28"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "88cd7b3b0177c113e70e1d37e2454ec7f5ea3289b88d910909eaa6dd5bad014c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "d2216c293a7ed6f960199e67b21ec2930eb927796bafad6b21c47de82db1c9bc"
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
