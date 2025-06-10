# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT84 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.73.0.tgz"
  sha256 "63959dc527c60cdb056842c5e5ebb45b507452bb121653604ed94c1c23972c7d"
  head "https://github.com/grpc/grpc.git", branch: "master"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/grpc/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "01595130a7abd5ed5502e89a26917637e298c1fdeb847790f9fa28315f786226"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "b07f25b8608a6b3d404eba32d16c9130af9766ad1b0dd1971d3263a5ca913a06"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "2ef871a4fd1b16ba8e77fb94e092c50c0ccc9edf8f203d753067e59525959495"
    sha256 cellar: :any_skip_relocation, ventura:       "9a7ef80383ca03e8e45fa3657eb36cebcd1531bf70acca796813dcf36375675c"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "3fd02e66e315950fffc216da976a3bea7dbae6537a23c9b6a4d9efd53ae54bfb"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "2e228eadb24a876b20fc6b983bbe1ff966bce774de3a2e7586e071c614577ed1"
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
