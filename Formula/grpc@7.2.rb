# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT72 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "7125c9a0bc765b03019878a842dcd371e3d7f44e9b999032a5ab61e1f5b033a8"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "c3c066e07192dd0b7626700451b91cec6992cfeebe574717286da232a63d2931"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "508f2c5edf02eedb95784779e5704c985d69e78bca97c97ee6f292011efd2c9f"
    sha256 cellar: :any_skip_relocation, sonoma:        "0c5ca0a744ca074b222ffa2a3b9bacdd421eac9c1bb7328bb8d8b9131369eaeb"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "045877af66eb5e1d0f9f0101b893f33128588e7c025f2b5178e0728ac8a6ed49"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "d38646af401981b92d76f264e5d466a4a1803299b8600373376a12d7b8742cd8"
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
