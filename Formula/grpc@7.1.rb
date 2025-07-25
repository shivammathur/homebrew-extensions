# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT71 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.74.0.tgz"
  sha256 "972ce8a989f2c15a951444950c1febe84eb88e59aeaca29d96e005fe55df1fc3"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/grpc/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "9399414681c35708f9bf9f2957fe5d8101d75a35e0acfed9eadb9eb366271708"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "5431c3c3b9d40b0bedc9a099d18f0db742ef218c38e31c8a6054ebcbfe1aabde"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "4ec3344b7f9e48e7ee46a4a5f68519091945cb9b081c40aa7de9e5642206ea04"
    sha256 cellar: :any_skip_relocation, ventura:       "d36e58a447249234316e545dc0261ca7ddddb477f2f22912d0093a67d2ce917c"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "da54e05eec461b2029bddc845530d8a7495eba79f1980396602e660ef2708a12"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "ba14ba7ab88e9cf5d6ad89b68ca68d4c81913b7f8c514baa9331fcf4509183f7"
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
