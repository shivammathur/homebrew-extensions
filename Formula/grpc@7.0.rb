# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT70 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.78.0.tgz"
  sha256 "c846ac9164930897fea9c55bad52aeb9f99a03cce64e694bd80f781c59baa0a8"
  head "https://github.com/grpc/grpc.git", branch: "master"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/grpc/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "e9533e0de7e9e010f37344df2de2f382a1d8c28d01c5ecd0b91e4058397ddbe1"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "d2fd77c932e97faccf6618e14a1f4aa97461a159c1bdd20e917a74d039e81b3e"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "3d68817a4cbcc8e89e8a4f6ac32ea4f35ca6d6c698874ae20be1166310f2239d"
    sha256 cellar: :any_skip_relocation, sonoma:        "95bc7c41f439c3d6a86510da5e877069d3a6a5d529983d74ef37419a123a6219"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "47cfddc052bd1ddc6d2ea552c2b999701b92f6a175a61c8892c75f7794b20f5a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "1670ac550532ba4b7638b91b2ecc2ae1804c3da46d9c202ea0572d14fcba5226"
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
