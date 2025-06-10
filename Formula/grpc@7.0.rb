# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT70 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.73.0.tgz"
  sha256 "63959dc527c60cdb056842c5e5ebb45b507452bb121653604ed94c1c23972c7d"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/grpc/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "13769739fe429a67f3863b6ef148146c953d50b8a187257885c63d80a01c6067"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "82bbd815faa6c1f91b3b3d181eced744728148ee0b00cd97cd54353530a163f2"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "dd280821490a07a5b56f294ab0226e0011c7e409bdc84461c1568672d7fefc13"
    sha256 cellar: :any_skip_relocation, ventura:       "c5676ec0f35d1f58f6a04b6095c38bd6d4798eed324ff29371709a5f53532902"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "2c74e756fe5e42ef87d8fdd4f842f0156e2d3c3ad6f353f066589cd48bc87633"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "6d9237777991a0468e2a2b28350bc92fd71f1dce991bc92fda2119304a02a13b"
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
