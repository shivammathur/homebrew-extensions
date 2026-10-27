# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT84 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.85.0.tgz"
  sha256 "adaf30db949767bf0ff5a5308638e4b9bb5f711733204ed5a5e8f3014d80a174"
  head "https://github.com/grpc/grpc.git", branch: "master"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/grpc/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "7d748d7154d2b365ee686c6ef07b71658081a333f3fabc689e655748690f3887"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "571f5dd4fdd6b44c66c4809cfa21963a4956937b6555fa668ffdaac6e1247623"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "630c80c8734915e0ed57c651747d32e2b99c85243cbe7c86ed999ec45207f11a"
    sha256 cellar: :any,                 arm64_linux:       "770ee9f646c95de5e3de89aa5deadc60517857969e80432403dc59f356f164fd"
    sha256 cellar: :any,                 x86_64_linux:      "7b72ee1b1224fd096ed891f53510c53399da5083e7befc5f50ffd84aca0cbfbf"
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
