# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT84 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.74.0.tgz"
  sha256 "972ce8a989f2c15a951444950c1febe84eb88e59aeaca29d96e005fe55df1fc3"
  head "https://github.com/grpc/grpc.git", branch: "master"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/grpc/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "2ceea877cb1e2c27d8787d4ba5f6462cfe8ed3192dd607a6fc12a6ff9894b2c5"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "29a8879978850abffb6e2b789b40c6ebe4a196770e6d8b1ba932e56fa51d7d90"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "1e059c5a7d4deddb58a1581669029029e4e72d465ca51edb259d03e363824d23"
    sha256 cellar: :any_skip_relocation, ventura:       "25bcd1e18e3229ede0fdf18e9ce5a7f96d8e2c74bbf7be0e45a3b388d87c7abb"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "5d51226fedbd4ff4f4061fd19685c9cc826421c9735cfa9feba3571b6eed6ba2"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "4ffa733454a9aea08360cef39ea01559708d4b6bd0d586e9cf62501ea1dcfc75"
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
