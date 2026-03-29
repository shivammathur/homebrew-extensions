# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT71 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "7a8f34acbbb33bc2c8f1b30ae7a2d8d2c47c9c03426e85a32efe241705949463"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "d13b7d420ade7ea9769c2be7f4f4e72fccd546fe621f282f4cbe1a36b986fce3"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "c7ee5e4fc1bfef3d6af2cf310419bd11e0f45ee3759beeb9cc56bc03e0e9e413"
    sha256 cellar: :any_skip_relocation, sonoma:        "d368c80624296bcb402c2c82664a3f7dfb48b88982910015c4b6dffbe9805b7c"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "e1c24b1471d0ea69ebedbf54dc412370a62c57cf307f8cd78cbcd963e3f6a81b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "536e0528ec39e8f72f1de4454efff8da56bda28a3408c539d6ab11c1eeafc905"
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
