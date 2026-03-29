# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT73 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "f65cd1b1a61bbaf577943c4b15368d87ef6bd8a42720f887acba87751bae36d9"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "7546387eed735656dbdea2e65fdbe29225db045a00588a83b7611450ff543de0"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "55bae7f71f45f39beb2d899d2feb8bc99652b09dd9432d1f8a8c11a91c3ac471"
    sha256 cellar: :any_skip_relocation, sonoma:        "44f74e4275dd7699469c109897444b9b63d2c00f7defcc4151415cfcac6bc39a"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "ac6bd5b26c4b3c1394062ea841f2b978aba20aeae0c9b5e41fb903aa5bce0e4f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "1fae3ad9f5cc3199774944ccc46b44165f2894eeb6593f0339d5c8fcce66d3ae"
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
