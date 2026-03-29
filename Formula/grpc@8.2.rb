# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT82 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "4cfc13415d7da532ca0e08fd3812d5add83e18a3955367b683390c0b7d254480"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "c0fff0815bcdfc18027b8845939b1c4fc6d1a9ad9776b8d8de36c8a30911830f"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "49662f7ddbfba0fa454581e14261b402a1ad53ca5951fa5a938b02fe0d30d514"
    sha256 cellar: :any_skip_relocation, sonoma:        "12baa01a0d9868f72be32ebee57310145d729791f659db13d17d42027ddab6c7"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "5aa81d9b9e23b932b530e8fcd07e10a109a3dc7307ac8cfa057065bfc4f1b70f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "e7a4e391b00677d996f6d2ccfc1c39a064aab851a95882bd31347cd5e08ff67c"
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
