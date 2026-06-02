# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT73 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "c2f9fde1e3df7fcaa87cc54e8bb6b5cf9c28bd33e0f62a8eb7d1928104fdf35d"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "f3c230dd33956e70de9f9bba47e56e50b65744701bcd61a37d0817f606118e50"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "729bbef684e33fdcc804d83dec81b984928ac067ac9fcfea41a2ac8867a18e77"
    sha256 cellar: :any_skip_relocation, sonoma:        "23212680d5ae1ac7056293e53b589b05048f10ce2a759904d3aa3ca3b07d1309"
    sha256 cellar: :any,                 arm64_linux:   "887a8e8d2732d4fc6fe74594db1e2825e692383f373f3590c0e184a02497aa78"
    sha256 cellar: :any,                 x86_64_linux:  "d7d5250a9fd3ed1aa2044e8a8fad726bd4780525f79a87f0c8f6ed86d72d3dba"
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
