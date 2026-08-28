# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT74 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.83.1.tgz"
  sha256 "cb06519b1382f57ba6f5358504cb37e933d5a5892553300877fd4f3b04cf0560"
  head "https://github.com/grpc/grpc.git", branch: "master"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/grpc/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "136c82bef8b5520d098900b887fbb600e4b86ca8d7d6e70768336f877a8103d3"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "f0fb5e0f29cfdb9d186db4870a95be57abfc6a6003b89ca0153102850ec21122"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "3c58a95c77cb1ee4a52a3ed9bf065bf94252fd783a33c1e624558a102a0da41c"
    sha256 cellar: :any_skip_relocation, sonoma:        "f7558b19efdbcf15cd75429455262b65533467cc7f5d1b1abacd2567ae81158e"
    sha256 cellar: :any,                 arm64_linux:   "a62916d2573a100aed24ee8383518d72c69acc828ef2b636bd31ecc064f234f5"
    sha256 cellar: :any,                 x86_64_linux:  "dc7088361572ab1fd6593a1ae201677149f749d06dae357e730b668bb707d986"
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
