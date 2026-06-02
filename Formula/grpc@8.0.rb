# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT80 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.81.0.tgz"
  sha256 "3eae67ce7c8f5e861a9b5472542c541e094bf964f3651f4ef015487640afcdca"
  head "https://github.com/grpc/grpc.git", branch: "master"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/grpc/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "c4e959398575c55ebb39a148a760d168f472541f3ce9b3dd48ff87368d5f56cd"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "9c4c17de8a91896ae09c31b23b02f92c069792df96515a9812b0af1c29eb29a6"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "7b1fcf78d6128ef85ae4a317122614b4d59ed9625ee10c74d337c7dfc3de0f7b"
    sha256 cellar: :any_skip_relocation, sonoma:        "dd45204b3b7b8d37f1d801ea048c5b0a3c3a804d6be965e20c745b54b8a45375"
    sha256 cellar: :any,                 arm64_linux:   "f3b4506df0e7efad1ab6662c204ea5830cf8efc106f4fa7c272bab61ccc3758a"
    sha256 cellar: :any,                 x86_64_linux:  "9918f2121315618d753ce701947180187e6cb9871a2083606719f7738aad99bf"
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
